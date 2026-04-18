package com.vehicle.urbandrivesolutions.dao;

import com.vehicle.urbandrivesolutions.utils.DBConnection;

import java.sql.Connection;
import java.sql.SQLException;

public class SystemDAO {
    public String getDatabaseStatus() {
        try (Connection connection = DBConnection.getConnection()) {
            if (connection != null && !connection.isClosed()) {
                return "Database connection successful.";
            }
            return "Database connection failed.";
        } catch (SQLException e) {
            return "Database connection failed: " + e.getMessage();
        }
    }
}
