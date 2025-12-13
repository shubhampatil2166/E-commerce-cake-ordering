package com.org.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.org.model.ContactInquiry;
import com.org.util.DBConnection;

public class ContactDAO {
    
    public boolean saveInquiry(ContactInquiry inquiry) {
        boolean success = false;
        String query = "INSERT INTO contact_inquiries (name, email, phone, subject, message) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, inquiry.getName());
            ps.setString(2, inquiry.getEmail());
            ps.setString(3, inquiry.getPhone());
            ps.setString(4, inquiry.getSubject());
            ps.setString(5, inquiry.getMessage());
            
            int rows = ps.executeUpdate();
            if (rows > 0) {
                success = true;
                System.out.println("✅ Contact inquiry saved successfully!");
            }
        } catch (Exception e) {
            System.out.println("❌ Error saving contact inquiry:");
            e.printStackTrace();
        }
        
        return success;
    }
}

