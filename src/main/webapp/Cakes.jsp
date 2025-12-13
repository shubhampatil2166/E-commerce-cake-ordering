<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.org.model.Cake, com.org.model.Category, com.org.dao.CakeDAO, com.org.dao.CategoryDAO" %>
<%
    // Get category filter from URL parameter
    String categoryParam = request.getParameter("category");
    int selectedCategory = 0;
    if (categoryParam != null && !categoryParam.isEmpty()) {
        try {
            selectedCategory = Integer.parseInt(categoryParam);
        } catch (NumberFormatException e) {
            selectedCategory = 0;
        }
    }
    
    // Fetch categories for filter dropdown
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categories = categoryDAO.getAllCategories();
    
    // Fetch cakes based on selected category
    CakeDAO cakeDAO = new CakeDAO();
    List<Cake> cakes = null;
    
    if (selectedCategory > 0) {
        cakes = cakeDAO.getCakesByCategory(selectedCategory);
        System.out.println("✅ Loading cakes for category: " + selectedCategory + " | Count: " + (cakes != null ? cakes.size() : 0));
    } else {
        cakes = cakeDAO.getAllCakes();
        System.out.println("✅ Loading all cakes | Count: " + (cakes != null ? cakes.size() : 0));
    }
    
    // Debug: Print image paths
    if (cakes != null) {
        for (Cake c : cakes) {
            System.out.println("🖼️ " + c.getCakeName() + " | Image: " + c.getImagePath());
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Cakes - CaKeZo</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.4.0/css/all.css">
    
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-pink: #FFB6C1;
            --cream: #FFF8DC;
            --chocolate: #8B4513;
            --dark-chocolate: #5D4037;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--primary-pink) 0%, var(--cream) 100%);
            padding: 60px 0;
            text-align: center;
            color: var(--dark-chocolate);
            margin-bottom: 40px;
        }
        
        .page-header h1 {
            font-size: 3rem;
            font-weight: bold;
        }
        
        /* Filter Section */
        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .filter-section select {
            padding: 10px;
            border-radius: 10px;
            border: 2px solid var(--cream);
            font-size: 1rem;
        }
        
        /* Cake Cards */
        .cake-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            height: 100%;
            background: white;
            margin-bottom: 25px;
        }
        
        .cake-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        }
        
        .cake-card img {
            height: 250px;
            object-fit: cover;
            width: 100%;
            background-color: #f0f0f0;
            transition: transform 0.3s ease;
        }
        
        .cake-card:hover img {
            transform: scale(1.05);
        }
        
        .cake-card .card-body {
            padding: 20px;
        }
        
        .cake-card .card-title {
            font-size: 1.2rem;
            font-weight: bold;
            color: var(--dark-chocolate);
            margin-bottom: 8px;
        }
        
        .cake-card .price {
            font-size: 1.4rem;
            color: var(--chocolate);
            font-weight: bold;
            margin-bottom: 12px;
            display: block;
        }
        
        .category-badge {
            background-color: var(--cream);
            color: var(--chocolate);
            padding: 5px 12px;
            border-radius: 10px;
            font-size: 0.85rem;
            display: inline-block;
            margin-bottom: 10px;
        }
        
        .featured-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background-color: #ffc107;
            color: #000;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.85rem;
            z-index: 10;
        }
        
        .availability-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: bold;
            z-index: 10;
        }
        
        .badge-available {
            background-color: #28a745;
            color: white;
        }
        
        .badge-unavailable {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-add-cart {
            background-color: var(--chocolate);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            transition: all 0.3s;
            width: 100%;
        }
        
        .btn-add-cart:hover {
            background-color: var(--dark-chocolate);
            color: white;
        }
        
        .btn-add-cart:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 20px;
        }
        
        .empty-state i {
            font-size: 5rem;
            color: #ddd;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    
    <!-- Include Navbar -->
    <%@ include file="navbar.jsp" %>
    
    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <h1><i class="fas fa-birthday-cake"></i> Our Delicious Cakes</h1>
            <p class="lead">Explore our wide variety of fresh, handcrafted cakes</p>
        </div>
    </section>
    
    <!-- Main Content -->
    <section class="container">
        
        <!-- Filter Section -->
        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h5 class="mb-0">
                        <i class="fas fa-filter"></i> Filter by Category
                    </h5>
                </div>
                <div class="col-md-6">
                    <form action="Cakes.jsp" method="get">
                        <select name="category" class="form-select" onchange="this.form.submit()">
                            <option value="0" <%= selectedCategory == 0 ? "selected" : "" %>>All Categories</option>
                            <% if (categories != null && !categories.isEmpty()) {
                                for (Category cat : categories) { %>
                                    <option value="<%= cat.getCategoryId() %>" 
                                            <%= selectedCategory == cat.getCategoryId() ? "selected" : "" %>>
                                        <%= cat.getCategoryName() %>
                                    </option>
                            <%  }
                            } %>
                        </select>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Cakes Grid -->
        <div class="row">
            <% if (cakes != null && !cakes.isEmpty()) {
                for (Cake cake : cakes) { 
                    boolean isAvailable = cake.isAvailable();
                    boolean isFeatured = cake.isFeatured();
                    String imagePath = cake.getImagePath();
            %>
                    <div class="col-lg-4 col-md-6">
                        <div class="card cake-card">
                            <div style="position: relative; overflow: hidden;">
                                <!-- Featured Badge -->
                                <% if (isFeatured) { %>
                                    <span class="featured-badge">
                                        <i class="fas fa-star"></i> Featured
                                    </span>
                                <% } %>
                                
                                <!-- Availability Badge -->
                                <span class="availability-badge <%= isAvailable ? "badge-available" : "badge-unavailable" %>">
                                    <i class="fas fa-<%= isAvailable ? "check-circle" : "times-circle" %>"></i>
                                    <%= isAvailable ? "Available" : "Sold Out" %>
                                </span>
                                
                                <!-- Cake Image - FIXED -->
                                <img src="<%= imagePath != null && !imagePath.trim().isEmpty() ? imagePath : "https://via.placeholder.com/400x250/FFB6C1/8B4513?text=" + cake.getCakeName().replace(" ", "+") %>" 
                                     class="card-img-top" 
                                     alt="<%= cake.getCakeName() %>"
                                     onerror="this.src='https://via.placeholder.com/400x250/FFB6C1/8B4513?text=<%= cake.getCakeName().replace(" ", "+") %>';">
                            </div>
                            <div class="card-body">
                                <h5 class="card-title"><%= cake.getCakeName() %></h5>
                                <span class="category-badge">
                                    <i class="fas fa-tag"></i> <%= cake.getCategoryName() %>
                                </span>
                                <p class="card-text text-secondary small">
                                    <%= cake.getDescription() != null && cake.getDescription().length() > 80 
                                        ? cake.getDescription().substring(0, 80) + "..." 
                                        : (cake.getDescription() != null ? cake.getDescription() : "Delicious cake made with premium ingredients.") %>
                                </p>
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="price">₹<%= String.format("%.2f", cake.getPrice()) %></span>
                                    <small class="text-muted">
                                        <i class="fas fa-box"></i> Stock: <%= cake.getStockQuantity() %>
                                    </small>
                                </div>
                                
                                <% if (isLoggedIn) { %>
                                    <form action="AddToCartServlet" method="post">
                                        <input type="hidden" name="cakeId" value="<%= cake.getCakeId() %>">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" 
                                                class="btn btn-add-cart" 
                                                <%= !isAvailable || cake.getStockQuantity() <= 0 ? "disabled" : "" %>>
                                            <i class="fas fa-shopping-cart"></i> 
                                            <%= !isAvailable || cake.getStockQuantity() <= 0 ? "Out of Stock" : "Add to Cart" %>
                                        </button>
                                    </form>
                                <% } else { %>
                                    <a href="Login.jsp" class="btn btn-add-cart">
                                        <i class="fas fa-sign-in-alt"></i> Login to Order
                                    </a>
                                <% } %>
                            </div>
                        </div>
                    </div>
            <%  }
            } else { %>
                <!-- Empty State -->
                <div class="col-12">
                    <div class="empty-state">
                        <i class="fas fa-box-open"></i>
                        <h3>No Cakes Found</h3>
                        <p class="text-muted">
                            <%= selectedCategory > 0 
                                ? "No cakes available in this category at the moment." 
                                : "No cakes available at the moment. Please check back later!" %>
                        </p>
                        <% if (selectedCategory > 0) { %>
                            <a href="Cakes.jsp" class="btn btn-warning btn-lg mt-3">
                                <i class="fas fa-arrow-left"></i> View All Cakes
                            </a>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    </section>
    
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
