package com.org.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dao.CategoryDAO;
import com.org.model.Category;

@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin authentication
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("Login.jsp?error=Admin access required");
            return;
        }
        
        try {
            // Get form parameters
            String categoryName = request.getParameter("categoryName");
            String description = request.getParameter("description");
            
            // Create Category object
            Category category = new Category();
            category.setCategoryName(categoryName);
            category.setDescription(description);
            
            // Add category to database
            CategoryDAO categoryDAO = new CategoryDAO();
            boolean success = categoryDAO.addCategory(category);
            
            if (success) {
                System.out.println("✅ Category added successfully: " + categoryName);
                response.sendRedirect("ManageCategories.jsp?msg=added");
            } else {
                System.out.println("❌ Failed to add category: " + categoryName);
                response.sendRedirect("AddCategory.jsp?msg=error");
            }
            
        } catch (Exception e) {
            System.out.println("❌ Error in AddCategoryServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("AddCategory.jsp?msg=error");
        }
    }
}

