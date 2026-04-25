package com.vehicle.urbandrivesolutions.controller;

import com.vehicle.urbandrivesolutions.entity.User;
import com.vehicle.urbandrivesolutions.service.BookingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "cancelBookingServlet", urlPatterns = "/bookings/cancel")
public class CancelBookingServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();

    /** Only POST is accepted — the Cancel button submits a form. */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (isAdmin(request)) {
            request.setAttribute("errorCode", "403");
            request.setAttribute("errorTitle", "Access Denied");
            request.setAttribute("errorMessage", "Admins cannot cancel customer bookings from this page.");
            request.setAttribute("buttonText", "Go to Dashboard");
            request.setAttribute("buttonUrl", request.getContextPath() + "/dashboard");
            request.getRequestDispatcher("/error").forward(request, response);
            return;
        }

        String bookingIdText = request.getParameter("bookingId");
        int bookingId = parseId(bookingIdText);

        if (bookingId == -1) {
            request.setAttribute("errorMessage", "Invalid booking ID.");
            forwardToBookings(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        try {
            bookingService.cancelBooking(bookingId, loggedInUser.getUserId());
            request.setAttribute("successMessage", "Booking #" + bookingId + " has been cancelled successfully.");
        } catch (RuntimeException e) {
            request.setAttribute("errorMessage", e.getMessage());
        }

        forwardToBookings(request, response);
    }

    private void forwardToBookings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/bookings").forward(request, response);
    }

    private int parseId(String text) {
        try {
            return Integer.parseInt(text);
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        User user = (User) session.getAttribute("loggedInUser");
        return user != null && "ADMIN".equalsIgnoreCase(user.getRole());
    }
}
