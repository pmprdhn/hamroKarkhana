package com.hamroKarkhana.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.hamroKarkhana.model.ProductModel;
import com.hamroKarkhana.service.DeleteProductService;

@WebServlet("/deleteProduct")
public class DeleteProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doPost called for /deleteProduct");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedIn") == null) {
            System.out.println("Redirecting to login due to invalid session");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String modelNo = request.getParameter("modelNo");
            if (modelNo == null || modelNo.trim().isEmpty()) {
                throw new IllegalArgumentException("Model number is required.");
            }

            DeleteProductService service = new DeleteProductService();
            boolean deleted = service.deleteProduct(modelNo);

            List<ProductModel> products = service.getAllProducts();
            System.out.println("Setting products attribute with " + products.size() + " items after delete");
            request.setAttribute("products", products);

            if (deleted) {
                request.setAttribute("success", "Product deleted successfully!");
            } else {
                request.setAttribute("error", "Could not delete product. Please try again.");
            }

            request.getRequestDispatcher("/WEB-INF/pages/admin-product.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            System.err.println("Invalid model number: " + e.getMessage());
            request.setAttribute("error", "Invalid model number.");
            DeleteProductService service = new DeleteProductService();
            request.setAttribute("products", service.getAllProducts());
            request.getRequestDispatcher("/WEB-INF/pages/admin-product.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred while deleting the product.");
            DeleteProductService service = new DeleteProductService();
            request.setAttribute("products", service.getAllProducts());
            request.getRequestDispatcher("/WEB-INF/pages/admin-product.jsp").forward(request, response);
        }
    }
}