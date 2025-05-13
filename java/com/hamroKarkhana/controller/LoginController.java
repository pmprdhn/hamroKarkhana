package com.hamroKarkhana.controller;

import com.hamroKarkhana.model.CustomerModel;
import com.hamroKarkhana.service.LoginService;
import com.hamroKarkhana.util.CookieUtil;
import com.hamroKarkhana.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * LoginController is responsible for handling login requests. It interacts with
 * the LoginService to authenticate users.
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/login" })
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final LoginService loginService;

    /**
     * Constructor initializes the LoginService.
     */
    public LoginController() {
        this.loginService = new LoginService();
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Navigating to login page.");
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("Attempting login for user: " + username);

        CustomerModel userModel = new CustomerModel(username, password);
        Boolean loginStatus = loginService.loginUser(userModel);

        if (loginStatus != null && loginStatus) {
            System.out.println("Login successful for user: " + username);
            request.getSession().setAttribute("loggedIn", true);
            SessionUtil.setAttribute(request, "username", username);
            
          
            CustomerModel fullUser = loginService.getUserDetails(username);
            if (fullUser != null) {
                SessionUtil.setAttribute(request, "name", fullUser.getName());
                SessionUtil.setAttribute(request, "profilePicture", fullUser.getProfilePicture() != null ? fullUser.getProfilePicture() : "default.jpg");
                SessionUtil.setAttribute(request, "username", fullUser.getUsername());
                // You can add more if needed
            }

            if (username.equals("admin")) {
                CookieUtil.addCookie(response, "role", "admin", 5 * 30); // Cookie for admin role
                System.out.println("Admin role set in cookie for user: " + username);
                response.sendRedirect(request.getContextPath() + "/dashboard"); // Redirect to dashboard
            } else {
                CookieUtil.addCookie(response, "role", "user", 5 * 30); // Cookie for regular user
                System.out.println("User role set in cookie for user: " + username);
                response.sendRedirect(request.getContextPath() + "/home"); // Redirect to home page
            }
        } else {
            handleLoginFailure(request, response, loginStatus);
        }
    }

    /**
     * Handles login failures by setting attributes and forwarding to the login
     * page.
     *
     * @param request     HttpServletRequest object
     * @param response    HttpServletResponse object
     * @param loginStatus Boolean indicating the login status
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    private void handleLoginFailure(HttpServletRequest request, HttpServletResponse response, Boolean loginStatus)
            throws ServletException, IOException {
        String errorMessage;
        if (loginStatus == null) {
            errorMessage = "Our server is under maintenance. Please try again later!";
            System.out.println("Login failed due to connection error. Username: " + request.getParameter("username"));
        } else {
            errorMessage = "Invalid Username or Password! Please try again.";
            System.out.println("Invalid login attempt for username: " + request.getParameter("username"));
        }
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }
}
