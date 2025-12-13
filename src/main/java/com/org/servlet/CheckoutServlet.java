package com.org.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.org.dao.CartDAO;
import com.org.dao.OrderDAO;
import com.org.model.CartItem;
import com.org.model.Order;
import com.org.model.OrderItem;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("✅ CheckoutServlet called"); // DEBUG
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            System.out.println("❌ User not logged in");
            response.sendRedirect("Login.jsp?error=Please login to checkout");
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        System.out.println("✅ User ID: " + userId); // DEBUG
        
        try {
            // Get form data
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String pincode = request.getParameter("pincode");
            String paymentMethod = request.getParameter("paymentMethod");
            
            System.out.println("✅ Form data received: " + fullName + ", " + email); // DEBUG
            
            // Get cart items
            CartDAO cartDAO = new CartDAO();
            List<CartItem> cartItems = cartDAO.getCartItems(userId);
            
            if (cartItems == null || cartItems.isEmpty()) {
                System.out.println("❌ Cart is empty");
                response.sendRedirect("Cart.jsp?msg=empty");
                return;
            }
            
            System.out.println("✅ Cart items: " + cartItems.size()); // DEBUG
            
            // Calculate total
            double totalAmount = 0;
            for (CartItem item : cartItems) {
                totalAmount += item.getSubtotal();
            }
            
            System.out.println("✅ Total amount: " + totalAmount); // DEBUG
            
            // Create Order object
            Order order = new Order();
            order.setUserId(userId);
            order.setFullName(fullName);
            order.setEmail(email);
            order.setPhone(phone);
            order.setAddress(address);
            order.setCity(city);
            order.setPincode(pincode);
            order.setPaymentMethod(paymentMethod);
            order.setTotalAmount(totalAmount);
            order.setOrderStatus("Pending");
            
            // Save order to database
            OrderDAO orderDAO = new OrderDAO();
            int orderId = orderDAO.createOrder(order);
            
            System.out.println("✅ Order created with ID: " + orderId); // DEBUG
            
            if (orderId > 0) {
                // Save order items
                boolean itemsSaved = true;
                for (CartItem cartItem : cartItems) {
                    OrderItem orderItem = new OrderItem();
                    orderItem.setOrderId(orderId);
                    orderItem.setCakeId(cartItem.getCakeId());
                    orderItem.setCakeName(cartItem.getCakeName());
                    orderItem.setQuantity(cartItem.getQuantity());
                    orderItem.setPrice(cartItem.getPrice());
                    orderItem.setSubtotal(cartItem.getSubtotal());
                    
                    if (!orderDAO.addOrderItem(orderItem)) {
                        itemsSaved = false;
                        System.out.println("❌ Failed to save order item");
                        break;
                    }
                }
                
                if (itemsSaved) {
                    // Clear cart after successful order
                    cartDAO.clearCart(userId);
                    
                    System.out.println("✅ Order placed successfully: Order ID " + orderId);
                    
                    // Redirect to order confirmation
                    response.sendRedirect("OrderConfirmation.jsp?orderId=" + orderId);
                } else {
                    System.out.println("❌ Error saving order items");
                    response.sendRedirect("Checkout.jsp?msg=error");
                }
            } else {
                System.out.println("❌ Error creating order");
                response.sendRedirect("Checkout.jsp?msg=error");
            }
            
        } catch (Exception e) {
            System.out.println("❌ Error in CheckoutServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("Checkout.jsp?msg=error");
        }
    }
}


