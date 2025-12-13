package com.org.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dao.CartDAO;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            // User not logged in - redirect to login
            response.sendRedirect("Login.jsp?error=Please login to add items to cart");
            return;
        }
        
        // Get parameters
        String cakeIdStr = request.getParameter("cakeId");
        String quantityStr = request.getParameter("quantity");
        
        try {
            int cakeId = Integer.parseInt(cakeIdStr);
            int quantity = 1; // Default quantity
            
            if (quantityStr != null && !quantityStr.isEmpty()) {
                quantity = Integer.parseInt(quantityStr);
            }
            
            // Validate quantity
            if (quantity < 1) quantity = 1;
            if (quantity > 10) quantity = 10; // Max limit per add
            
            // Add to cart
            CartDAO cartDAO = new CartDAO();
            boolean success = cartDAO.addToCart(userId, cakeId, quantity);
            
            // Get the referer (previous page URL)
            String referer = request.getHeader("Referer");
            
            if (success) {
                System.out.println("✅ Item added to cart successfully");
                if (referer != null) {
                    response.sendRedirect(referer + "?msg=added");
                } else {
                    response.sendRedirect("Cakes.jsp?msg=added");
                }
            } else {
                System.out.println("❌ Failed to add item to cart");
                if (referer != null) {
                    response.sendRedirect(referer + "?msg=error");
                } else {
                    response.sendRedirect("Cakes.jsp?msg=error");
                }
            }
            
        } catch (NumberFormatException e) {
            System.out.println("❌ Invalid parameters in AddToCartServlet");
            e.printStackTrace();
            response.sendRedirect("Cakes.jsp?msg=error");
        }
    }
    
    // Also handle GET requests (for direct links)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}

