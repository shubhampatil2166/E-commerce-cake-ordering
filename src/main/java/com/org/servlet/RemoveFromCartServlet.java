package com.org.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dao.CartDAO;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("Login.jsp?error=Please login first");
            return;
        }
        
        // Get cart ID to remove
        String cartIdStr = request.getParameter("cartId");
        
        try {
            int cartId = Integer.parseInt(cartIdStr);
            
            // Remove from cart
            CartDAO cartDAO = new CartDAO();
            boolean success = cartDAO.removeFromCart(cartId);
            
            if (success) {
                System.out.println("✅ Item removed from cart: cartId=" + cartId);
                response.sendRedirect("Cart.jsp?msg=removed");
            } else {
                System.out.println("❌ Failed to remove item from cart");
                response.sendRedirect("Cart.jsp?msg=error");
            }
            
        } catch (NumberFormatException e) {
            System.out.println("❌ Invalid cartId in RemoveFromCartServlet");
            e.printStackTrace();
            response.sendRedirect("Cart.jsp?msg=error");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}

