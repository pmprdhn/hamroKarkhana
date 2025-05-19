package com.hamroKarkhana.service;

import com.hamroKarkhana.model.ProductModel;

import java.sql.*;

public class OneProductService {

    public ProductModel getProductByModelNo(String modelNo) {
        ProductModel product = null;

        String jdbcURL = "jdbc:mysql://localhost:3306/hamro-karkhana";
        String dbUser = "root";
        String dbPassword = "";

        String sql = "SELECT * FROM product WHERE modelNo = ?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, modelNo);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    product = new ProductModel();
                    product.setModelNo(rs.getString("modelNo"));
                    product.setImage(rs.getString("image"));
                    product.setTitle(rs.getString("title"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getInt("price"));
                    // add other fields if needed
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }
}
