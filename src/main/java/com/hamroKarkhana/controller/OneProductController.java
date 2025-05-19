package com.hamroKarkhana.controller;

import com.hamroKarkhana.model.ProductModel;
import com.hamroKarkhana.service.OneProductService;
import com.hamroKarkhana.service.PlaceOrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/oneProduct")
public class OneProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private OneProductService productService = new OneProductService();
    private PlaceOrderService placeOrderService = new PlaceOrderService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String modelNo = request.getParameter("modelNo");
        if (modelNo == null || modelNo.isEmpty()) {
            response.sendRedirect("product.jsp");  // or your products listing page
            return;
        }

        ProductModel product = productService.getProductByModelNo(modelNo);

        if (product == null) {
            response.sendRedirect("product.jsp");  // product not found, redirect
            return;
        }

        request.setAttribute("product", product);

        // Forward to JSP
        request.getRequestDispatcher("/WEB-INF/pages/one-product.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String modelNo = request.getParameter("modelNo");
        String username = (String) request.getSession().getAttribute("username");

        if (username == null) {
            // User not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        boolean orderPlaced = placeOrderService.placeOrder(username, modelNo);

        if (orderPlaced) {
            request.setAttribute("orderPlacedMessage", "Order placed successfully!");
        } else {
            request.setAttribute("orderPlacedMessage", "Failed to place order. Please try again.");
        }

        // After placing order, show the product page again with message
        doGet(request, response);
    }
}
