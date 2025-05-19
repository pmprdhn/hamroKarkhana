package com.hamroKarkhana.service;

import com.hamroKarkhana.model.CustomerModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerService {

    private final String jdbcURL = "jdbc:mysql://localhost:3306/hamro-karkhana";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "";

    private static final String SELECT_ALL_CUSTOMERS = "SELECT name, username, email, phoneNumber, address, gender FROM customerInfo";
    private static final String DELETE_CUSTOMER_BY_USERNAME = "DELETE FROM customerInfo WHERE username = ?";

    // Get all customers
    public List<CustomerModel> getAllCustomers() {
        List<CustomerModel> customers = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement statement = connection.prepareStatement(SELECT_ALL_CUSTOMERS)) {

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                customers.add(new CustomerModel(
                    rs.getString("name"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("phoneNumber"),
                    rs.getString("address"),
                    rs.getString("gender")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customers;
    }

    // Delete customer by username
    public boolean deleteCustomerByUsername(String username) {
        boolean isDeleted = false;

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement statement = connection.prepareStatement(DELETE_CUSTOMER_BY_USERNAME)) {

            statement.setString(1, username);
            int affectedRows = statement.executeUpdate();
            isDeleted = affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isDeleted;
    }
}
