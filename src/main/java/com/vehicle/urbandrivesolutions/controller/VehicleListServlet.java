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
import java.util.List;

@WebServlet(name = "vehicleListServlet", urlPatterns = "/vehicles")
public class VehicleListServlet extends HttpServlet {
    private final VehicleDAO vehicleDAO = new VehicleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        boolean isAdmin = loggedInUser != null && "ADMIN".equalsIgnoreCase(loggedInUser.getRole());
        boolean loggedIn = loggedInUser != null;

        List<Vehicle> vehicles;

        if (isAdmin) {
            vehicles = vehicleDAO.getAllVehicles();
        } else {
            // Parse filter parameters (all optional)
            String vehicleType = nullIfEmpty(request.getParameter("vehicleType"));
            String brand       = nullIfEmpty(request.getParameter("brand"));
            Integer seats      = parseIntOrNull(request.getParameter("seats"));
            BigDecimal maxPrice = parseBigDecimalOrNull(request.getParameter("maxPrice"));

            // Metadata for dropdowns and slider
            List<String> vehicleTypes   = vehicleDAO.getDistinctVehicleTypes();
            List<String> brands         = vehicleDAO.getDistinctBrands();
            BigDecimal overallMaxPrice  = vehicleDAO.getMaxPricePerDay();

            // Slider display value: submitted value or the actual fleet max
            BigDecimal sliderValue = (maxPrice != null) ? maxPrice : overallMaxPrice;

            vehicles = vehicleDAO.getFilteredVehicles(vehicleType, brand, maxPrice, seats);

            request.setAttribute("vehicleTypes",      vehicleTypes);
            request.setAttribute("brands",            brands);
            request.setAttribute("overallMaxPrice",   overallMaxPrice);
            request.setAttribute("filterMaxPrice",    sliderValue);
            request.setAttribute("filterVehicleType", vehicleType != null ? vehicleType : "");
            request.setAttribute("filterBrand",       brand       != null ? brand       : "");
            request.setAttribute("filterSeats",       seats);
        }

        request.setAttribute("isAdmin",  isAdmin);
        request.setAttribute("loggedIn", loggedIn);
        request.setAttribute("vehicles", vehicles);
        request.getRequestDispatcher("/WEB-INF/views/vehicle-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private String nullIfEmpty(String s) {
        return (s == null || s.trim().isEmpty()) ? null : s.trim();
    }

    private Integer parseIntOrNull(String s) {
        if (s == null || s.trim().isEmpty()) return null;
        try { return Integer.parseInt(s.trim()); } catch (NumberFormatException e) { return null; }
    }

    private BigDecimal parseBigDecimalOrNull(String s) {
        if (s == null || s.trim().isEmpty()) return null;
        try { return new BigDecimal(s.trim()); } catch (NumberFormatException e) { return null; }
    }
}
