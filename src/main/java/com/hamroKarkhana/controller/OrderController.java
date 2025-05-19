package com.hamroKarkhana.controller;

import com.hamroKarkhana.service.DisplayOrderService;
import com.hamroKarkhana.model.OrderModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/order")
public class OrderController extends HttpServlet {
    private DisplayOrderService displayOrderService;

    @Override
    public void init() {
        System.out.println("Initializing OrderController...");
        displayOrderService = new DisplayOrderService();
        System.out.println("DisplayOrderService initialized.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("OrderController: Handling GET request for /order");

        List<OrderModel> orders = displayOrderService.getAllOrders();

        System.out.println("OrderController: Retrieved " + orders.size() + " orders.");
        for (OrderModel order : orders) {
            System.out.println("Order: " + order.getOrderID() + ", " + order.getCustomerName() + ", " + order.getProductTitle());
        }

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/WEB-INF/pages/orderManagement.jsp").forward(request, response);

        System.out.println("OrderController: Data forwarded to JSP.");
    }
}
