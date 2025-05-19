package com.hamroKarkhana.service;

import java.sql.*;

public class UpdateOrderService {
    private String jdbcURL = "jdbc:mysql://localhost:3306/hamro-karkhana?useSSL=false&serverTimezone=UTC";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String UPDATE_ORDER_STATUS = "UPDATE orders SET orderStatus = ? WHERE orderID = ?";

    public boolean updateOrderStatus(int orderID, String newStatus) {
        boolean rowUpdated = false;

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement statement = connection.prepareStatement(UPDATE_ORDER_STATUS)) {

            Class.forName("com.mysql.cj.jdbc.Driver");

            statement.setString(1, newStatus);
            statement.setInt(2, orderID);
            rowUpdated = statement.executeUpdate() > 0;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return rowUpdated;
    }
}
