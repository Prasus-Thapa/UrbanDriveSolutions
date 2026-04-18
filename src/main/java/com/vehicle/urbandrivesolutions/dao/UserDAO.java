package com.vehicle.urbandrivesolutions.dao;

import com.vehicle.urbandrivesolutions.entity.User;
import com.vehicle.urbandrivesolutions.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public User findByEmail(String email) {
        String sql = "SELECT user_id, full_name, email, password_hash, phone, license_number, role FROM users WHERE email = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, email);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    User user = new User();
                    user.setUserId(resultSet.getInt("user_id"));
                    user.setFullName(resultSet.getString("full_name"));
                    user.setEmail(resultSet.getString("email"));
                    user.setPasswordHash(resultSet.getString("password_hash"));
                    user.setPhone(resultSet.getString("phone"));
                    user.setLicenseNumber(resultSet.getString("license_number"));
                    user.setRole(resultSet.getString("role"));
                    return user;
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching user by email.", e);
        }

        return null;
    }

    public boolean isUserExists(String email, String phone, String licenseNumber) {
        String sql = "SELECT user_id FROM users WHERE email = ? OR phone = ? OR license_number = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, phone);
            preparedStatement.setString(3, licenseNumber);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error checking existing user.", e);
        }
    }

    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (full_name, email, password_hash, phone, license_number, role) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, user.getFullName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPasswordHash());
            preparedStatement.setString(4, user.getPhone());
            preparedStatement.setString(5, user.getLicenseNumber());
            preparedStatement.setString(6, user.getRole());

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error registering user.", e);
        }
    }
}
