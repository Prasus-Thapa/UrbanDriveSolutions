package com.vehicle.urbandrivesolutions.dao;

import com.vehicle.urbandrivesolutions.entity.Payment;
import com.vehicle.urbandrivesolutions.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public List<Payment> getAllPayments() {
        String sql = "SELECT p.payment_id, p.booking_id, p.amount, p.payment_method, p.payment_status, p.transaction_code, p.payment_date, " +
                "u.full_name, CONCAT(v.brand, ' ', v.model) AS vehicle_name " +
                "FROM payments p " +
                "JOIN bookings b ON p.booking_id = b.booking_id " +
                "JOIN users u ON b.user_id = u.user_id " +
                "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                "ORDER BY p.payment_id DESC";

        List<Payment> payments = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                payments.add(mapPayment(resultSet));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all payments.", e);
        }

        return payments;
    }

    public List<Payment> getPaymentsByUserId(int userId) {
        String sql = "SELECT p.payment_id, p.booking_id, p.amount, p.payment_method, p.payment_status, p.transaction_code, p.payment_date, " +
                "u.full_name, CONCAT(v.brand, ' ', v.model) AS vehicle_name " +
                "FROM payments p " +
                "JOIN bookings b ON p.booking_id = b.booking_id " +
                "JOIN users u ON b.user_id = u.user_id " +
                "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                "WHERE b.user_id = ? " +
                "ORDER BY p.payment_id DESC";

        List<Payment> payments = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, userId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    payments.add(mapPayment(resultSet));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching user payments.", e);
        }

        return payments;
    }

    public Payment getPendingPaymentByBookingIdAndUserId(int bookingId, int userId) {
        String sql = "SELECT p.payment_id, p.booking_id, p.amount, p.payment_method, p.payment_status, p.transaction_code, p.payment_date, " +
                "u.full_name, CONCAT(v.brand, ' ', v.model) AS vehicle_name " +
                "FROM payments p " +
                "JOIN bookings b ON p.booking_id = b.booking_id " +
                "JOIN users u ON b.user_id = u.user_id " +
                "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                "WHERE p.booking_id = ? AND b.user_id = ? AND p.payment_status = 'PENDING'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, bookingId);
            preparedStatement.setInt(2, userId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapPayment(resultSet);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching pending payment.", e);
        }

        return null;
    }

    public void processPayment(int paymentId, String paymentMethod, String transactionCode) {
        String paymentQuerySql = "SELECT booking_id, payment_status FROM payments WHERE payment_id = ?";
        String updatePaymentSql = "UPDATE payments SET payment_method = ?, payment_status = 'PAID', transaction_code = ?, payment_date = CURRENT_TIMESTAMP WHERE payment_id = ?";
        String updateBookingSql = "UPDATE bookings SET booking_status = 'CONFIRMED' WHERE booking_id = ?";

        try (Connection connection = DBConnection.getConnection()) {
            connection.setAutoCommit(false);

            try (PreparedStatement paymentQueryStatement = connection.prepareStatement(paymentQuerySql);
                 PreparedStatement updatePaymentStatement = connection.prepareStatement(updatePaymentSql);
                 PreparedStatement updateBookingStatement = connection.prepareStatement(updateBookingSql)) {

                paymentQueryStatement.setInt(1, paymentId);

                int bookingId;
                try (ResultSet resultSet = paymentQueryStatement.executeQuery()) {
                    if (!resultSet.next()) {
                        rollback(connection);
                        throw new RuntimeException("Payment record was not found.");
                    }

                    String paymentStatus = resultSet.getString("payment_status");
                    if ("PAID".equalsIgnoreCase(paymentStatus)) {
                        rollback(connection);
                        throw new RuntimeException("This payment has already been completed.");
                    }

                    bookingId = resultSet.getInt("booking_id");
                }

                updatePaymentStatement.setString(1, paymentMethod);
                updatePaymentStatement.setString(2, transactionCode);
                updatePaymentStatement.setInt(3, paymentId);
                updatePaymentStatement.executeUpdate();

                updateBookingStatement.setInt(1, bookingId);
                updateBookingStatement.executeUpdate();

                connection.commit();

            } catch (SQLException e) {
                rollback(connection);
                throw new RuntimeException("Error processing payment.", e);
            } catch (RuntimeException e) {
                rollback(connection);
                throw e;
            }

        } catch (SQLException e) {
            throw new RuntimeException("Database error while processing payment.", e);
        }
    }

    /**
     * Updates the payment_status for the payment record linked to bookingId.
     * Used during cancellation to reflect the refund outcome.
     */
    public void updatePaymentRefundStatus(int bookingId, String paymentStatus) {
        String sql = "UPDATE payments SET payment_status = ? WHERE booking_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, paymentStatus);
            ps.setInt(2, bookingId);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Error updating payment refund status.", e);
        }
    }

    private Payment mapPayment(ResultSet resultSet) throws SQLException {
        Payment payment = new Payment();
        payment.setPaymentId(resultSet.getInt("payment_id"));
        payment.setBookingId(resultSet.getInt("booking_id"));
        payment.setAmount(resultSet.getBigDecimal("amount"));
        payment.setPaymentMethod(resultSet.getString("payment_method"));
        payment.setPaymentStatus(resultSet.getString("payment_status"));
        payment.setTransactionCode(resultSet.getString("transaction_code"));
        payment.setPaymentDate(resultSet.getTimestamp("payment_date"));
        payment.setCustomerName(resultSet.getString("full_name"));
        payment.setVehicleName(resultSet.getString("vehicle_name"));
        return payment;
    }

    private void rollback(Connection connection) {
        try {
            connection.rollback();
        } catch (SQLException ignored) {
        }
    }
}
