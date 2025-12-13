package com.org.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.org.model.Cake;
import com.org.util.DBConnection;

public class CakeDAO {

    // ===== USER/PUBLIC METHODS =====

    // Get all available cakes with category names
    public List<Cake> getAllCakes() {
        List<Cake> cakes = new ArrayList<>();
        String query = "SELECT c.*, cat.category_name FROM cakes c " +
                       "JOIN categories cat ON c.category_id = cat.category_id " +
                       "WHERE c.is_available = TRUE ORDER BY c.created_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Cake cake = new Cake();
                cake.setCakeId(rs.getInt("cake_id"));
                cake.setCakeName(rs.getString("cake_name"));
                cake.setDescription(rs.getString("description"));
                cake.setPrice(rs.getDouble("price"));
                cake.setCategoryId(rs.getInt("category_id"));
                cake.setCategoryName(rs.getString("category_name"));
                cake.setImagePath(rs.getString("image_path"));
                cake.setStockQuantity(rs.getInt("stock_quantity"));
                cake.setAvailable(rs.getBoolean("is_available"));
                cake.setFeatured(rs.getBoolean("is_featured"));
                cake.setCreatedDate(rs.getTimestamp("created_date"));
                
                cakes.add(cake);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return cakes;
    }

    // Get featured cakes only
    public List<Cake> getFeaturedCakes() {
        List<Cake> cakes = new ArrayList<>();
        String query = "SELECT c.*, cat.category_name FROM cakes c " +
                       "JOIN categories cat ON c.category_id = cat.category_id " +
                       "WHERE c.is_featured = TRUE AND c.is_available = TRUE " +
                       "ORDER BY c.created_date DESC LIMIT 6";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Cake cake = new Cake();
                cake.setCakeId(rs.getInt("cake_id"));
                cake.setCakeName(rs.getString("cake_name"));
                cake.setDescription(rs.getString("description"));
                cake.setPrice(rs.getDouble("price"));
                cake.setCategoryId(rs.getInt("category_id"));
                cake.setCategoryName(rs.getString("category_name"));
                cake.setImagePath(rs.getString("image_path"));
                cake.setStockQuantity(rs.getInt("stock_quantity"));
                cake.setAvailable(rs.getBoolean("is_available"));
                cake.setFeatured(rs.getBoolean("is_featured"));
                
                cakes.add(cake);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return cakes;
    }

    // Get cake by ID
    public Cake getCakeById(int cakeId) {
        Cake cake = null;
        String query = "SELECT c.*, cat.category_name FROM cakes c " +
                       "JOIN categories cat ON c.category_id = cat.category_id " +
                       "WHERE c.cake_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, cakeId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cake = new Cake();
                    cake.setCakeId(rs.getInt("cake_id"));
                    cake.setCakeName(rs.getString("cake_name"));
                    cake.setDescription(rs.getString("description"));
                    cake.setPrice(rs.getDouble("price"));
                    cake.setCategoryId(rs.getInt("category_id"));
                    cake.setCategoryName(rs.getString("category_name"));
                    cake.setImagePath(rs.getString("image_path"));
                    cake.setStockQuantity(rs.getInt("stock_quantity"));
                    cake.setAvailable(rs.getBoolean("is_available"));
                    cake.setFeatured(rs.getBoolean("is_featured"));
                    cake.setCreatedDate(rs.getTimestamp("created_date"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return cake;
    }

    // Get cakes by category
    public List<Cake> getCakesByCategory(int categoryId) {
        List<Cake> cakes = new ArrayList<>();
        String query = "SELECT c.*, cat.category_name FROM cakes c " +
                       "JOIN categories cat ON c.category_id = cat.category_id " +
                       "WHERE c.category_id = ? AND c.is_available = TRUE " +
                       "ORDER BY c.cake_name";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, categoryId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cake cake = new Cake();
                    cake.setCakeId(rs.getInt("cake_id"));
                    cake.setCakeName(rs.getString("cake_name"));
                    cake.setDescription(rs.getString("description"));
                    cake.setPrice(rs.getDouble("price"));
                    cake.setCategoryId(rs.getInt("category_id"));
                    cake.setCategoryName(rs.getString("category_name"));
                    cake.setImagePath(rs.getString("image_path"));
                    cake.setStockQuantity(rs.getInt("stock_quantity"));
                    cake.setAvailable(rs.getBoolean("is_available"));
                    cake.setFeatured(rs.getBoolean("is_featured"));
                    
                    cakes.add(cake);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return cakes;
    }
    
    // ===== ADMIN METHODS =====
    
    // Get total cakes count for admin dashboard
    public int getTotalCakesCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM cakes";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
            
            System.out.println("✅ Total cakes count: " + count);
        } catch (Exception e) {
            System.out.println("❌ Error getting cakes count: " + e.getMessage());
            e.printStackTrace();
        }
        
        return count;
    }

