package com.hamroKarkhana.controller;

import com.hamroKarkhana.service.UpdateOrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/updateOrder")
public class UpdateOrderController extends HttpServlet {
    private UpdateOrderService orderUpdateService;

    @Override
    public void init() throws ServletException {
        System.out.println("Initializing UpdateOrderController...");
        orderUpdateService = new UpdateOrderService();
        System.out.println("OrderUpdateService initialized successfully.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Received POST request to update order status.");

        String orderIDStr = request.getParameter("orderID");
        String newStatus = request.getParameter("orderStatus");

        System.out.println("Extracted Parameters - orderID: " + orderIDStr + ", newStatus: " + newStatus);

        try {
            int orderID = Integer.parseInt(orderIDStr);
            System.out.println("Parsed orderID successfully: " + orderID);

            boolean success = orderUpdateService.updateOrderStatus(orderID, newStatus);

            if (success) {
                System.out.println("Order status updated successfully in database.");
                request.setAttribute("success", "Order status updated successfully.");
            } else {
                System.out.println("Failed to update order status in database.");
                request.setAttribute("error", "Failed to update order status.");
            }

        } catch (NumberFormatException e) {
            System.err.println("Invalid order ID format: " + orderIDStr);
            request.setAttribute("error", "Invalid order ID format.");
        } catch (Exception e) {
            System.err.println("Exception while updating order: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong while updating order.");
        }

        System.out.println("Forwarding back to /order page.");
        response.sendRedirect(request.getContextPath() + "/order");

    }
}
