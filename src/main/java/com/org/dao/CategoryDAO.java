package com.org.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.org.model.Category;
import com.org.util.DBConnection;

public class CategoryDAO {

    // ===== PUBLIC/USER METHODS =====

    // Get all categories
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT * FROM categories ORDER BY category_name";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setCreatedDate(rs.getTimestamp("created_date"));
                
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return categories;
    }

    // Get category by ID
    public Category getCategoryById(int categoryId) {
        Category category = null;
        String query = "SELECT * FROM categories WHERE category_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, categoryId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    category = new Category();
                    category.setCategoryId(rs.getInt("category_id"));
                    category.setCategoryName(rs.getString("category_name"));
                    category.setDescription(rs.getString("description"));
                    category.setCreatedDate(rs.getTimestamp("created_date"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return category;
    }
    
    // ===== ADMIN METHODS =====
    
    // Get total categories count for admin dashboard
    public int getTotalCategoriesCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM categories";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
            
            System.out.println("✅ Total categories count: " + count);
        } catch (Exception e) {
            System.out.println("❌ Error getting categories count: " + e.getMessage());
            e.printStackTrace();
        }
        
        return count;
    }

    // Add new category
    public boolean addCategory(Category category) {
        String sql = "INSERT INTO categories (category_name, description) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getDescription());
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                System.out.println("✅ Category added successfully: " + category.getCategoryName());
                return true;
            }
        } catch (Exception e) {
            System.out.println("❌ Error adding category: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }

    // Update existing category
    public boolean updateCategory(Category category) {
        String sql = "UPDATE categories SET category_name=?, description=? WHERE category_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getCategoryId());
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                System.out.println("✅ Category updated successfully: " + category.getCategoryName());
                return true;
            }
        } catch (Exception e) {
            System.out.println("❌ Error updating category: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }

    // Delete category
    public boolean deleteCategory(int categoryId) {
        String sql = "DELETE FROM categories WHERE category_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryId);
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                System.out.println("✅ Category deleted successfully: ID " + categoryId);
                return true;
            }
        } catch (Exception e) {
            System.out.println("❌ Error deleting category: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }

    // Get count of cakes in a category (to prevent deletion of categories with cakes)
    public int getCakesCountByCategory(int categoryId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM cakes WHERE category_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, categoryId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            System.out.println("❌ Error getting cakes count for category: " + e.getMessage());
            e.printStackTrace();
        }
        
        return count;
    }
}
