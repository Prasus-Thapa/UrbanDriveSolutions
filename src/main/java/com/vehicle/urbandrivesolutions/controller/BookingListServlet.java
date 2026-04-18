package com.vehicle.urbandrivesolutions.controller;

import com.vehicle.urbandrivesolutions.dao.BookingDAO;
import com.vehicle.urbandrivesolutions.entity.Booking;
import com.vehicle.urbandrivesolutions.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "bookingListServlet", urlPatterns = "/bookings")
public class BookingListServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        boolean isAdmin = "ADMIN".equalsIgnoreCase(loggedInUser.getRole());
        List<Booking> bookings = isAdmin
                ? bookingDAO.getAllBookings()
                : bookingDAO.getBookingsByUserId(loggedInUser.getUserId());

        request.setAttribute("isAdmin", isAdmin);
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/WEB-INF/views/booking-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
