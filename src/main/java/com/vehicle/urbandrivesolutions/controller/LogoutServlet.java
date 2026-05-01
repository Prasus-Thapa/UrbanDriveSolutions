package com.vehicle.urbandrivesolutions.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "logoutServlet", urlPatterns = "/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate();
        }

        // Flash the message on a fresh session so it survives the redirect but disappears on refresh
        HttpSession flash = request.getSession(true);
        flash.setAttribute("flashMessage", "Logged out successfully.");

        response.sendRedirect(request.getContextPath() + "/home");
    }
}
