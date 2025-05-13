package com.hamroKarkhana.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.hamroKarkhana.config.DbConfig;
import com.hamroKarkhana.model.CustomerModel;
import com.hamroKarkhana.util.PasswordUtil;

/**
 * Service class for handling login operations. Connects to the database,
 * verifies user credentials, and returns login status.
 */
public class LoginService {

    private Connection dbConn;
    private boolean isConnectionError = false;

    /**
     * Constructor initializes the database connection. Sets the connection error
     * flag if the connection fails.
     */
    public LoginService() {
        try {
            dbConn = DbConfig.getDbConnection();
            System.out.println("Database connection initialized.");
        } catch (SQLException | ClassNotFoundException ex) {
            System.out.println("Failed to initialize database connection: " + ex.getMessage());
            isConnectionError = true;
        }
    }

    /**
     * Validates the user credentials against the database records.
     *
     * @param customerModel the CustomerModel object containing user credentials
     * @return true if the user credentials are valid, false otherwise; null if a
     *         connection error occurs
     */
    public Boolean loginUser(CustomerModel customerModel) {
        if (isConnectionError) {
            System.out.println("Database connection error. Unable to perform login.");
            return null;
        }

        // Updated query with correct table name "customerInfo"
        String query = "SELECT username, password FROM customerInfo WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, customerModel.getUsername());
            ResultSet result = stmt.executeQuery();

            if (result.next()) {
                System.out.println("User found in database: " + customerModel.getUsername());
                return validatePassword(result, customerModel);
            } else {
                System.out.println("User not found: " + customerModel.getUsername());
            }
        } catch (SQLException e) {
            System.out.println("Database error while executing login query: " + e.getMessage());
            e.printStackTrace();
            return null;
        }

        return false;
    }
    
    /**
     * Fetches full user details from the database based on username.
     *
     * @param username the username to search for
     * @return CustomerModel with user details if found; otherwise null
     */
    public CustomerModel getUserDetails(String username) {
        if (isConnectionError) {
            System.out.println("Database connection error. Unable to fetch user details.");
            return null;
        }

        String query = "SELECT name, username, email, phoneNumber, address, gender, profilePicture FROM customerInfo WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet result = stmt.executeQuery();

            if (result.next()) {
                CustomerModel customer = new CustomerModel();
                customer.setName(result.getString("name"));
                customer.setUsername(result.getString("username"));
                customer.setEmail(result.getString("email"));
                customer.setPhoneNumber(result.getString("phoneNumber"));
                customer.setAddress(result.getString("address"));
                customer.setGender(result.getString("gender"));
                customer.setProfilePicture(result.getString("profilePicture"));

                return customer;
            } else {
                System.out.println("No user details found for username: " + username);
            }
        } catch (SQLException e) {
            System.out.println("Database error while fetching user details: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }


    /**
     * Validates the password retrieved from the database.
     *
     * @param result        the ResultSet containing the username and password from
     *                      the database
     * @param customerModel the CustomerModel object containing user credentials
     * @return true if the passwords match, false otherwise
     * @throws SQLException if a database access error occurs
     */
    private boolean validatePassword(ResultSet result, CustomerModel customerModel) throws SQLException {
        String dbUsername = result.getString("username");
        String dbPassword = result.getString("password");

        if (dbUsername.equals(customerModel.getUsername())) {
            String decryptedPassword = PasswordUtil.decrypt(dbPassword, dbUsername);
            boolean isPasswordValid = decryptedPassword.equals(customerModel.getPassword());

            if (isPasswordValid) {
                System.out.println("Password matched for user: " + customerModel.getUsername());
            } else {
                System.out.println("Invalid password attempt for user: " + customerModel.getUsername());
            }

            return isPasswordValid;
        }

        return false;
    }
}
