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
                session.setAttribute("error", "Model number is required.");
                response.sendRedirect(request.getContextPath() + "/adminProduct");
                return;
            }

            DeleteProductService service = new DeleteProductService();
            boolean deleted = service.deleteProduct(modelNo);

            if (deleted) {
                session.setAttribute("success", "Product deleted successfully!");
            } else {
                session.setAttribute("error", "Could not delete product. Please try again.");
            }

            response.sendRedirect(request.getContextPath() + "/adminProduct");
            return;

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An unexpected error occurred while deleting the product.");
            response.sendRedirect(request.getContextPath() + "/adminProduct");
        }
    }

}