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

    public Payment getPendingPaymentByBookingId(int bookingId) {
        String sql = "SELECT p.payment_id, p.booking_id, p.amount, p.payment_method, p.payment_status, p.transaction_code, p.payment_date, " +
                "u.full_name, CONCAT(v.brand, ' ', v.model) AS vehicle_name " +
                "FROM payments p " +
                "JOIN bookings b ON p.booking_id = b.booking_id " +
                "JOIN users u ON b.user_id = u.user_id " +
                "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                "WHERE p.booking_id = ? AND p.payment_status = 'PENDING'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, bookingId);

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

    public void createPendingPayment(int bookingId, java.math.BigDecimal amount) {
        String sql = "INSERT INTO payments (booking_id, amount, payment_method, payment_status, transaction_code) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, bookingId);
            preparedStatement.setBigDecimal(2, amount);
            preparedStatement.setString(3, "CARD");
            preparedStatement.setString(4, "PENDING");
            preparedStatement.setString(5, null);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Error creating pending payment.", e);
        }
    }

    public void markPaymentAsPaid(int paymentId, String paymentMethod, String transactionCode) {
        String sql = "UPDATE payments SET payment_method = ?, payment_status = 'PAID', transaction_code = ? WHERE payment_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, paymentMethod);
            preparedStatement.setString(2, transactionCode);
            preparedStatement.setInt(3, paymentId);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Error updating payment status.", e);
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
}
