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

        String contextPath = httpRequest.getContextPath();
        String path = httpRequest.getRequestURI().substring(contextPath.length());

        if (path == null || path.isEmpty()) {
            path = "/";
        }

        HttpSession session = httpRequest.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("loggedInUser") != null;

        boolean publicPath = path.equals("/")
                || path.equals("/index.jsp")
                || path.equals("/home")
                || path.equals("/login")
                || path.equals("/register")
                || path.equals("/logout")
                || path.equals("/db-check")
                || path.equals("/error")
                || path.equals("/vehicles")
                || path.equals("/blogs")
                || path.equals("/about")
                || path.startsWith("/static/");

        boolean protectedPath = path.startsWith("/dashboard")
                || path.startsWith("/vehicles/")
                || path.startsWith("/bookings")
                || path.startsWith("/payments");

        boolean guestOnlyPath = path.equals("/login") || path.equals("/register");

        if (protectedPath && !loggedIn) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        if (guestOnlyPath && loggedIn) {
            httpRequest.getRequestDispatcher("/dashboard").forward(httpRequest, httpResponse);
            return;
        }

        if (publicPath || protectedPath) {
            chain.doFilter(request, response);
            return;
        }

        httpRequest.setAttribute("errorCode", "404");
        httpRequest.setAttribute("errorTitle", "Oops! Page Not Found");
        httpRequest.setAttribute("errorMessage", "The page you requested does not exist.");
        httpRequest.setAttribute("buttonText", "Go to Home");
        httpRequest.setAttribute("buttonUrl", contextPath + "/home");
        httpRequest.getRequestDispatcher("/error").forward(httpRequest, httpResponse);
    }
}
