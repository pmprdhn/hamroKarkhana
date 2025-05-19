package com.hamroKarkhana.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import com.hamroKarkhana.model.ProductModel;
import com.hamroKarkhana.service.UpdateProductService;

@WebServlet("/updateProduct")
@MultipartConfig

public class UpdateProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "resources/images/system";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doPost called for /updateProduct");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedIn") == null) {
            System.out.println("Redirecting to login due to invalid session");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String modelNo = request.getParameter("editModelNo");
            
            System.out.println("Received modelNo from form: " + modelNo);

            String brand = request.getParameter("brand");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int price = Integer.parseInt(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            String image = null;
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
            	
            	
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + UPLOAD_DIR;
                Path uploadDir = Paths.get(uploadPath);
                if (!Files.exists(uploadDir)) {
                    Files.createDirectories(uploadDir);
                }
                String filePath = uploadPath + "/" + fileName;
                filePart.write(filePath);
                image = fileName;
            }
            
            if (image == null || image.isEmpty()) {
                UpdateProductService service = new UpdateProductService();
                ProductModel existingProduct = service.getProductByModelNo(modelNo);
                if (existingProduct != null) {
                    image = existingProduct.getImage();
                }
            }


            ProductModel product = new ProductModel(image,modelNo, brand, title, description, price, stock);
            UpdateProductService service = new UpdateProductService();
            boolean updated = service.updateProduct(product);

            List<ProductModel> products = service.getAllProducts();
            System.out.println("Setting products attribute with " + products.size() + " items after update");
            request.setAttribute("products", products);

            if (updated) {
                request.setAttribute("success", "Product updated successfully!");
            } else {
                request.setAttribute("error", "Could not update product. Please try again.");
            }

            request.getRequestDispatcher("/WEB-INF/pages/admin-product.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.err.println("Invalid input: " + e.getMessage());
            request.setAttribute("error", "Invalid input: Price and stock must be valid numbers.");
            UpdateProductService service = new UpdateProductService();
            request.setAttribute("products", service.getAllProducts());
            request.getRequestDispatcher("/WEB-INF/pages/admin-product.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred while updating the product.");
            UpdateProductService service = new UpdateProductService();
            request.setAttribute("products", service.getAllProducts());
            request.getRequestDispatcher("/WEB-INF/pages/admin-product.jsp").forward(request, response);
        }
    }
}