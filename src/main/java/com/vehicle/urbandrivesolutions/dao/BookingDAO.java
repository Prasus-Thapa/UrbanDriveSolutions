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

    public List<Booking> getAllBookings() {
        String sql = "SELECT b.booking_id, b.user_id, b.vehicle_id, b.pickup_date, b.return_date, b.total_amount, b.booking_status, " +
                "u.full_name, CONCAT(v.brand, ' ', v.model) AS vehicle_name, v.registration_number " +
                "FROM bookings b " +
                "JOIN users u ON b.user_id = u.user_id " +
                "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                "ORDER BY b.booking_id DESC";

        List<Booking> bookings = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                bookings.add(mapBooking(resultSet));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all bookings.", e);
        }

        return bookings;
    }

    public List<Booking> getBookingsByUserId(int userId) {
        String sql = "SELECT b.booking_id, b.user_id, b.vehicle_id, b.pickup_date, b.return_date, b.total_amount, b.booking_status, " +
                "u.full_name, CONCAT(v.brand, ' ', v.model) AS vehicle_name, v.registration_number " +
                "FROM bookings b " +
                "JOIN users u ON b.user_id = u.user_id " +
                "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                "WHERE b.user_id = ? " +
                "ORDER BY b.booking_id DESC";

        List<Booking> bookings = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, userId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    bookings.add(mapBooking(resultSet));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching user bookings.", e);
        }

        return bookings;
    }

    public void createBooking(int userId, int vehicleId, LocalDate pickupDate, LocalDate returnDate) {
        String vehicleSql = "SELECT price_per_day, availability_status FROM vehicles WHERE vehicle_id = ?";
        String bookingSql = "INSERT INTO bookings (user_id, vehicle_id, pickup_date, return_date, total_amount, booking_status) VALUES (?, ?, ?, ?, ?, ?)";
        String updateVehicleSql = "UPDATE vehicles SET availability_status = 'BOOKED' WHERE vehicle_id = ?";
        String paymentSql = "INSERT INTO payments (booking_id, amount, payment_method, payment_status, transaction_code) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection()) {
            connection.setAutoCommit(false);

            try (PreparedStatement vehicleStatement = connection.prepareStatement(vehicleSql)) {
                vehicleStatement.setInt(1, vehicleId);

                try (ResultSet resultSet = vehicleStatement.executeQuery()) {
                    if (!resultSet.next()) {
                        rollback(connection);
                        throw new RuntimeException("Selected vehicle was not found.");
                    }

                    String availabilityStatus = resultSet.getString("availability_status");
                    BigDecimal pricePerDay = resultSet.getBigDecimal("price_per_day");

                    if (!"AVAILABLE".equalsIgnoreCase(availabilityStatus)) {
                        rollback(connection);
                        throw new RuntimeException("Selected vehicle is not available.");
                    }

                    long rentalDays = ChronoUnit.DAYS.between(pickupDate, returnDate);

                    if (rentalDays <= 0) {
                        rollback(connection);
                        throw new RuntimeException("Return date must be after pickup date.");
                    }

                    BigDecimal totalAmount = pricePerDay.multiply(BigDecimal.valueOf(rentalDays));

                    try (PreparedStatement bookingStatement = connection.prepareStatement(bookingSql, PreparedStatement.RETURN_GENERATED_KEYS);
                         PreparedStatement paymentStatement = connection.prepareStatement(paymentSql);
                         PreparedStatement updateVehicleStatement = connection.prepareStatement(updateVehicleSql)) {

                        bookingStatement.setInt(1, userId);
                        bookingStatement.setInt(2, vehicleId);
                        bookingStatement.setDate(3, Date.valueOf(pickupDate));
                        bookingStatement.setDate(4, Date.valueOf(returnDate));
                        bookingStatement.setBigDecimal(5, totalAmount);
                        bookingStatement.setString(6, "PENDING");
                        bookingStatement.executeUpdate();

                        int bookingId;
                        try (ResultSet generatedKeys = bookingStatement.getGeneratedKeys()) {
                            if (!generatedKeys.next()) {
                                rollback(connection);
                                throw new RuntimeException("Booking could not be created.");
                            }
                            bookingId = generatedKeys.getInt(1);
                        }

                        paymentStatement.setInt(1, bookingId);
                        paymentStatement.setBigDecimal(2, totalAmount);
                        paymentStatement.setNull(3, java.sql.Types.VARCHAR);
                        paymentStatement.setString(4, "PENDING");
                        paymentStatement.setString(5, null);
                        paymentStatement.executeUpdate();

                        updateVehicleStatement.setInt(1, vehicleId);
                        updateVehicleStatement.executeUpdate();

                        connection.commit();
                    }
                }

            } catch (SQLException e) {
                rollback(connection);
                throw new RuntimeException("Error creating booking.", e);
            } catch (RuntimeException e) {
                rollback(connection);
                throw e;
            }

        } catch (SQLException e) {
            throw new RuntimeException("Database error while creating booking.", e);
        }
    }

    private Booking mapBooking(ResultSet resultSet) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(resultSet.getInt("booking_id"));
        booking.setUserId(resultSet.getInt("user_id"));
        booking.setVehicleId(resultSet.getInt("vehicle_id"));
        booking.setPickupDate(resultSet.getDate("pickup_date").toLocalDate());
        booking.setReturnDate(resultSet.getDate("return_date").toLocalDate());
        booking.setTotalAmount(resultSet.getBigDecimal("total_amount"));
        booking.setBookingStatus(resultSet.getString("booking_status"));
        booking.setCustomerName(resultSet.getString("full_name"));
        booking.setVehicleName(resultSet.getString("vehicle_name"));
        booking.setRegistrationNumber(resultSet.getString("registration_number"));
        return booking;
    }

    private void rollback(Connection connection) {
        try {
            connection.rollback();
        } catch (SQLException ignored) {
        }
    }
}
