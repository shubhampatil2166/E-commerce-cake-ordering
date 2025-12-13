package com.org.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.org.model.CartItem;
import com.org.util.DBConnection;

public class CartDAO {
    
    // 1. Add item to cart (or update quantity if exists)
    public boolean addToCart(int userId, int cakeId, int quantity) {
        try (Connection conn = DBConnection.getConnection()) {
            
            // Check if item already exists in cart
            String checkQuery = "SELECT cart_id, quantity FROM cart WHERE user_id = ? AND cake_id = ?";
            try (PreparedStatement checkPs = conn.prepareStatement(checkQuery)) {
                checkPs.setInt(1, userId);
                checkPs.setInt(2, cakeId);
                
                try (ResultSet rs = checkPs.executeQuery()) {
                    if (rs.next()) {
                        // Item exists - UPDATE quantity
                        int cartId = rs.getInt("cart_id");
                        int existingQty = rs.getInt("quantity");
                        int newQty = existingQty + quantity;
                        
                        String updateQuery = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
                        try (PreparedStatement updatePs = conn.prepareStatement(updateQuery)) {
                            updatePs.setInt(1, newQty);
                            updatePs.setInt(2, cartId);
                            int rows = updatePs.executeUpdate();
                            
                            if (rows > 0) {
                                System.out.println("✅ Cart updated: cartId=" + cartId + ", newQty=" + newQty);
                                return true;
                            }
                        }
                    } else {
                        // Item doesn't exist - INSERT new
                        String insertQuery = "INSERT INTO cart (user_id, cake_id, quantity) VALUES (?, ?, ?)";
                        try (PreparedStatement insertPs = conn.prepareStatement(insertQuery)) {
                            insertPs.setInt(1, userId);
                            insertPs.setInt(2, cakeId);
                            insertPs.setInt(3, quantity);
                            int rows = insertPs.executeUpdate();
                            
                            if (rows > 0) {
                                System.out.println("✅ Added to cart: userId=" + userId + ", cakeId=" + cakeId + ", qty=" + quantity);
                                return true;
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("❌ Error in addToCart:");
            e.printStackTrace();
        }
        return false;
    }
    
    // 2. Get all cart items for a user
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        String query = "SELECT c.cart_id, c.user_id, c.cake_id, c.quantity, " +
                       "ck.cake_name, ck.description, ck.price, ck.image_path " +
                       "FROM cart c " +
                       "JOIN cakes ck ON c.cake_id = ck.cake_id " +
                       "WHERE c.user_id = ? " +
                       "ORDER BY c.added_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setCartId(rs.getInt("cart_id"));
                    item.setUserId(rs.getInt("user_id"));
                    item.setCakeId(rs.getInt("cake_id"));
                    item.setCakeName(rs.getString("cake_name"));
                    item.setDescription(rs.getString("description"));
                    item.setPrice(rs.getDouble("price"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setImagePath(rs.getString("image_path"));
                    item.calculateSubtotal();
                    
                    cartItems.add(item);
                }
            }
        } catch (Exception e) {
            System.out.println("❌ Error in getCartItems:");
            e.printStackTrace();
        }
        
        return cartItems;
    }
    
    // 3. Get cart count (total quantity of all items)
    public int getCartCount(int userId) {
        int count = 0;
        String query = "SELECT SUM(quantity) as total FROM cart WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("total");
                }
            }
        } catch (Exception e) {
            System.out.println("❌ Error in getCartCount:");
            e.printStackTrace();
        }
        
        return count;
    }
    
    // 4. Update quantity of a cart item
    public boolean updateQuantity(int cartId, int newQuantity) {
        // Ensure minimum quantity is 1
        if (newQuantity < 1) {
            newQuantity = 1;
        }
        
        String query = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, newQuantity);
            ps.setInt(2, cartId);
            
            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("✅ Cart quantity updated: cartId=" + cartId + ", newQty=" + newQuantity);
                return true;
            }
        } catch (Exception e) {
            System.out.println("❌ Error in updateQuantity:");
            e.printStackTrace();
        }
        
        return false;
    }
    
    // 5. Remove item from cart
    public boolean removeFromCart(int cartId) {
        String query = "DELETE FROM cart WHERE cart_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, cartId);
            
            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("✅ Item removed from cart: cartId=" + cartId);
                return true;
            }
        } catch (Exception e) {
            System.out.println("❌ Error in removeFromCart:");
            e.printStackTrace();
        }
        
        return false;
    }
    
    // 6. Clear entire cart (after order placed)
    public boolean clearCart(int userId) {
        String query = "DELETE FROM cart WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            
            int rows = ps.executeUpdate();
            System.out.println("✅ Cart cleared for userId=" + userId + ", items removed=" + rows);
            return true;
        } catch (Exception e) {
            System.out.println("❌ Error in clearCart:");
            e.printStackTrace();
        }
        
        return false;
    }
    
    // 7. Get total cart amount
    public double getCartTotal(int userId) {
        double total = 0.0;
        String query = "SELECT SUM(c.quantity * ck.price) as total " +
                       "FROM cart c " +
                       "JOIN cakes ck ON c.cake_id = ck.cake_id " +
                       "WHERE c.user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getDouble("total");
                }
            }
        } catch (Exception e) {
            System.out.println("❌ Error in getCartTotal:");
            e.printStackTrace();
        }
        
        return total;
    }
}
