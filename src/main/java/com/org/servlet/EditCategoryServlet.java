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

@WebServlet("/EditCategoryServlet")
public class EditCategoryServlet extends HttpServlet {
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
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String categoryName = request.getParameter("categoryName");
            String description = request.getParameter("description");
            
            // Create Category object
            Category category = new Category();
            category.setCategoryId(categoryId);
            category.setCategoryName(categoryName);
            category.setDescription(description);
            
            // Update category in database
            CategoryDAO categoryDAO = new CategoryDAO();
            boolean success = categoryDAO.updateCategory(category);
            
            if (success) {
                System.out.println("✅ Category updated successfully: " + categoryName);
                response.sendRedirect("ManageCategories.jsp?msg=updated");
            } else {
                System.out.println("❌ Failed to update category: " + categoryName);
                response.sendRedirect("EditCategory.jsp?id=" + categoryId + "&msg=error");
            }
            
        } catch (Exception e) {
            System.out.println("❌ Error in EditCategoryServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("ManageCategories.jsp?msg=error");
        }
    }
}

