package com.org.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.org.model.Order;
import com.org.model.OrderItem;
import com.org.util.DBConnection;

public class OrderDAO {
    
    // Create new order
    public int createOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, full_name, email, phone, address, city, pincode, total_amount, order_status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, order.getUserId());
            stmt.setString(2, order.getFullName());
            stmt.setString(3, order.getEmail());
            stmt.setString(4, order.getPhone());
            stmt.setString(5, order.getAddress());
            stmt.setString(6, order.getCity());
            stmt.setString(7, order.getPincode());
            stmt.setDouble(8, order.getTotalAmount());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Add order item
    public boolean addOrderItem(OrderItem item) {
        // UPDATED: Include cake_name in INSERT
        String sql = "INSERT INTO order_items (order_id, cake_id, cake_name, quantity, price, subtotal) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, item.getOrderId());
            stmt.setInt(2, item.getCakeId());
            stmt.setString(3, item.getCakeName());  // ADDED
            stmt.setInt(4, item.getQuantity());
            stmt.setDouble(5, item.getPrice());
            stmt.setDouble(6, item.getSubtotal());
            
            System.out.println("✅ Inserting order item: " + item.getCakeName());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("❌ Error adding order item: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    
    // Get orders by user ID
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setFullName(rs.getString("full_name"));
                order.setEmail(rs.getString("email"));
                order.setPhone(rs.getString("phone"));
                order.setAddress(rs.getString("address"));
                order.setCity(rs.getString("city"));
                order.setPincode(rs.getString("pincode"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return orders;
    }
    
    // UPDATED: Get order items with image path
    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.order_item_id, oi.order_id, oi.cake_id, " +
                     "c.cake_name, oi.quantity, oi.price, oi.subtotal, c.image_path " +
                     "FROM order_items oi " +
                     "JOIN cakes c ON oi.cake_id = c.cake_id " +
                     "WHERE oi.order_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setCakeId(rs.getInt("cake_id"));
                item.setCakeName(rs.getString("cake_name"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                item.setSubtotal(rs.getDouble("subtotal"));
                item.setImagePath(rs.getString("image_path"));  // ADDED
                items.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return items;
    }
    
    // Get all orders (for admin)
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setFullName(rs.getString("full_name"));
                order.setEmail(rs.getString("email"));
                order.setPhone(rs.getString("phone"));
                order.setAddress(rs.getString("address"));
                order.setCity(rs.getString("city"));
                order.setPincode(rs.getString("pincode"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return orders;
    }
    
    // Update order status
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get order by ID
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setFullName(rs.getString("full_name"));
                order.setEmail(rs.getString("email"));
                order.setPhone(rs.getString("phone"));
                order.setAddress(rs.getString("address"));
                order.setCity(rs.getString("city"));
                order.setPincode(rs.getString("pincode"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                return order;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Get order count (for admin dashboard)
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) as count FROM orders";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return 0;
    }
}
