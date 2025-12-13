package com.org.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dao.CakeDAO;
import com.org.model.Cake;

@WebServlet("/AddCakeServlet")
public class AddCakeServlet extends HttpServlet {
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
            String cakeName = request.getParameter("cakeName");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String imagePath = request.getParameter("imagePath");
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            boolean isAvailable = "true".equals(request.getParameter("isAvailable"));
            boolean isFeatured = "true".equals(request.getParameter("isFeatured"));
            
            // If image path is empty, use placeholder
            if (imagePath == null || imagePath.trim().isEmpty()) {
                imagePath = "https://via.placeholder.com/400x300/FFB6C1/8B4513?text=" + 
                           cakeName.replace(" ", "+");
            }
            
            // Create Cake object
            Cake cake = new Cake();
            cake.setCakeName(cakeName);
            cake.setDescription(description);
            cake.setPrice(price);
            cake.setCategoryId(categoryId);
            cake.setImagePath(imagePath);
            cake.setStockQuantity(stockQuantity);
            cake.setAvailable(isAvailable);
            cake.setFeatured(isFeatured);
            
            // Add cake to database
            CakeDAO cakeDAO = new CakeDAO();
            boolean success = cakeDAO.addCake(cake);
            
            if (success) {
                System.out.println("✅ Cake added successfully: " + cakeName);
                response.sendRedirect("ManageCakes.jsp?msg=added");
            } else {
                System.out.println("❌ Failed to add cake: " + cakeName);
                response.sendRedirect("AddCake.jsp?msg=error");
            }
            
        } catch (Exception e) {
            System.out.println("❌ Error in AddCakeServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("AddCake.jsp?msg=error");
        }
    }
}

