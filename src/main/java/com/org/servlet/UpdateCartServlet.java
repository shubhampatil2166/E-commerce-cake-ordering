package com.org.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dao.CartDAO;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("Login.jsp?error=Please login first");
            return;
        }
        
        // Get parameters
        String cartIdStr = request.getParameter("cartId");
        String action = request.getParameter("action");
        String quantityStr = request.getParameter("quantity");
        
        try {
            int cartId = Integer.parseInt(cartIdStr);
            CartDAO cartDAO = new CartDAO();
            boolean success = false;
            
            if ("increase".equals(action)) {
                // Increase quantity by 1
                // We'll get current quantity, add 1, then update
                // For simplicity, we can use a direct SQL: UPDATE cart SET quantity = quantity + 1
                // But to be safe, let's get current quantity first
                
                // Actually, let's add a simpler method - just pass the action
                success = updateQuantityByAction(cartId, "increase");
                
            } else if ("decrease".equals(action)) {
                // Decrease quantity by 1 (minimum 1)
                success = updateQuantityByAction(cartId, "decrease");
                
            } else if (quantityStr != null) {
                // Direct quantity update
                int newQuantity = Integer.parseInt(quantityStr);
                if (newQuantity < 1) newQuantity = 1;
                if (newQuantity > 50) newQuantity = 50; // Max limit
                
                success = cartDAO.updateQuantity(cartId, newQuantity);
            }
            
            if (success) {
                response.sendRedirect("Cart.jsp?msg=updated");
            } else {
                response.sendRedirect("Cart.jsp?msg=error");
            }
            
        } catch (NumberFormatException e) {
            System.out.println("❌ Invalid parameters in UpdateCartServlet");
            e.printStackTrace();
            response.sendRedirect("Cart.jsp?msg=error");
        }
    }
    
    // Helper method to increase/decrease quantity
    private boolean updateQuantityByAction(int cartId, String action) {
        try (java.sql.Connection conn = com.org.util.DBConnection.getConnection()) {
            
            // Get current quantity
            String selectQuery = "SELECT quantity FROM cart WHERE cart_id = ?";
            try (java.sql.PreparedStatement ps = conn.prepareStatement(selectQuery)) {
                ps.setInt(1, cartId);
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int currentQty = rs.getInt("quantity");
                        int newQty = currentQty;
                        
                        if ("increase".equals(action)) {
                            newQty = currentQty + 1;
                            if (newQty > 50) newQty = 50; // Max limit
                        } else if ("decrease".equals(action)) {
                            newQty = currentQty - 1;
                            if (newQty < 1) newQty = 1; // Minimum limit
                        }
                        
                        // Update quantity
                        String updateQuery = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
                        try (java.sql.PreparedStatement updatePs = conn.prepareStatement(updateQuery)) {
                            updatePs.setInt(1, newQty);
                            updatePs.setInt(2, cartId);
                            int rows = updatePs.executeUpdate();
                            return rows > 0;
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}

