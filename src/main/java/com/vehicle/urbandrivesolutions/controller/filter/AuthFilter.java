package com.vehicle.urbandrivesolutions.controller.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        boolean protectedPath = path.startsWith("/dashboard")
                || path.startsWith("/vehicles")
                || path.startsWith("/bookings")
                || path.startsWith("/payments");

        HttpSession session = httpRequest.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("loggedInUser") != null;

        if (protectedPath && !loggedIn) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/home");
            return;
        }

        chain.doFilter(request, response);
    }
}
