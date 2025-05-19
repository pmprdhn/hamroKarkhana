package com.hamroKarkhana.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.hamroKarkhana.config.DbConfig;
import com.hamroKarkhana.model.ProductModel;

public class UpdateProductService {

    public boolean deleteProduct(String modelNo) {
        String query = "DELETE FROM product WHERE modelNo = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, modelNo);
            System.out.println("Executing SQL: " + stmt.toString());
            return stmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error deleting product: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<ProductModel> getAllProducts() {
        List<ProductModel> products = new ArrayList<>();
        String query = "SELECT modelNo, brand, title, description, price, stock, image FROM product";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String modelNo = rs.getString("modelNo");
                String brand = rs.getString("brand");
                String title = rs.getString("title");
                String description = rs.getString("description");
                int price = rs.getInt("price");
                int stock = rs.getInt("stock");
                String image = rs.getString("image");
                products.add(new ProductModel(image,modelNo, brand, title, description, price, stock));
            }
            System.out.println("Retrieved " + products.size() + " products from database");
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error retrieving products: " + e.getMessage());
            e.printStackTrace();
        }
        return products;
    }

    public boolean updateProduct(ProductModel product) {
        String query = "UPDATE product SET brand = ?, title = ?, description = ?, price = ?, stock = ?, image = ? WHERE modelNo = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, product.getBrand());
            stmt.setString(2, product.getTitle());
            stmt.setString(3, product.getDescription());
            stmt.setInt(4, product.getPrice());
            stmt.setInt(5, product.getStock());
            stmt.setString(6, product.getImage() != null ? product.getImage() : null);
            stmt.setString(7, product.getModelNo());
            System.out.println("Executing SQL: " + stmt.toString());
            
            System.out.println("Updating product:");
            System.out.println("Brand: " + product.getBrand());
            System.out.println("Title: " + product.getTitle());
            System.out.println("Description: " + product.getDescription());
            System.out.println("Price: " + product.getPrice());
            System.out.println("Stock: " + product.getStock());
            System.out.println("Image: " + product.getImage());
            System.out.println("ModelNo: " + product.getModelNo());

            return stmt.executeUpdate() > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error updating product: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public ProductModel getProductByModelNo(String modelNo) {
        String query = "SELECT modelNo, brand, title, description, price, stock, image FROM product WHERE modelNo = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, modelNo);
            System.out.println("Executing SQL: " + stmt.toString());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String brand = rs.getString("brand");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    int price = rs.getInt("price");
                    int stock = rs.getInt("stock");
                    String image = rs.getString("image");
                    return new ProductModel(image,modelNo, brand, title, description, price, stock);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error retrieving product: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}