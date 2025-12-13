package com.org.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.org.util.DBConnection;

@WebServlet("/UserSignUpServlet")
public class UserSignUpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try {
            Connection con = DBConnection.getConnection();
            
            // Check if email already exists
            PreparedStatement checkPs = con.prepareStatement("SELECT id FROM users WHERE email = ?");
            checkPs.setString(1, email);
            ResultSet rs = checkPs.executeQuery();
            
            if (rs.next()) {
                // Email already exists
                System.out.println("❌ Sign up failed: Email already exists - " + email);
                response.sendRedirect("UserSignUp.jsp?msg=exists");
            } else {
                // Insert new user
                PreparedStatement insertPs = con.prepareStatement(
                    "INSERT INTO users (full_name, email, password, role) VALUES (?, ?, ?, ?)"
                );
                insertPs.setString(1, fullName);
                insertPs.setString(2, email);
                insertPs.setString(3, password);
                insertPs.setString(4, "user");
                
                int rows = insertPs.executeUpdate();
                
                if (rows > 0) {
                    System.out.println("✅ Sign up successful: " + fullName);
                    response.sendRedirect("Login.jsp?msg=success");
                } else {
                    System.out.println("❌ Sign up failed for: " + email);
                    response.sendRedirect("UserSignUp.jsp?msg=error");
                }
                
                insertPs.close();
            }
            
            rs.close();
            checkPs.close();
            con.close();
            
        } catch (Exception e) {
            System.out.println("❌ ERROR in UserSignUpServlet:");
            e.printStackTrace();
            response.sendRedirect("UserSignUp.jsp?msg=error");
        }
    }
}

