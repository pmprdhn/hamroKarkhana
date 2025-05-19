package com.hamroKarkhana.service;

import com.hamroKarkhana.model.OrderModel;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DisplayOrderService {
    private String jdbcURL = "jdbc:mysql://localhost:3306/hamro-karkhana?useSSL=false&serverTimezone=UTC";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String SELECT_ALL_ORDERS = 
        "SELECT o.orderID, c.name AS customerName, p.title AS productTitle, " +
        "o.orderDate, p.price AS totalAmount, o.orderStatus, o.address " +
        "FROM orders o " +
        "JOIN customerInfo c ON o.username = c.username " +
        "JOIN product p ON o.modelNo = p.modelNo";

    private Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<OrderModel> getAllOrders() {
        List<OrderModel> orders = new ArrayList<>();
        try (
            Connection connection = getConnection();
            PreparedStatement ps = connection.prepareStatement(SELECT_ALL_ORDERS);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                int orderID = rs.getInt("orderID");
                String customerName = rs.getString("customerName");
                String productTitle = rs.getString("productTitle");

                String orderDate = rs.getString("orderDate");
                if (orderDate == null) {
                    orderDate = new java.text.SimpleDateFormat("yyyy-MM-dd")
                        .format(rs.getDate("orderDate"));
                }

                int totalAmount = rs.getInt("totalAmount");
                String orderStatus = rs.getString("orderStatus");
                String address = rs.getString("address");

                OrderModel order = new OrderModel(orderID, customerName, productTitle, orderDate, totalAmount, orderStatus, address);
                orders.add(order);
            }
        } catch (SQLException e) {
            System.err.println("SQL error while fetching orders: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }
}
