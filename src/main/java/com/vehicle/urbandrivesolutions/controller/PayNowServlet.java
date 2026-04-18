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
import java.util.Set;

@WebServlet(name = "payNowServlet", urlPatterns = "/payments/pay")
public class PayNowServlet extends HttpServlet {
    private static final Set<String> ALLOWED_METHODS = Set.of("CARD", "ESEWA", "KHALTI", "CONNECT_IPS");

    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User loggedInUser = getLoggedInUser(request);

        if (loggedInUser == null || "ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {
            forwardAccessDenied(request, response);
            return;
        }

        int bookingId = parseId(request.getParameter("bookingId"));
        if (bookingId == -1) {
            forwardPaymentNotFound(request, response);
            return;
        }

        Payment payment = paymentDAO.getPendingPaymentByBookingIdAndUserId(bookingId, loggedInUser.getUserId());
        if (payment == null) {
            forwardPaymentNotFound(request, response);
            return;
        }

        request.setAttribute("payment", payment);
        request.getRequestDispatcher("/WEB-INF/views/payment-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User loggedInUser = getLoggedInUser(request);

        if (loggedInUser == null || "ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {
            forwardAccessDenied(request, response);
            return;
        }

        int bookingId = parseId(request.getParameter("bookingId"));
        if (bookingId == -1) {
            forwardPaymentNotFound(request, response);
            return;
        }

        Payment payment = paymentDAO.getPendingPaymentByBookingIdAndUserId(bookingId, loggedInUser.getUserId());
        if (payment == null) {
            forwardPaymentNotFound(request, response);
            return;
        }

        String paymentMethod = getTrimmedValue(request, "paymentMethod").toUpperCase();
        String transactionCode = getTrimmedValue(request, "transactionCode");

        request.setAttribute("payment", payment);
        request.setAttribute("selectedMethod", paymentMethod);
        request.setAttribute("transactionCode", transactionCode);

        if (!ALLOWED_METHODS.contains(paymentMethod)) {
            request.setAttribute("errorMessage", "Please select a valid payment method.");
            request.getRequestDispatcher("/WEB-INF/views/payment-form.jsp").forward(request, response);
            return;
        }

        if (transactionCode.isEmpty()) {
            request.setAttribute("errorMessage", "Transaction code is required.");
            request.getRequestDispatcher("/WEB-INF/views/payment-form.jsp").forward(request, response);
            return;
        }

        try {
            paymentDAO.processPayment(payment.getPaymentId(), paymentMethod, transactionCode);
            request.setAttribute("successMessage", "Payment completed successfully.");
            request.getRequestDispatcher("/payments").forward(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/payment-form.jsp").forward(request, response);
        }
    }

    private User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        return (User) session.getAttribute("loggedInUser");
    }

    private int parseId(String value) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    private String getTrimmedValue(HttpServletRequest request, String parameterName) {
        String value = request.getParameter(parameterName);
        return value == null ? "" : value.trim();
    }

    private void forwardAccessDenied(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("errorCode", "403");
        request.setAttribute("errorTitle", "Access Denied");
        request.setAttribute("errorMessage", "Only customers can make payments.");
        request.setAttribute("buttonText", "Go to Dashboard");
        request.setAttribute("buttonUrl", request.getContextPath() + "/dashboard");
        request.getRequestDispatcher("/error").forward(request, response);
    }

    private void forwardPaymentNotFound(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("errorCode", "404");
        request.setAttribute("errorTitle", "Pending Payment Not Found");
        request.setAttribute("errorMessage", "No pending payment was found for this booking.");
        request.setAttribute("buttonText", "Go to Bookings");
        request.setAttribute("buttonUrl", request.getContextPath() + "/bookings");
        request.getRequestDispatcher("/error").forward(request, response);
    }
}
