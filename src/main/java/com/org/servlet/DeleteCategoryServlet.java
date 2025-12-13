package com.org.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dao.CategoryDAO;

@WebServlet("/DeleteCategoryServlet")
public class DeleteCategoryServlet extends HttpServlet {
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
            // Get category ID from URL parameter
            String categoryIdParam = request.getParameter("id");
            
            if (categoryIdParam == null || categoryIdParam.trim().isEmpty()) {
                response.sendRedirect("ManageCategories.jsp?msg=error");
                return;
            }
            
            int categoryId = Integer.parseInt(categoryIdParam);
            
            // Check if category has cakes
            CategoryDAO categoryDAO = new CategoryDAO();
            int cakesCount = categoryDAO.getCakesCountByCategory(categoryId);
            
            if (cakesCount > 0) {
                System.out.println("⚠️ Cannot delete category with " + cakesCount + " cakes");
                response.sendRedirect("ManageCategories.jsp?msg=has_cakes");
                return;
            }
            
            // Delete category from database
            boolean success = categoryDAO.deleteCategory(categoryId);
            
            if (success) {
                System.out.println("✅ Category deleted successfully: ID " + categoryId);
                response.sendRedirect("ManageCategories.jsp?msg=deleted");
            } else {
                System.out.println("❌ Failed to delete category: ID " + categoryId);
                response.sendRedirect("ManageCategories.jsp?msg=error");
            }
            
        } catch (Exception e) {
            System.out.println("❌ Error in DeleteCategoryServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("ManageCategories.jsp?msg=error");
        }
    }
}

