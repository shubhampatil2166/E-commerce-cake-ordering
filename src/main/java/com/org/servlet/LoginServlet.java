package com.org.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.org.util.DBConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // ✅ Hardcoded admin login
            if (email.equals("admin123@gmail.com") && password.equals("admin123")) {
                HttpSession session = request.getSession();
                session.setAttribute("role", "admin");
                session.setAttribute("userName", "Admin");
                session.setAttribute("userId", 0);
                session.setAttribute("email", email);
                response.sendRedirect("AdminDashboard.jsp");
                return;
            }

            // ✅ User login from DB
            Connection con = DBConnection.getConnection();
            
            // Changed user_id to id (or whatever your column is called)
            PreparedStatement ps = con.prepareStatement("SELECT id, full_name, email FROM users WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                
                // ✅ Set session attributes - using "id" instead of "user_id"
                session.setAttribute("userId", rs.getInt("id"));  // Changed from user_id to id
                session.setAttribute("userName", rs.getString("full_name"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("role", "user");
                
                System.out.println("✅ Login successful: " + rs.getString("full_name"));

                // Redirect to Home.jsp
                response.sendRedirect("index.jsp");
            } else {
                // Invalid credentials
                System.out.println("❌ Login failed for: " + email);
                response.sendRedirect("Login.jsp?msg=invalid");
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            System.out.println("❌ ERROR in LoginServlet:");
            e.printStackTrace();
            response.sendRedirect("Login.jsp?msg=error");
        }
    }
}
