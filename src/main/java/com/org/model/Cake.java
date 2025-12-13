package com.org.model;

import java.sql.Timestamp;

public class Cake {
    private int cakeId;
    private String cakeName;
    private String description;
    private double price;
    private int categoryId;
    private String categoryName; // For displaying category name
    private String imagePath;
    private int stockQuantity;
    private boolean isAvailable;
    private boolean isFeatured;
    private Timestamp createdDate;

    // Default constructor
    public Cake() {
    }

    // Constructor with essential fields
    public Cake(int cakeId, String cakeName, String description, double price, 
                int categoryId, String imagePath, int stockQuantity, 
                boolean isAvailable, boolean isFeatured) {
        this.cakeId = cakeId;
        this.cakeName = cakeName;
        this.description = description;
        this.price = price;
        this.categoryId = categoryId;
        this.imagePath = imagePath;
        this.stockQuantity = stockQuantity;
        this.isAvailable = isAvailable;
        this.isFeatured = isFeatured;
    }

    // Getters and Setters
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
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public void setFeatured(boolean featured) {
        isFeatured = featured;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }
}

