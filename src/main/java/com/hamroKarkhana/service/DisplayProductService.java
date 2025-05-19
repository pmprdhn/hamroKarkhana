package com.hamroKarkhana.service;

import com.hamroKarkhana.model.ProductModel;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DisplayProductService {

    private static final String URL = "jdbc:mysql://localhost:3306/hamro-karkhana";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // Replace with your DB password

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
    }

    public List<ProductModel> getAllProducts() {
        List<ProductModel> products = new ArrayList<>();
        String sql = "SELECT * FROM product";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ProductModel product = new ProductModel();
                product.setImage(rs.getString("image"));
                product.setModelNo(rs.getString("modelNo"));
                product.setBrand(rs.getString("brand"));
                product.setTitle(rs.getString("title"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getInt("price"));
                product.setStock(rs.getInt("stock"));
                products.add(product);
                System.out.println("Fetched product: " + product.getModelNo());
            }
            System.out.println("Total products fetched: " + products.size());
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQL Error: " + e.getMessage());
        }
        return products; // Always return the list, even if empty
    }
}