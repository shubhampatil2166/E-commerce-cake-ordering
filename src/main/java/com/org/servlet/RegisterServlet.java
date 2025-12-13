package com.org.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.org.model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection parameters
    private String jdbcURL = "jdbc:mysql://localhost:3306/cakeshopDB"; // replace with your DB name
    private String jdbcUsername = "root";
    private String jdbcPassword = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("UserSignUp.jsp?msg=fail");
            return;
        }

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // Check if email already exists
            PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM users WHERE email = ?");
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Email already exists
                response.sendRedirect("UserSignUp.jsp?msg=fail");
            } else {
                // Insert new user
                PreparedStatement insertStmt = con.prepareStatement(
                        "INSERT INTO users (full_name, email, password, role) VALUES (?, ?, ?, ?)");
                insertStmt.setString(1, fullName);
                insertStmt.setString(2, email);
                insertStmt.setString(3, password);
                insertStmt.setString(4, "user"); // default role

                int rows = insertStmt.executeUpdate();

                if (rows > 0) {
                    // Registration successful
                    response.sendRedirect("UserSignUp.jsp?msg=success");
                } else {
                    response.sendRedirect("UserSignUp.jsp?msg=fail");
                }
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UserSignUp.jsp?msg=fail");
        }
    }
}

