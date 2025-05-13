package com.hamroKarkhana.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.hamroKarkhana.util.CookieUtil;
import com.hamroKarkhana.util.SessionUtil;

@WebFilter(asyncSupported = true, urlPatterns = "/*")
public class AuthenticationFilter implements Filter {

    private static final String LOGIN = "/login";
    private static final String REGISTER = "/register";
    private static final String HOME = "/home";
    private static final String ROOT = "/";
    private static final String DASHBOARD = "/dashboard";
    private static final String INVENTORY = "/inventory";
    private static final String CUSTOMER = "/customer";
    private static final String ORDER = "/order";
    private static final String EDIT_PROFILE = "/editProfile";
    private static final String PRODUCT = "/product";
    private static final String ONE_PRODUCT = "/oneProduct";
    private static final String LOGOUT = "/logout";
    private static final String ABOUT_US = "/aboutUs";
    private static final String CONTACT_US = "/contactUs";
    private static final String ADD_PRODUCT = "/addProduct";
    private static final String ADMIN_PRODUCT = "/adminProduct";
    private static final String DELETE_PRODUCT = "/deleteProduct";
    

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic, if required
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        
        // Allow access to resources like images, CSS files, etc.
        if (uri.endsWith(".png") || uri.endsWith(".jpg")|| uri.endsWith(".svg")|| uri.endsWith(".jpeg")|| uri.endsWith(".webp") || uri.endsWith(".css")) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is logged in (via session or cookies)
        String userRole = CookieUtil.getCookie(req, "role") != null ? CookieUtil.getCookie(req, "role").getValue() : null;
        boolean isLoggedIn = SessionUtil.getAttribute(req, "username") != null;

        // Allow access to the home, login, and register pages for both admins and customers
        if (uri.endsWith(LOGIN) || uri.endsWith(REGISTER) || uri.endsWith(HOME)|| uri.endsWith(ABOUT_US)||uri.endsWith(CONTACT_US)||uri.endsWith(ADD_PRODUCT)||uri.endsWith(ADMIN_PRODUCT)||uri.endsWith(DELETE_PRODUCT)) {
            chain.doFilter(request, response);
            return;
        }

        if (!isLoggedIn) {
            // Redirect to login if not logged in
            res.sendRedirect(req.getContextPath() + LOGIN);
            return;
        }

        // If the user is logged in and is an admin
        if ("admin".equals(userRole)) {
            // Allow admin to access these pages
            if (uri.endsWith(DASHBOARD) || uri.endsWith(INVENTORY) || uri.endsWith(CUSTOMER) || uri.endsWith(ORDER)
                    || uri.endsWith(EDIT_PROFILE)|| uri.endsWith(LOGOUT)) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(req.getContextPath() + LOGIN); // Redirect to admin dashboard
            }
        } else if ("user".equals(userRole)) {
            // Allow customer to access these pages
            if (uri.endsWith(ONE_PRODUCT) || uri.endsWith(PRODUCT) || uri.endsWith(EDIT_PROFILE)|| uri.endsWith(LOGOUT)) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(req.getContextPath() + LOGIN); // Redirect to home for customer
            }
        }
    }

    @Override
    public void destroy() {
        // Cleanup logic, if required
    }
}
