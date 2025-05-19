package com.hamroKarkhana.controller;

import com.hamroKarkhana.model.CustomerModel;
import com.hamroKarkhana.service.CustomerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/customer")
public class CustomerController extends HttpServlet {
    private CustomerService customerService;

    @Override
    public void init() {
        customerService = new CustomerService();
    }

    // Display customer list
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CustomerModel> customers = customerService.getAllCustomers();
        request.setAttribute("customers", customers);

        // Also forward any success or error messages
        request.getRequestDispatcher("/WEB-INF/pages/customer.jsp").forward(request, response);
    }

    // Handle deletion
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");

        if (username != null && !username.trim().isEmpty()) {
            boolean deleted = customerService.deleteCustomerByUsername(username);

            if (deleted) {
                request.setAttribute("success", "Customer deleted successfully.");
            } else {
                request.setAttribute("error", "Failed to delete customer.");
            }
        } else {
            request.setAttribute("error", "Invalid username.");
        }

        // Refresh list after deletion
        List<CustomerModel> customers = customerService.getAllCustomers();
        request.setAttribute("customers", customers);

        request.getRequestDispatcher("/WEB-INF/pages/customer.jsp").forward(request, response);
    }
}
