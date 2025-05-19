package com.hamroKarkhana.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.hamroKarkhana.config.DbConfig;
import com.hamroKarkhana.model.ProductModel;

public class AddProductService {
    private Connection conn;

    public AddProductService() {
        try {
            this.conn = DbConfig.getDbConnection();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            this.conn = null;
        }
    }

    public Boolean AddProduct(ProductModel product) {
        if (conn == null) {
            System.out.println("Database connection is null.");
            return false;
        }
        String insertQuery = "INSERT INTO product (image, modelNo, brand, title, description, price, stock) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
            insertStmt.setString(1, product.getImage());
            insertStmt.setString(2, product.getModelNo());
            insertStmt.setString(3, product.getBrand());
            insertStmt.setString(4, product.getTitle());
            insertStmt.setString(5, product.getDescription());
            insertStmt.setInt(6, product.getPrice());
            insertStmt.setInt(7, product.getStock());
            return insertStmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error during product adding: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Close connection when done (optional, depending on DbConfig)
    public void closeConnection() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}