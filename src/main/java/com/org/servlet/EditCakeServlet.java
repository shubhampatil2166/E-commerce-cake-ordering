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

@WebServlet("/EditCakeServlet")
public class EditCakeServlet extends HttpServlet {
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
            int cakeId = Integer.parseInt(request.getParameter("cakeId"));
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
            cake.setCakeId(cakeId);
            cake.setCakeName(cakeName);
            cake.setDescription(description);
            cake.setPrice(price);
            cake.setCategoryId(categoryId);
            cake.setImagePath(imagePath);
            cake.setStockQuantity(stockQuantity);
            cake.setAvailable(isAvailable);
            cake.setFeatured(isFeatured);
            
            // Update cake in database
            CakeDAO cakeDAO = new CakeDAO();
            boolean success = cakeDAO.updateCake(cake);
            
            if (success) {
                System.out.println("✅ Cake updated successfully: " + cakeName);
                response.sendRedirect("ManageCakes.jsp?msg=updated");
            } else {
                System.out.println("❌ Failed to update cake: " + cakeName);
                response.sendRedirect("EditCake.jsp?id=" + cakeId + "&msg=error");
            }
            
        } catch (Exception e) {
            System.out.println("❌ Error in EditCakeServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("ManageCakes.jsp?msg=error");
        }
    }
}
