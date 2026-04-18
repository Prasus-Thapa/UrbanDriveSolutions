package com.vehicle.urbandrivesolutions.controller;

import com.vehicle.urbandrivesolutions.dao.SystemDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "dbCheckServlet", urlPatterns = "/db-check")
public class DbCheckServlet extends HttpServlet {
    private final SystemDAO systemDAO = new SystemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("dbStatus", systemDAO.getDatabaseStatus());
        request.getRequestDispatcher("/WEB-INF/views/db-check.jsp").forward(request, response);
    }
}
