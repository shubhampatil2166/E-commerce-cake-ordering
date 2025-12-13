package com.org.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dao.UserDAO;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin authentication
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("Login.jsp?error=Admin access required");
            return;
        }
        
        try {
            // Get user ID from URL parameter
            String userIdParam = request.getParameter("id");
            
            if (userIdParam == null || userIdParam.trim().isEmpty()) {
                response.sendRedirect("ManageUsers.jsp?msg=error");
                return;
            }
            
            int userId = Integer.parseInt(userIdParam);
            
            // Prevent deletion of admin accounts
            // (You can add more sophisticated check by querying role from database)
            Integer currentAdminId = (Integer) session.getAttribute("userId");
            if (currentAdminId != null && currentAdminId == userId) {
                System.out.println("⚠️ Cannot delete currently logged-in admin");
                response.sendRedirect("ManageUsers.jsp?msg=cannot_delete_admin");
                return;
            }
            
            // Delete user from database
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.deleteUser(userId);
            
            if (success) {
                System.out.println("✅ User deleted successfully: ID " + userId);
                response.sendRedirect("ManageUsers.jsp?msg=deleted");
            } else {
                System.out.println("❌ Failed to delete user: ID " + userId);
                response.sendRedirect("ManageUsers.jsp?msg=error");
            }
            
        } catch (Exception e) {
            System.out.println("❌ Error in DeleteUserServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("ManageUsers.jsp?msg=error");
        }
    }
}

