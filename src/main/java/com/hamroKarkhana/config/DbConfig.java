package com.hamroKarkhana.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DbConfig is a configuration class for managing database connections. It
 * handles the connection to a MySQL database using JDBC.
 */
public class DbConfig {

    private static final Logger LOGGER = Logger.getLogger(DbConfig.class.getName());

    // Database configuration information
    private static final String DB_NAME = "hamro-karkhana";
    private static final String URL = "jdbc:mysql://localhost:3306/" + DB_NAME;
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";

    /**
     * Establishes a connection to the database.
     *
     * @return Connection object for the database
     * @throws SQLException           if a database access error occurs
     * @throws ClassNotFoundException if the JDBC driver class is not found
     */
    public static Connection getDbConnection() throws SQLException, ClassNotFoundException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            LOGGER.log(Level.INFO, "JDBC Driver registered successfully.");
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            LOGGER.log(Level.INFO, "Connected to the database successfully.");
            return connection;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Database connection failed.", e);
            throw e;  
        }
    }
}
