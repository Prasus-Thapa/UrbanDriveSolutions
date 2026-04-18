package com.vehicle.urbandrivesolutions.controller;

import com.vehicle.urbandrivesolutions.dao.BookingDAO;
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
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

@WebServlet(name = "bookVehicleServlet", urlPatterns = "/bookings/add")
public class BookVehicleServlet extends HttpServlet {
    private final VehicleDAO vehicleDAO = new VehicleDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (isAdmin(request)) {
            forwardAccessDenied(request, response);
            return;
        }

        int vehicleId = parseVehicleId(request.getParameter("vehicleId"));
        if (vehicleId == -1) {
            forwardVehicleNotFound(request, response);
            return;
        }

        Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
        if (vehicle == null) {
            forwardVehicleNotFound(request, response);
            return;
        }

        if (!"AVAILABLE".equalsIgnoreCase(vehicle.getAvailabilityStatus())) {
            forwardVehicleUnavailable(request, response);
            return;
        }

        request.setAttribute("vehicle", vehicle);
        request.getRequestDispatcher("/WEB-INF/views/book-vehicle.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (isAdmin(request)) {
            forwardAccessDenied(request, response);
            return;
        }

        String vehicleIdText = getTrimmedValue(request, "vehicleId");
        String pickupDateText = getTrimmedValue(request, "pickupDate");
        String returnDateText = getTrimmedValue(request, "returnDate");

        int vehicleId = parseVehicleId(vehicleIdText);
        if (vehicleId == -1) {
            forwardVehicleNotFound(request, response);
            return;
        }

        Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
        if (vehicle == null) {
            forwardVehicleNotFound(request, response);
            return;
        }

        request.setAttribute("vehicle", vehicle);
        request.setAttribute("pickupDate", pickupDateText);
        request.setAttribute("returnDate", returnDateText);

        if (pickupDateText.isEmpty() || returnDateText.isEmpty()) {
            request.setAttribute("errorMessage", "Pickup date and return date are required.");
            request.getRequestDispatcher("/WEB-INF/views/book-vehicle.jsp").forward(request, response);
            return;
        }

        LocalDate pickupDate;
        LocalDate returnDate;

        try {
            pickupDate = LocalDate.parse(pickupDateText);
            returnDate = LocalDate.parse(returnDateText);
        } catch (DateTimeParseException e) {
            request.setAttribute("errorMessage", "Please enter valid dates.");
            request.getRequestDispatcher("/WEB-INF/views/book-vehicle.jsp").forward(request, response);
            return;
        }

        if (pickupDate.isBefore(LocalDate.now())) {
            request.setAttribute("errorMessage", "Pickup date cannot be in the past.");
            request.getRequestDispatcher("/WEB-INF/views/book-vehicle.jsp").forward(request, response);
            return;
        }

        if (!returnDate.isAfter(pickupDate)) {
            request.setAttribute("errorMessage", "Return date must be after pickup date.");
            request.getRequestDispatcher("/WEB-INF/views/book-vehicle.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        try {
            bookingDAO.createBooking(loggedInUser.getUserId(), vehicleId, pickupDate, returnDate);
            request.setAttribute("successMessage", "Booking created successfully.");
            request.getRequestDispatcher("/bookings").forward(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/book-vehicle.jsp").forward(request, response);
        }
    }

    private String getTrimmedValue(HttpServletRequest request, String parameterName) {
        String value = request.getParameter(parameterName);
        return value == null ? "" : value.trim();
    }

    private int parseVehicleId(String vehicleIdText) {
        try {
            return Integer.parseInt(vehicleIdText);
        } catch (NumberFormatException e) {
            return -1;
        }
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
        request.setAttribute("errorMessage", "Only customers can book vehicles.");
        request.setAttribute("buttonText", "Go to Dashboard");
        request.setAttribute("buttonUrl", request.getContextPath() + "/dashboard");
        request.getRequestDispatcher("/error").forward(request, response);
    }

    private void forwardVehicleNotFound(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("errorCode", "404");
        request.setAttribute("errorTitle", "Vehicle Not Found");
        request.setAttribute("errorMessage", "The selected vehicle does not exist.");
        request.setAttribute("buttonText", "Browse Vehicles");
        request.setAttribute("buttonUrl", request.getContextPath() + "/vehicles");
        request.getRequestDispatcher("/error").forward(request, response);
    }

    private void forwardVehicleUnavailable(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("errorCode", "409");
        request.setAttribute("errorTitle", "Vehicle Not Available");
        request.setAttribute("errorMessage", "This vehicle is not available for booking.");
        request.setAttribute("buttonText", "Browse Vehicles");
        request.setAttribute("buttonUrl", request.getContextPath() + "/vehicles");
        request.getRequestDispatcher("/error").forward(request, response);
    }
}
