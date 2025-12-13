package com.org.model;

public class OrderItem {
    private int orderItemId;
    private int orderId;
    private int cakeId;
    private String cakeName;
    private int quantity;
    private double price;
    private double subtotal;
    private String imagePath;  // ADDED
    
    // Default Constructor
    public OrderItem() {}
    
    // Parameterized Constructor
    public OrderItem(int orderItemId, int orderId, int cakeId, String cakeName, 
                     int quantity, double price, double subtotal, String imagePath) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.cakeId = cakeId;
        this.cakeName = cakeName;
        this.quantity = quantity;
        this.price = price;
        this.subtotal = subtotal;
        this.imagePath = imagePath;
    }
    
    // Getters and Setters
    public int getOrderItemId() {
        return orderItemId;
    }
    
    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }
    
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public int getCakeId() {
        return cakeId;
    }
    
    public void setCakeId(int cakeId) {
        this.cakeId = cakeId;
    }
    
    public String getCakeName() {
        return cakeName;
    }
    
    public void setCakeName(String cakeName) {
        this.cakeName = cakeName;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public double getSubtotal() {
        return subtotal;
    }
    
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    
    // ADDED: Image Path
    public String getImagePath() {
        return imagePath;
    }
    
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}
