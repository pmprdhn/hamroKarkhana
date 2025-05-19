package com.hamroKarkhana.service;

import java.sql.*;

public class PlaceOrderService {
    private String jdbcURL = "jdbc:mysql://localhost:3306/hamro-karkhana?useSSL=false&serverTimezone=UTC";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public boolean placeOrder(String username, String modelNo) {
        String address = null;
        String getAddressSQL = "SELECT address FROM customerInfo WHERE username = ?";
        String insertOrderSQL = "INSERT INTO orders (username, orderDate, orderStatus, address, modelNo) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = getConnection()) {
            // Fetch address from customerInfo
            try (PreparedStatement ps = conn.prepareStatement(getAddressSQL)) {
                ps.setString(1, username);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        address = rs.getString("address");
                    } else {
                        // User not found, fail to place order
                        return false;
                    }
                }
            }

            // Insert into orders table
            try (PreparedStatement ps = conn.prepareStatement(insertOrderSQL)) {
                ps.setString(1, username);

                Timestamp now = new Timestamp(System.currentTimeMillis());
                ps.setTimestamp(2, now);

                ps.setString(3, "pending"); // default order status
                ps.setString(4, address);
                ps.setString(5, modelNo);

                int rowsInserted = ps.executeUpdate();
                return rowsInserted > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
}
