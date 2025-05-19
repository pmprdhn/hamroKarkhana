package com.hamroKarkhana.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.hamroKarkhana.util.CookieUtil;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
         // Invalidate the session (clears everything)
        if (request.getSession(false) != null) { // Check if session exists
            request.getSession().invalidate();
            System.out.println("Session invalidated successfully.");
        }

        // Delete the role cookie
        CookieUtil.deleteCookie(response, "role");
        System.out.println("Role cookie deleted successfully.");

        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/home");
    }
}