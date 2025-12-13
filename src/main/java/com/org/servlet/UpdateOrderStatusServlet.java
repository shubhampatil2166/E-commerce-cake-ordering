package com.org.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dao.OrderDAO;

@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {
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
            // Get parameters
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            
            // Update order status
            OrderDAO orderDAO = new OrderDAO();
            boolean success = orderDAO.updateOrderStatus(orderId, status);
            
            if (success) {
                System.out.println("✅ Order status updated: " + orderId + " -> " + status);
                response.sendRedirect("ManageOrders.jsp?msg=updated");
            } else {
                System.out.println("❌ Failed to update order status");
                response.sendRedirect("ManageOrders.jsp?msg=error");
            }
            
        } catch (Exception e) {
            System.out.println("❌ Error in UpdateOrderStatusServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("ManageOrders.jsp?msg=error");
        }
    }
}
