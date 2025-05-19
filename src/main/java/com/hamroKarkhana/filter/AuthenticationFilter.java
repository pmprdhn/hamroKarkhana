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
    private static final String UPDATE_PRODUCT = "/updateProduct";
    private static final String UPDATE_ORDER = "/updateOrder";
    
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
        String path = uri.substring(req.getContextPath().length()); // Fix applied here

        // Allow access to resources like images, CSS files, etc.
        if (uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith(".svg") || uri.endsWith(".jpeg") || uri.endsWith(".webp") || uri.endsWith(".css")) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is logged in (via session or cookies)
        String userRole = CookieUtil.getCookie(req, "role") != null ? CookieUtil.getCookie(req, "role").getValue() : null;
        boolean isLoggedIn = SessionUtil.getAttribute(req, "username") != null;

        // Allow access to the home, login, and register pages for both admins and customers
        if (path.contains(LOGIN) || path.contains(REGISTER) || path.contains(HOME)
                || path.contains(ABOUT_US) || path.contains(CONTACT_US)
                || path.contains(ADD_PRODUCT) || path.contains(ADMIN_PRODUCT)
                || path.contains(DELETE_PRODUCT) || path.contains(UPDATE_PRODUCT)
                || path.startsWith(ONE_PRODUCT)) {

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
            if (path.endsWith(DASHBOARD) || path.endsWith(INVENTORY) || path.endsWith(CUSTOMER) || path.endsWith(ORDER)
                    || path.endsWith(EDIT_PROFILE) || path.endsWith(LOGOUT) || path.endsWith(UPDATE_ORDER)) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(req.getContextPath() + LOGIN); // Redirect to login
            }
        } else if ("user".equals(userRole)) {
            // Allow customer to access these pages
            if (path.endsWith(PRODUCT) || path.endsWith(EDIT_PROFILE) || path.endsWith(LOGOUT)) {
                chain.doFilter(request, response);
                return;
            } else {
                res.sendRedirect(req.getContextPath() + LOGIN); // Redirect to login
            }
        }
    }

    @Override
    public void destroy() {
        // Cleanup logic, if required
    }
}
