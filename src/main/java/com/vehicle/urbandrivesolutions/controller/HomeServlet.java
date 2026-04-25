package com.vehicle.urbandrivesolutions.controller;

import com.vehicle.urbandrivesolutions.dao.VehicleDAO;
import com.vehicle.urbandrivesolutions.entity.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "homeServlet", urlPatterns = "/home")
public class HomeServlet extends HttpServlet {
    private final VehicleDAO vehicleDAO = new VehicleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Vehicle> featuredVehicles = vehicleDAO.getAvailableVehicles();
        request.setAttribute("featuredVehicles", featuredVehicles);
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
