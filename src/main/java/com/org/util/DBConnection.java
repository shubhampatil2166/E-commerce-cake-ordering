package com.org.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	  private static final String URL = "jdbc:mysql://localhost:3306/cakeshop";
	    private static final String USERNAME = "root";
	    private static final String PASSWORD = "Patil@123";
	    
	    // Load driver once when class is loaded
	    static {
	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	        } catch (ClassNotFoundException e) {
	            e.printStackTrace();
	            throw new RuntimeException("MySQL Driver not found", e);
	        }
	    }
	    
	    // Create a NEW connection each time (correct approach)
	    public static Connection getConnection() throws SQLException {
	        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
	    }

}
