package com.hamroKarkhana.service;

import com.hamroKarkhana.model.CustomerModel;
import com.hamroKarkhana.config.DbConfig;
import java.sql.*;

public class UserCustomerService {

    public CustomerModel getCustomerByUsername(String username) {
        CustomerModel customer = null;

        try (Connection conn = DbConfig.getDbConnection()) {
            String query = "SELECT * FROM customerInfo WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                customer = new CustomerModel();
                customer.setName(rs.getString("name"));
                customer.setUsername(rs.getString("username"));
                customer.setEmail(rs.getString("email"));
                customer.setPhoneNumber(rs.getString("phoneNumber"));
                customer.setAddress(rs.getString("address"));
                customer.setGender(rs.getString("gender"));
                customer.setPassword(rs.getString("password"));
                customer.setProfilePicture(rs.getString("profilePicture"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return customer;
    }

    public boolean updateCustomer(CustomerModel customer) {
        String updateSQL = "UPDATE customerInfo SET name = ?, email = ?, phoneNumber = ?, address = ?, gender = ?, profilePicture = ? WHERE username = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(updateSQL)) {

            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhoneNumber());
            stmt.setString(4, customer.getAddress());
            stmt.setString(5, customer.getGender());
            stmt.setString(6, customer.getProfilePicture());
            stmt.setString(7, customer.getUsername());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error during database operation.");
            e.printStackTrace();
            return false;
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
            return false;
        }
    }

}
