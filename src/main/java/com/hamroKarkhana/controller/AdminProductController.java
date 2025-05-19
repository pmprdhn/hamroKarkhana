package com.hamroKarkhana.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.hamroKarkhana.model.ProductModel;
import com.hamroKarkhana.service.DisplayProductService;

@WebServlet("/adminProduct")
public class AdminProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DisplayProductService productService = new DisplayProductService();
        List<ProductModel> products = productService.getAllProducts();

        if (products == null) {
            request.setAttribute("error", "Unable to fetch products. Please try again later.");
        } else {
            request.setAttribute("products", products);
        }

        request.getRequestDispatcher("/WEB-INF/pages/admin-product.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}














