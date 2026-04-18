package com.vehicle.urbandrivesolutions.controller;

import com.vehicle.urbandrivesolutions.dao.PaymentDAO;
import com.vehicle.urbandrivesolutions.entity.Payment;
import com.vehicle.urbandrivesolutions.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "paymentListServlet", urlPatterns = "/payments")
public class PaymentListServlet extends HttpServlet {
    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        boolean isAdmin = "ADMIN".equalsIgnoreCase(loggedInUser.getRole());
        List<Payment> payments = isAdmin
                ? paymentDAO.getAllPayments()
                : paymentDAO.getPaymentsByUserId(loggedInUser.getUserId());

        request.setAttribute("isAdmin", isAdmin);
        request.setAttribute("payments", payments);
        request.getRequestDispatcher("/WEB-INF/views/payment-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
