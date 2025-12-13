package com.org.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.org.model.User;
import com.org.util.DBConnection;

public class UserDAO {

    // ===== USER/PUBLIC METHODS =====

    // Check if email already registered
    public boolean isEmailRegistered(String email) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE email=?")) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Register new user
    public boolean registerUser(User user) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO users(full_name, email, password, role) VALUES(?, ?, ?, ?)")) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // ===== ADMIN METHODS =====
    
    // Get total users count for admin dashboard
    public int getTotalUsersCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM users";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
            
            System.out.println("✅ Total users count: " + count);
        } catch (Exception e) {
            System.out.println("❌ Error getting users count: " + e.getMessage());
            e.printStackTrace();
        }
        
        return count;
    }

    // Get all users for admin
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, full_name, email, role FROM users ORDER BY id DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                
                users.add(user);
            }
            
            System.out.println("✅ Fetched " + users.size() + " users for admin");
        } catch (Exception e) {
            System.out.println("❌ Error fetching users: " + e.getMessage());
            e.printStackTrace();
        }
        
        return users;
    }

    // Delete user by ID
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                System.out.println("✅ User deleted successfully: ID " + userId);
                return true;
            }
        } catch (Exception e) {
            System.out.println("❌ Error deleting user: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
}

