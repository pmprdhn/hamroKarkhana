package com.hamroKarkhana.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.hamroKarkhana.config.DbConfig;
import com.hamroKarkhana.model.ProductModel;
import com.hamroKarkhana.service.AddProductService;

@MultipartConfig
@WebServlet("/addProduct")
public class AddProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddProductController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/adminProduct");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedIn") == null) {
            System.out.println("Redirected to login due to no session");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            ProductModel product = extractProductModel(request);
            AddProductService service = new AddProductService();

            // Validate duplicate modelNo
            if (isModelNoDuplicate(product.getModelNo())) {
                session.setAttribute("error", "Product with Model No " + product.getModelNo() + " already exists.");
                response.sendRedirect(request.getContextPath() + "/adminProduct");
                return;
            }

            Boolean isCreated = service.AddProduct(product);
            if (isCreated == null || !isCreated) {
                session.setAttribute("error", "Could not add product. Please try again later!");
            } else {
                session.setAttribute("success", "Product added successfully!");
            }
            response.sendRedirect(request.getContextPath() + "/adminProduct");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An unexpected error occurred. Please try again later!");
            response.sendRedirect(request.getContextPath() + "/adminProduct");
        }
    }

    private ProductModel extractProductModel(HttpServletRequest req) throws IOException, ServletException {
        Part imagePart = req.getPart("image");
        String fileName = imagePart.getSubmittedFileName();

        String uploadDirPath = req.getServletContext().getRealPath("/resources/images/system");
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String imagePath = uploadDirPath + File.separator + fileName;
        imagePart.write(imagePath);

        String modelNo = req.getParameter("modelNo");
        String company = req.getParameter("brand");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        int price = Integer.parseInt(req.getParameter("price"));
        int stock = Integer.parseInt(req.getParameter("stock"));

        return new ProductModel(fileName, modelNo, company, title, description, price, stock);
    }

    private boolean isModelNoDuplicate(String modelNo) {
        String sql = "SELECT COUNT(*) FROM product WHERE modelNo = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, modelNo);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
}