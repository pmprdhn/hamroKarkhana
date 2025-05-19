package com.hamroKarkhana.service;

import com.hamroKarkhana.model.ProductModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {

    private final String jdbcURL = "jdbc:mysql://localhost:3306/hamro-karkhana";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "";

    private static final String SELECT_ALL_PRODUCTS = "SELECT image, modelNo, brand, title, description, price, stock FROM product";

    public List<ProductModel> getAllProducts() {
        List<ProductModel> products = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement statement = connection.prepareStatement(SELECT_ALL_PRODUCTS)) {

            ResultSet rs = statement.executeQuery();

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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
    
    public List<ProductModel> searchProductsByTitle(String keyword) {
        List<ProductModel> products = new ArrayList<>();
        String sql = "SELECT image, modelNo, brand, title, description, price, stock FROM product WHERE title LIKE ?";

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, "%" + keyword + "%");
            ResultSet rs = statement.executeQuery();

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
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
    
    public List<ProductModel> getFeaturedProducts() {
        List<ProductModel> featured = new ArrayList<>();
        String query = "SELECT image, modelNo, brand, title, description, price, stock FROM product LIMIT 4";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductModel product = new ProductModel();
                product.setImage(rs.getString("image"));
                product.setModelNo(rs.getString("modelNo"));
                product.setBrand(rs.getString("brand"));
                product.setTitle(rs.getString("title"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getInt("price"));
                product.setStock(rs.getInt("stock"));
                featured.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return featured;
    }


}
