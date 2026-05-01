package com.vehicle.urbandrivesolutions.controller;

import com.vehicle.urbandrivesolutions.dao.VehicleDAO;
import com.vehicle.urbandrivesolutions.entity.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "homeServlet", urlPatterns = "/home")
public class HomeServlet extends HttpServlet {
    private final VehicleDAO vehicleDAO = new VehicleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Consume any one-time flash message (e.g. logout confirmation)
        HttpSession session = request.getSession(false);
        if (session != null) {
            String flash = (String) session.getAttribute("flashMessage");
            if (flash != null) {
                request.setAttribute("successMessage", flash);
                session.removeAttribute("flashMessage");
            }
        }

        List<Vehicle> featuredVehicles = vehicleDAO.getAvailableVehicles();
        request.setAttribute("featuredVehicles", featuredVehicles);
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
