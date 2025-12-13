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

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email = ?")) {
            
            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Email exists - success
                    System.out.println("✅ Password reset requested for: " + email);
                    response.sendRedirect("ForgotPassword.jsp?msg=success");
                } else {
                    // Email not found
                    System.out.println("❌ Email not found: " + email);
                    response.sendRedirect("ForgotPassword.jsp?msg=fail");
                }
            }
        } catch (Exception e) {
            System.out.println("❌ ERROR in ForgotPasswordServlet:");
            e.printStackTrace();
            response.sendRedirect("ForgotPassword.jsp?msg=fail");
        }
    }
}

