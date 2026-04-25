package com.vehicle.urbandrivesolutions.dao;

import com.vehicle.urbandrivesolutions.entity.Vehicle;
import com.vehicle.urbandrivesolutions.utils.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {

    public List<Vehicle> getAllVehicles() {
        String sql = "SELECT vehicle_id, brand, model, vehicle_type, registration_number, color, seats, price_per_day, availability_status FROM vehicles ORDER BY vehicle_id DESC";
        List<Vehicle> vehicles = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                vehicles.add(mapVehicle(resultSet));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all vehicles.", e);
        }

        return vehicles;
    }

    public List<Vehicle> getAvailableVehicles() {
        String sql = "SELECT vehicle_id, brand, model, vehicle_type, registration_number, color, seats, price_per_day, availability_status FROM vehicles WHERE availability_status = 'AVAILABLE' ORDER BY vehicle_id DESC";
        List<Vehicle> vehicles = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                vehicles.add(mapVehicle(resultSet));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching available vehicles.", e);
        }

        return vehicles;
    }

    public Vehicle getVehicleById(int vehicleId) {
        String sql = "SELECT vehicle_id, brand, model, vehicle_type, registration_number, color, seats, price_per_day, availability_status FROM vehicles WHERE vehicle_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, vehicleId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapVehicle(resultSet);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching vehicle by id.", e);
        }

        return null;
    }

    public boolean addVehicle(Vehicle vehicle) {
        String sql = "INSERT INTO vehicles (brand, model, vehicle_type, registration_number, color, seats, price_per_day, availability_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, vehicle.getBrand());
            preparedStatement.setString(2, vehicle.getModel());
            preparedStatement.setString(3, vehicle.getVehicleType());
            preparedStatement.setString(4, vehicle.getRegistrationNumber());
            preparedStatement.setString(5, vehicle.getColor());
            preparedStatement.setInt(6, vehicle.getSeats());
            preparedStatement.setBigDecimal(7, vehicle.getPricePerDay());
            preparedStatement.setString(8, vehicle.getAvailabilityStatus());

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error adding vehicle.", e);
        }
    }

    public boolean updateVehicle(Vehicle vehicle) {
        String sql = "UPDATE vehicles SET brand = ?, model = ?, vehicle_type = ?, registration_number = ?, color = ?, seats = ?, price_per_day = ?, availability_status = ? WHERE vehicle_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, vehicle.getBrand());
            preparedStatement.setString(2, vehicle.getModel());
            preparedStatement.setString(3, vehicle.getVehicleType());
            preparedStatement.setString(4, vehicle.getRegistrationNumber());
            preparedStatement.setString(5, vehicle.getColor());
            preparedStatement.setInt(6, vehicle.getSeats());
            preparedStatement.setBigDecimal(7, vehicle.getPricePerDay());
            preparedStatement.setString(8, vehicle.getAvailabilityStatus());
            preparedStatement.setInt(9, vehicle.getVehicleId());

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error updating vehicle.", e);
        }
    }

    public boolean deleteVehicle(int vehicleId) {
        String sql = "DELETE FROM vehicles WHERE vehicle_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, vehicleId);
            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting vehicle.", e);
        }
    }

    // ── Filter support ──────────────────────────────────────────────────────

    public List<String> getDistinctVehicleTypes() {
        String sql = "SELECT DISTINCT vehicle_type FROM vehicles WHERE availability_status = 'AVAILABLE' ORDER BY vehicle_type ASC";
        List<String> types = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) types.add(rs.getString("vehicle_type"));
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching vehicle types.", e);
        }
        return types;
    }

    public List<String> getDistinctBrands() {
        String sql = "SELECT DISTINCT brand FROM vehicles WHERE availability_status = 'AVAILABLE' ORDER BY brand ASC";
        List<String> brands = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) brands.add(rs.getString("brand"));
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching brands.", e);
        }
        return brands;
    }

    public BigDecimal getMaxPricePerDay() {
        String sql = "SELECT COALESCE(MAX(price_per_day), 1000) FROM vehicles WHERE availability_status = 'AVAILABLE'";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching max price.", e);
        }
        return new BigDecimal("1000");
    }

    /**
     * Returns available vehicles matching all non-null filter criteria.
     * Null/empty parameters mean "no filter on that field".
     */
    public List<Vehicle> getFilteredVehicles(String vehicleType, String brand, BigDecimal maxPrice, Integer seats) {
        StringBuilder sql = new StringBuilder(
            "SELECT vehicle_id, brand, model, vehicle_type, registration_number, color, seats, price_per_day, availability_status " +
            "FROM vehicles WHERE availability_status = 'AVAILABLE'");

        List<Object> params = new ArrayList<>();

        if (vehicleType != null && !vehicleType.isEmpty()) {
            sql.append(" AND vehicle_type = ?");
            params.add(vehicleType);
        }
        if (brand != null && !brand.isEmpty()) {
            sql.append(" AND brand = ?");
            params.add(brand);
        }
        if (maxPrice != null) {
            sql.append(" AND price_per_day <= ?");
            params.add(maxPrice);
        }
        if (seats != null) {
            sql.append(" AND seats = ?");
            params.add(seats);
        }
        sql.append(" ORDER BY vehicle_id DESC");

        List<Vehicle> vehicles = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                Object p = params.get(i);
                if (p instanceof String)     ps.setString(i + 1, (String) p);
                else if (p instanceof BigDecimal) ps.setBigDecimal(i + 1, (BigDecimal) p);
                else if (p instanceof Integer)    ps.setInt(i + 1, (Integer) p);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) vehicles.add(mapVehicle(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching filtered vehicles.", e);
        }
        return vehicles;
    }

    private Vehicle mapVehicle(ResultSet resultSet) throws SQLException {
        Vehicle vehicle = new Vehicle();
        vehicle.setVehicleId(resultSet.getInt("vehicle_id"));
        vehicle.setBrand(resultSet.getString("brand"));
        vehicle.setModel(resultSet.getString("model"));
        vehicle.setVehicleType(resultSet.getString("vehicle_type"));
        vehicle.setRegistrationNumber(resultSet.getString("registration_number"));
        vehicle.setColor(resultSet.getString("color"));
        vehicle.setSeats(resultSet.getInt("seats"));
        vehicle.setPricePerDay(resultSet.getBigDecimal("price_per_day"));
        vehicle.setAvailabilityStatus(resultSet.getString("availability_status"));
        return vehicle;
    }
}
