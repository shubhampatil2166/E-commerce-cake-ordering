package com.org.model;

import java.sql.Timestamp;

public class ContactInquiry {
    private int inquiryId;
    private String name;
    private String email;
    private String phone;
    private String subject;
    private String message;
    private Timestamp inquiryDate;
    private String status;
    
    // Default constructor
    public ContactInquiry() {
    }
    
    // Constructor with fields
    public ContactInquiry(String name, String email, String phone, String subject, String message) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.subject = subject;
        this.message = message;
    }
    
    // Getters and Setters
    public int getInquiryId() {
        return inquiryId;
    }
    
    public void setInquiryId(int inquiryId) {
        this.inquiryId = inquiryId;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getSubject() {
        return subject;
    }
    
    public void setSubject(String subject) {
        this.subject = subject;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    public Timestamp getInquiryDate() {
        return inquiryDate;
    }
    
    public void setInquiryDate(Timestamp inquiryDate) {
        this.inquiryDate = inquiryDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
}
