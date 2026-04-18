package com.vehicle.urbandrivesolutions.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "errorServlet", urlPatterns = "/error")
public class ErrorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        setDefaultAttribute(request, "errorCode", "404");
        setDefaultAttribute(request, "errorTitle", "Oops! Page Not Found");
        setDefaultAttribute(request, "errorMessage", "The page you are looking for does not exist.");
        setDefaultAttribute(request, "buttonText", "Go to Home");
        setDefaultAttribute(request, "buttonUrl", request.getContextPath() + "/home");

        request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void setDefaultAttribute(HttpServletRequest request, String name, String value) {
        if (request.getAttribute(name) == null) {
            request.setAttribute(name, value);
        }
    }
}
