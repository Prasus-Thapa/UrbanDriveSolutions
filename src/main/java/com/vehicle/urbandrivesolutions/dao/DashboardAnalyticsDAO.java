package com.vehicle.urbandrivesolutions.dao;

import com.vehicle.urbandrivesolutions.entity.DashboardAnalytics;
import com.vehicle.urbandrivesolutions.utils.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DashboardAnalyticsDAO {

    public DashboardAnalytics getAdminAnalytics() {
        String sql = "SELECT " +
                "(SELECT COALESCE(SUM(amount), 0) FROM payments WHERE payment_status = 'PAID') AS total_revenue, " +
                "(SELECT COALESCE(SUM(amount), 0) FROM payments WHERE payment_status = 'PAID' AND payment_method = 'CARD') AS card_revenue, " +
                "(SELECT COALESCE(SUM(amount), 0) FROM payments WHERE payment_status = 'PAID' AND payment_method = 'ESEWA') AS esewa_revenue, " +
                "(SELECT COALESCE(SUM(amount), 0) FROM payments WHERE payment_status = 'PAID' AND payment_method = 'KHALTI') AS khalti_revenue, " +
                "(SELECT COALESCE(SUM(amount), 0) FROM payments WHERE payment_status = 'PAID' AND payment_method = 'CONNECT_IPS') AS connect_ips_revenue, " +
                "(SELECT COUNT(*) FROM payments WHERE payment_status = 'PAID') AS total_paid_payments, " +
                "(SELECT COUNT(*) FROM payments WHERE payment_status = 'PENDING') AS total_pending_payments, " +
                "(SELECT COUNT(*) FROM bookings) AS total_bookings, " +
                "(SELECT COUNT(*) FROM bookings WHERE booking_status = 'CONFIRMED') AS total_confirmed_bookings, " +
                "(SELECT COUNT(*) FROM vehicles) AS total_vehicles, " +
                "(SELECT COUNT(*) FROM vehicles WHERE availability_status = 'AVAILABLE') AS available_vehicles";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            if (resultSet.next()) {
                DashboardAnalytics analytics = new DashboardAnalytics();
                analytics.setTotalRevenue(getAmount(resultSet, "total_revenue"));
                analytics.setCardRevenue(getAmount(resultSet, "card_revenue"));
                analytics.setEsewaRevenue(getAmount(resultSet, "esewa_revenue"));
                analytics.setKhaltiRevenue(getAmount(resultSet, "khalti_revenue"));
                analytics.setConnectIpsRevenue(getAmount(resultSet, "connect_ips_revenue"));
                analytics.setTotalPaidPayments(resultSet.getInt("total_paid_payments"));
                analytics.setTotalPendingPayments(resultSet.getInt("total_pending_payments"));
                analytics.setTotalBookings(resultSet.getInt("total_bookings"));
                analytics.setTotalConfirmedBookings(resultSet.getInt("total_confirmed_bookings"));
                analytics.setTotalVehicles(resultSet.getInt("total_vehicles"));
                analytics.setAvailableVehicles(resultSet.getInt("available_vehicles"));
                return analytics;
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching dashboard analytics.", e);
        }

        return new DashboardAnalytics();
    }

    private BigDecimal getAmount(ResultSet resultSet, String columnName) throws SQLException {
        BigDecimal amount = resultSet.getBigDecimal(columnName);
        return amount == null ? BigDecimal.ZERO : amount;
    }
}
