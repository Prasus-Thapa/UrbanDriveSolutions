package com.vehicle.urbandrivesolutions.controller;

import com.vehicle.urbandrivesolutions.dao.VehicleDAO;
import com.vehicle.urbandrivesolutions.entity.User;
import com.vehicle.urbandrivesolutions.entity.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet(name = "editVehicleServlet", urlPatterns = "/vehicles/edit")
public class EditVehicleServlet extends HttpServlet {
    private final VehicleDAO vehicleDAO = new VehicleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            forwardAccessDenied(request, response);
            return;
        }

        String vehicleIdText = request.getParameter("id");
        int vehicleId;

        try {
            vehicleId = Integer.parseInt(vehicleIdText);
        } catch (NumberFormatException e) {
            forwardVehicleNotFound(request, response);
            return;
        }

        Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);

        if (vehicle == null) {
            forwardVehicleNotFound(request, response);
            return;
        }

        request.setAttribute("vehicle", vehicle);
        request.getRequestDispatcher("/WEB-INF/views/edit-vehicle.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            forwardAccessDenied(request, response);
            return;
        }

        String vehicleIdText = getTrimmedValue(request, "vehicleId");
        String brand = getTrimmedValue(request, "brand");
        String model = getTrimmedValue(request, "model");
        String vehicleType = getTrimmedValue(request, "vehicleType");
        String registrationNumber = getTrimmedValue(request, "registrationNumber");
        String color = getTrimmedValue(request, "color");
        String seatsText = getTrimmedValue(request, "seats");
        String pricePerDayText = getTrimmedValue(request, "pricePerDay");
        String availabilityStatus = getTrimmedValue(request, "availabilityStatus");

        Vehicle vehicle = new Vehicle();
        request.setAttribute("vehicle", vehicle);

        int vehicleId;
        try {
            vehicleId = Integer.parseInt(vehicleIdText);
            vehicle.setVehicleId(vehicleId);
        } catch (NumberFormatException e) {
            forwardVehicleNotFound(request, response);
            return;
        }

        vehicle.setBrand(brand);
        vehicle.setModel(model);
        vehicle.setVehicleType(vehicleType);
        vehicle.setRegistrationNumber(registrationNumber);
        vehicle.setColor(color);
        vehicle.setAvailabilityStatus(availabilityStatus);

        if (brand.isEmpty() || model.isEmpty() || vehicleType.isEmpty() || registrationNumber.isEmpty()
                || color.isEmpty() || seatsText.isEmpty() || pricePerDayText.isEmpty() || availabilityStatus.isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/views/edit-vehicle.jsp").forward(request, response);
            return;
        }

        int seats;
        try {
            seats = Integer.parseInt(seatsText);
            if (seats <= 0) {
                throw new NumberFormatException();
            }
            vehicle.setSeats(seats);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Seats must be a valid positive number.");
            request.getRequestDispatcher("/WEB-INF/views/edit-vehicle.jsp").forward(request, response);
            return;
        }

        BigDecimal pricePerDay;
        try {
            pricePerDay = new BigDecimal(pricePerDayText);
            if (pricePerDay.compareTo(BigDecimal.ZERO) <= 0) {
                throw new NumberFormatException();
            }
            vehicle.setPricePerDay(pricePerDay);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Price per day must be a valid positive amount.");
            request.getRequestDispatcher("/WEB-INF/views/edit-vehicle.jsp").forward(request, response);
            return;
        }

        try {
            vehicleDAO.updateVehicle(vehicle);
            request.setAttribute("successMessage", "Vehicle updated successfully.");
            request.getRequestDispatcher("/vehicles").forward(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("errorMessage", "Vehicle could not be updated. Registration number may already exist.");
            request.getRequestDispatcher("/WEB-INF/views/edit-vehicle.jsp").forward(request, response);
        }
    }

    private String getTrimmedValue(HttpServletRequest request, String parameterName) {
        String value = request.getParameter(parameterName);
        return value == null ? "" : value.trim();
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        return loggedInUser != null && "ADMIN".equalsIgnoreCase(loggedInUser.getRole());
    }

    private void forwardAccessDenied(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("errorCode", "403");
        request.setAttribute("errorTitle", "Access Denied");
        request.setAttribute("errorMessage", "Only admin can manage vehicles.");
        request.setAttribute("buttonText", "Go to Dashboard");
        request.setAttribute("buttonUrl", request.getContextPath() + "/dashboard");
        request.getRequestDispatcher("/error").forward(request, response);
    }

    private void forwardVehicleNotFound(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("errorCode", "404");
        request.setAttribute("errorTitle", "Vehicle Not Found");
        request.setAttribute("errorMessage", "The requested vehicle does not exist.");
        request.setAttribute("buttonText", "Go to Vehicles");
        request.setAttribute("buttonUrl", request.getContextPath() + "/vehicles");
        request.getRequestDispatcher("/error").forward(request, response);
    }
}
