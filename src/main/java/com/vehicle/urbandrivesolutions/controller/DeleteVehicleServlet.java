package com.vehicle.urbandrivesolutions.controller;

import com.vehicle.urbandrivesolutions.dao.VehicleDAO;
import com.vehicle.urbandrivesolutions.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "deleteVehicleServlet", urlPatterns = "/vehicles/delete")
public class DeleteVehicleServlet extends HttpServlet {
    private final VehicleDAO vehicleDAO = new VehicleDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            forwardAccessDenied(request, response);
            return;
        }

        String vehicleIdText = request.getParameter("vehicleId");
        int vehicleId;

        try {
            vehicleId = Integer.parseInt(vehicleIdText);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid vehicle id.");
            request.getRequestDispatcher("/vehicles").forward(request, response);
            return;
        }

        try {
            boolean deleted = vehicleDAO.deleteVehicle(vehicleId);

            if (deleted) {
                request.setAttribute("successMessage", "Vehicle deleted successfully.");
            } else {
                request.setAttribute("errorMessage", "Vehicle could not be deleted.");
            }

        } catch (RuntimeException e) {
            request.setAttribute("errorMessage", "Vehicle could not be deleted. It may already be used in a booking.");
        }

        request.getRequestDispatcher("/vehicles").forward(request, response);
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
}
