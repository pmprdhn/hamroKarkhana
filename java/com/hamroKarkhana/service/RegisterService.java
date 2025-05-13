package com.hamroKarkhana.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.hamroKarkhana.config.DbConfig;
import com.hamroKarkhana.model.CustomerModel;

/**
 * RegisterService handles the registration of new customers. It manages database
 * interactions for customer registration.
 */
public class RegisterService {

    private Connection dbConn;

    /**
     * Constructor initializes the database connection.
     */
    public RegisterService() {
    	String  error;
        try {
            System.out.println("Attempting to establish database connection...");
            this.dbConn = DbConfig.getDbConnection();
            System.out.println("Database connection established successfully.");
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    /**
     * Registers a new customer in the database.
     *
     * @param customerModel the customer details to be registered
     * @return Boolean indicating the success of the operation
     */
    public String registerCustomer(CustomerModel customerModel) {
        if (dbConn == null) {
            System.err.println("Database connection is not available.");
            return null;
        }

        String checkUsernameQuery = "SELECT COUNT(*) FROM customerInfo WHERE username = ?";
        String checkEmailQuery = "SELECT COUNT(*) FROM customerInfo WHERE email = ?";
        String insertQuery = "INSERT INTO customerInfo (name, username, email, phoneNumber, address, gender, password, profilePicture) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement checkUsernameStmt = dbConn.prepareStatement(checkUsernameQuery);
             PreparedStatement checkEmailStmt = dbConn.prepareStatement(checkEmailQuery);
             PreparedStatement insertStmt = dbConn.prepareStatement(insertQuery)) {

            System.out.println("Checking if username already exists: " + customerModel.getUsername());
            checkUsernameStmt.setString(1, customerModel.getUsername());
            ResultSet usernameResult = checkUsernameStmt.executeQuery();
            if (usernameResult.next() && usernameResult.getInt(1) > 0) {
                System.out.println("Username already exists in database.");
                
                return "username_exists";
            }

            System.out.println("Checking if email already exists: " + customerModel.getEmail());
            checkEmailStmt.setString(1, customerModel.getEmail());
            ResultSet emailResult = checkEmailStmt.executeQuery();
            if (emailResult.next() && emailResult.getInt(1) > 0) {
                System.out.println("Email already exists in database.");
                return "email_exists";
            }

            System.out.println("Inserting new customer into database...");
            insertStmt.setString(1, customerModel.getName());
            insertStmt.setString(2, customerModel.getUsername());
            insertStmt.setString(3, customerModel.getEmail());
            insertStmt.setString(4, customerModel.getPhoneNumber());
            insertStmt.setString(5, customerModel.getAddress());
            insertStmt.setString(6, customerModel.getGender());
            insertStmt.setString(7, customerModel.getPassword());
            insertStmt.setString(8, customerModel.getProfilePicture());

            int rowsAffected = insertStmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            return rowsAffected > 0? "success": "insert_failed";

        } catch (SQLException e) {
            System.err.println("Error during customer registration: " + e.getMessage());
            e.printStackTrace();
            return "db_error";
        }
    }
}
