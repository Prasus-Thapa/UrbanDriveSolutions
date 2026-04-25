package com.vehicle.urbandrivesolutions.dao;

import com.vehicle.urbandrivesolutions.entity.Booking;
import com.vehicle.urbandrivesolutions.utils.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // ── Shared SELECT fragment ──────────────────────────────────────────────
    private static final String BOOKING_SELECT =
            "SELECT b.booking_id, b.user_id, b.vehicle_id, b.pickup_date, b.return_date, " +
            "b.total_amount, b.booking_status, b.cancellation_fee, b.cancelled_at, " +
            "u.full_name, CONCAT(v.brand, ' ', v.model) AS vehicle_name, v.registration_number " +
            "FROM bookings b " +
            "JOIN users u ON b.user_id = u.user_id " +
            "JOIN vehicles v ON b.vehicle_id = v.vehicle_id ";

    // ── Read ────────────────────────────────────────────────────────────────

    public List<Booking> getAllBookings() {
        String sql = BOOKING_SELECT + "ORDER BY b.booking_id DESC";

        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                bookings.add(mapBooking(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all bookings.", e);
        }
        return bookings;
    }

    public List<Booking> getBookingsByUserId(int userId) {
        String sql = BOOKING_SELECT + "WHERE b.user_id = ? ORDER BY b.booking_id DESC";

        List<Booking> bookings = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapBooking(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching user bookings.", e);
        }
        return bookings;
    }

    /** Fetches a single booking by bookingId + userId (ownership check). */
    public Booking getBookingById(int bookingId, int userId) {
        String sql = BOOKING_SELECT + "WHERE b.booking_id = ? AND b.user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapBooking(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching booking.", e);
        }
        return null;
    }

    // ── Dynamic availability check ──────────────────────────────────────────

    /**
     * Returns true when no PENDING/CONFIRMED booking for vehicleId overlaps
     * [pickupDate, returnDate).  Date-overlap condition:
     *   existing.pickup_date < newReturn  AND  existing.return_date > newPickup
     */
    public boolean isVehicleAvailableForDates(int vehicleId, LocalDate pickupDate, LocalDate returnDate) {
        String sql = "SELECT COUNT(*) FROM bookings " +
                     "WHERE vehicle_id = ? " +
                     "AND booking_status IN ('PENDING', 'CONFIRMED') " +
                     "AND pickup_date < ? " +
                     "AND return_date > ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, vehicleId);
            ps.setDate(2, Date.valueOf(returnDate));
            ps.setDate(3, Date.valueOf(pickupDate));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error checking vehicle availability.", e);
        }
        return false;
    }

    // ── Write ───────────────────────────────────────────────────────────────

    /**
     * Creates a booking + pending payment record in a single transaction.
     * Availability is now checked dynamically via date-overlap query —
     * vehicles are never permanently set to BOOKED.
     */
    public void createBooking(int userId, int vehicleId, LocalDate pickupDate, LocalDate returnDate) {

        String vehicleSql      = "SELECT price_per_day, availability_status FROM vehicles WHERE vehicle_id = ?";
        String availSql        = "SELECT COUNT(*) FROM bookings " +
                                 "WHERE vehicle_id = ? " +
                                 "AND booking_status IN ('PENDING', 'CONFIRMED') " +
                                 "AND pickup_date < ? AND return_date > ?";
        String bookingSql      = "INSERT INTO bookings (user_id, vehicle_id, pickup_date, return_date, total_amount, booking_status) " +
                                 "VALUES (?, ?, ?, ?, ?, 'PENDING')";
        String paymentSql      = "INSERT INTO payments (booking_id, amount, payment_method, payment_status, transaction_code) " +
                                 "VALUES (?, ?, NULL, 'PENDING', NULL)";

        try (Connection connection = DBConnection.getConnection()) {
            connection.setAutoCommit(false);

            try {
                // 1. Fetch vehicle
                BigDecimal pricePerDay;
                try (PreparedStatement ps = connection.prepareStatement(vehicleSql)) {
                    ps.setInt(1, vehicleId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            throw new RuntimeException("Selected vehicle was not found.");
                        }
                        if ("MAINTENANCE".equalsIgnoreCase(rs.getString("availability_status"))) {
                            throw new RuntimeException("This vehicle is currently under maintenance and cannot be booked.");
                        }
                        pricePerDay = rs.getBigDecimal("price_per_day");
                    }
                }

                // 2. Check date availability (inside the same transaction to prevent races)
                try (PreparedStatement ps = connection.prepareStatement(availSql)) {
                    ps.setInt(1, vehicleId);
                    ps.setDate(2, Date.valueOf(returnDate));
                    ps.setDate(3, Date.valueOf(pickupDate));
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next() && rs.getInt(1) > 0) {
                            throw new RuntimeException(
                                "This vehicle is already booked for the selected dates. Please choose different dates.");
                        }
                    }
                }

                // 3. Calculate amount
                long rentalDays = ChronoUnit.DAYS.between(pickupDate, returnDate);
                if (rentalDays <= 0) {
                    throw new RuntimeException("Return date must be after pickup date.");
                }
                BigDecimal totalAmount = pricePerDay.multiply(BigDecimal.valueOf(rentalDays));

                // 4. Insert booking
                int bookingId;
                try (PreparedStatement ps = connection.prepareStatement(bookingSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, userId);
                    ps.setInt(2, vehicleId);
                    ps.setDate(3, Date.valueOf(pickupDate));
                    ps.setDate(4, Date.valueOf(returnDate));
                    ps.setBigDecimal(5, totalAmount);
                    ps.executeUpdate();
                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        if (!keys.next()) {
                            throw new RuntimeException("Booking could not be created.");
                        }
                        bookingId = keys.getInt(1);
                    }
                }

                // 5. Insert payment (no vehicle status update)
                try (PreparedStatement ps = connection.prepareStatement(paymentSql)) {
                    ps.setInt(1, bookingId);
                    ps.setBigDecimal(2, totalAmount);
                    ps.executeUpdate();
                }

                connection.commit();

            } catch (RuntimeException e) {
                rollback(connection);
                throw e;
            } catch (SQLException e) {
                rollback(connection);
                throw new RuntimeException("Error creating booking.", e);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Database error while creating booking.", e);
        }
    }

    /**
     * Marks a booking as CANCELLED, stores the cancellation_fee and
     * records cancelled_at = current timestamp.
     */
    public void updateCancellationStatus(int bookingId, BigDecimal cancellationFee) {
        String sql = "UPDATE bookings " +
                     "SET booking_status = 'CANCELLED', cancellation_fee = ?, cancelled_at = CURRENT_TIMESTAMP " +
                     "WHERE booking_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setBigDecimal(1, cancellationFee);
            ps.setInt(2, bookingId);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Error updating cancellation status.", e);
        }
    }

    // ── Mapping ─────────────────────────────────────────────────────────────

    private Booking mapBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setUserId(rs.getInt("user_id"));
        booking.setVehicleId(rs.getInt("vehicle_id"));
        booking.setPickupDate(rs.getDate("pickup_date").toLocalDate());
        booking.setReturnDate(rs.getDate("return_date").toLocalDate());
        booking.setTotalAmount(rs.getBigDecimal("total_amount"));
        booking.setBookingStatus(rs.getString("booking_status"));
        booking.setCancellationFee(rs.getBigDecimal("cancellation_fee"));
        booking.setCancelledAt(rs.getTimestamp("cancelled_at"));
        booking.setCustomerName(rs.getString("full_name"));
        booking.setVehicleName(rs.getString("vehicle_name"));
        booking.setRegistrationNumber(rs.getString("registration_number"));
        return booking;
    }

    private void rollback(Connection connection) {
        try {
            connection.rollback();
        } catch (SQLException ignored) {
        }
    }
}