    // Get ALL cakes for admin (including unavailable ones)
    public List<Cake> getAllCakesForAdmin() {
        List<Cake> cakes = new ArrayList<>();
        String query = "SELECT c.*, cat.category_name FROM cakes c " +
                       "JOIN categories cat ON c.category_id = cat.category_id " +
                       "ORDER BY c.created_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Cake cake = new Cake();
                cake.setCakeId(rs.getInt("cake_id"));
                cake.setCakeName(rs.getString("cake_name"));
                cake.setDescription(rs.getString("description"));
                cake.setPrice(rs.getDouble("price"));
                cake.setCategoryId(rs.getInt("category_id"));
                cake.setCategoryName(rs.getString("category_name"));
                cake.setImagePath(rs.getString("image_path"));
                cake.setStockQuantity(rs.getInt("stock_quantity"));
                cake.setAvailable(rs.getBoolean("is_available"));
                cake.setFeatured(rs.getBoolean("is_featured"));
                cake.setCreatedDate(rs.getTimestamp("created_date"));
                
                cakes.add(cake);
            }
            
            System.out.println("✅ Fetched " + cakes.size() + " cakes for admin");
        } catch (Exception e) {
            System.out.println("❌ Error fetching cakes for admin: " + e.getMessage());
            e.printStackTrace();
        }
        
        return cakes;
    }

    // Add new cake
    public boolean addCake(Cake cake) {
        String sql = "INSERT INTO cakes (cake_name, description, price, category_id, " +
                     "image_path, stock_quantity, is_available, is_featured) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, cake.getCakeName());
            ps.setString(2, cake.getDescription());
            ps.setDouble(3, cake.getPrice());
            ps.setInt(4, cake.getCategoryId());
            ps.setString(5, cake.getImagePath());
            ps.setInt(6, cake.getStockQuantity());
            ps.setBoolean(7, cake.isAvailable());
            ps.setBoolean(8, cake.isFeatured());
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                System.out.println("✅ Cake added successfully: " + cake.getCakeName());
                return true;
            }
        } catch (Exception e) {
            System.out.println("❌ Error adding cake: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }

    // Update existing cake
    public boolean updateCake(Cake cake) {
        String sql = "UPDATE cakes SET cake_name=?, description=?, price=?, " +
                     "category_id=?, image_path=?, stock_quantity=?, " +
                     "is_available=?, is_featured=? WHERE cake_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, cake.getCakeName());
            ps.setString(2, cake.getDescription());
            ps.setDouble(3, cake.getPrice());
            ps.setInt(4, cake.getCategoryId());
            ps.setString(5, cake.getImagePath());
            ps.setInt(6, cake.getStockQuantity());
            ps.setBoolean(7, cake.isAvailable());
            ps.setBoolean(8, cake.isFeatured());
            ps.setInt(9, cake.getCakeId());
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                System.out.println("✅ Cake updated successfully: " + cake.getCakeName());
                return true;
            }
        } catch (Exception e) {
            System.out.println("❌ Error updating cake: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }

    // Delete cake
    public boolean deleteCake(int cakeId) {
        String sql = "DELETE FROM cakes WHERE cake_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, cakeId);
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                System.out.println("✅ Cake deleted successfully: ID " + cakeId);
                return true;
            }
        } catch (Exception e) {
            System.out.println("❌ Error deleting cake: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
}

