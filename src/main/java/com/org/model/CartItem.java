package com.org.model;

public class CartItem {
    private int cartId;
    private int userId;
    private int cakeId;
    private String cakeName;
    private String description;
    private double price;
    private int quantity;
    private String imagePath;
    private double subtotal;
    
    // Default constructor
    public CartItem() {}
    
    // Constructor with all fields
    public CartItem(int cartId, int userId, int cakeId, String cakeName, 
                    double price, int quantity, String imagePath) {
        this.cartId = cartId;
        this.userId = userId;
        this.cakeId = cakeId;
        this.cakeName = cakeName;
        this.price = price;
        this.quantity = quantity;
        this.imagePath = imagePath;
        this.subtotal = price * quantity;
    }
    
    // Getters and Setters
    public int getCartId() {
        return cartId;
    }
    
    public void setCartId(int cartId) {
        this.cartId = cartId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
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
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
        // Recalculate subtotal when price changes
        this.subtotal = this.price * this.quantity;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
        // Recalculate subtotal when quantity changes
        this.subtotal = this.price * this.quantity;
    }
    
    public String getImagePath() {
        return imagePath;
    }
    
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    
    public double getSubtotal() {
        return subtotal;
    }
    
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    
    // Calculated method
    public void calculateSubtotal() {
        this.subtotal = this.price * this.quantity;
    }
}

