package com.vehicle.urbandrivesolutions.controller;

import com.vehicle.urbandrivesolutions.dao.UserDAO;
import com.vehicle.urbandrivesolutions.entity.User;
import com.vehicle.urbandrivesolutions.utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "registerServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = getTrimmedValue(request, "fullName");
        String email = getTrimmedValue(request, "email");
        String password = getTrimmedValue(request, "password");
        String phone = getTrimmedValue(request, "phone");
        String licenseNumber = getTrimmedValue(request, "licenseNumber");

        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("licenseNumber", licenseNumber);

        if (fullName.isEmpty() || email.isEmpty() || password.isEmpty() || phone.isEmpty() || licenseNumber.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("errorMessage", "Password must be at least 6 characters.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.isUserExists(email, phone, licenseNumber)) {
            request.setAttribute("errorMessage", "Email, phone, or license number already exists.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPasswordHash(PasswordUtil.hashPassword(password));
        user.setPhone(phone);
        user.setLicenseNumber(licenseNumber);
        user.setRole("CUSTOMER");

        boolean registered = userDAO.registerUser(user);

        if (registered) {
            request.setAttribute("successMessage", "Registration successful. Please log in.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        request.setAttribute("errorMessage", "Registration failed. Please try again.");
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    private String getTrimmedValue(HttpServletRequest request, String parameterName) {
        String value = request.getParameter(parameterName);
        return value == null ? "" : value.trim();
    }
}
