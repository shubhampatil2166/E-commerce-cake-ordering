<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.org.model.Cake, com.org.dao.CakeDAO" %>
<%
    // Fetch featured cakes
    CakeDAO cakeDAO = new CakeDAO();
    List<Cake> featuredCakes = null;
    try {
        featuredCakes = cakeDAO.getFeaturedCakes();
        System.out.println("✅ Featured cakes loaded: " + (featuredCakes != null ? featuredCakes.size() : 0));
        if (featuredCakes != null) {
            for (Cake c : featuredCakes) {
                System.out.println("   - " + c.getCakeName() + " | Path: " + c.getImagePath());
            }
        }
    } catch (Exception e) {
        System.out.println("❌ Error loading featured cakes: " + e.getMessage());
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CaKeZo - Fresh Cakes Delivered to Your Doorstep</title>
    
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
            background-color: #fff;
        }
        
        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, var(--primary-pink) 0%, var(--cream) 100%);
            padding: 100px 0;
            text-align: center;
            color: var(--dark-chocolate);
        }
        
        .hero-section h1 {
            font-size: 4rem;
            font-weight: bold;
            margin-bottom: 20px;
        }
        
        .hero-section p {
            font-size: 1.5rem;
            margin-bottom: 30px;
        }
        
        .hero-section .btn-hero {
            padding: 15px 40px;
            font-size: 1.2rem;
            border-radius: 30px;
            margin: 10px;
            transition: all 0.3s;
        }
        
        .hero-section .btn-hero:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        
        /* Welcome Message */
        .welcome-message {
            background: linear-gradient(135deg, var(--chocolate) 0%, var(--dark-chocolate) 100%);
            color: white;
            padding: 30px 0;
            text-align: center;
            margin-bottom: 0;
        }
        
        .welcome-message h2 {
            font-size: 2.5rem;
            font-weight: bold;
            margin: 0;
        }
        
        .welcome-message p {
            font-size: 1.2rem;
            margin: 10px 0 0 0;
        }
        
        /* Image Slider */
        .slider-section {
            background-color: #f8f9fa;
            padding: 80px 0;
        }
        
        .slider-section h2 {
            text-align: center;
            color: var(--dark-chocolate);
            font-weight: bold;
            font-size: 2.5rem;
            margin-bottom: 50px;
        }
        
        .carousel-item {
            height: 500px;
        }
        
        .carousel-item img {
            height: 500px;
            object-fit: cover;
            border-radius: 20px;
        }
        
        .carousel-caption {
            background: rgba(0, 0, 0, 0.6);
            padding: 30px;
            border-radius: 15px;
            bottom: 50px;
        }
        
        .carousel-caption h3 {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .carousel-caption p {
            font-size: 1.2rem;
            margin-bottom: 20px;
        }
        
        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            background-color: var(--chocolate);
            border-radius: 50%;
            padding: 30px;
        }
        
        /* Section Titles */
        .section-title {
            text-align: center;
            margin: 60px 0 40px 0;
        }
        
        .section-title h2 {
            color: var(--dark-chocolate);
            font-weight: bold;
            font-size: 2.5rem;
        }
        
        .section-title p {
            color: #666;
            font-size: 1.1rem;
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
            padding: 4px 10px;
            border-radius: 10px;
            font-size: 0.75rem;
            display: inline-block;
            margin-bottom: 8px;
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
        
        /* Why Choose Us */
        .why-choose {
            background-color: var(--cream);
            padding: 60px 0;
            margin-top: 60px;
        }
        
        .feature-box {
            text-align: center;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transition: all 0.3s;
            height: 100%;
        }
        
        .feature-box:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .feature-box i {
            font-size: 3.5rem;
            color: var(--chocolate);
            margin-bottom: 20px;
        }
        
        .feature-box h4 {
            color: var(--dark-chocolate);
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .feature-box p {
            color: #666;
        }
        
        /* Footer */
        footer {
            background-color: var(--dark-chocolate);
            color: white;
            padding: 40px 0 20px 0;
            margin-top: 60px;
        }
        
        footer h5 {
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        footer a {
            color: #ddd;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        footer a:hover {
            color: var(--primary-pink);
        }
    </style>
</head>
<body>
    
    <!-- Include Navbar -->
    <%@ include file="navbar.jsp" %>
    
    <!-- Welcome Message for Logged In Users -->
    <% if (isLoggedIn) { %>
        <section class="welcome-message">
            <div class="container">
                <h2><i class="fas fa-hand-sparkles"></i> Welcome back, <%= navUserName %>!</h2>
                <p>We're delighted to see you again. Explore our fresh cakes and sweet treats!</p>
            </div>
        </section>
    <% } %>
    
    <!-- Hero Section (Only for Guest Users) -->
    <% if (!isLoggedIn) { %>
        <section class="hero-section">
            <div class="container">
                <h1><i class="fas fa-birthday-cake"></i> CaKeZo</h1>
                <p>Fresh, Delicious Cakes Delivered to Your Doorstep</p>
                <a href="Cakes.jsp" class="btn btn-warning btn-hero">
                    <i class="fas fa-shopping-basket"></i> Order Now
                </a>
                <a href="About.jsp" class="btn btn-outline-dark btn-hero">
                    <i class="fas fa-info-circle"></i> Learn More
                </a>
            </div>
        </section>
    <% } %>
    
    <!-- Image Slider Section -->
    <section class="slider-section">
        <div class="container">
            <h2><i class="fas fa-images"></i> Our Delicious Collections</h2>
            
            <div id="cakeCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#cakeCarousel" data-bs-slide-to="0" class="active"></button>
                    <button type="button" data-bs-target="#cakeCarousel" data-bs-slide-to="1"></button>
                    <button type="button" data-bs-target="#cakeCarousel" data-bs-slide-to="2"></button>
                    <button type="button" data-bs-target="#cakeCarousel" data-bs-slide-to="3"></button>
                </div>
                
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="images/cakes/birthday-cake.jpeg" 
                             class="d-block w-100" alt="Birthday Cakes"
                             onerror="this.src='https://via.placeholder.com/1200x500/FFB6C1/8B4513?text=Birthday+Cakes'">
                        <div class="carousel-caption">
                            <h3><i class="fas fa-birthday-cake"></i> Birthday Cakes</h3>
                            <p>Make your special day even more memorable with our custom birthday cakes!</p>
                            <a href="Cakes.jsp?category=1" class="btn btn-warning btn-lg">
                                <i class="fas fa-arrow-right"></i> Explore Birthday Cakes
                            </a>
                        </div>
                    </div>
                    
                    <div class="carousel-item">
                        <img src="images/cakes/wedding-cakes.jpeg" 
                             class="d-block w-100" alt="Wedding Cakes"
                             onerror="this.src='https://via.placeholder.com/1200x500/FFF8DC/8B4513?text=Wedding+Cakes'">
                        <div class="carousel-caption">
                            <h3><i class="fas fa-ring"></i> Wedding Cakes</h3>
                            <p>Celebrate your big day with our elegant multi-tier wedding cakes!</p>
                            <a href="Cakes.jsp?category=2" class="btn btn-warning btn-lg">
                                <i class="fas fa-arrow-right"></i> Explore Wedding Cakes
                            </a>
                        </div>
                    </div>
                    
                    <div class="carousel-item">
                        <img src="images/cakes/cookies-&-pastries.jpeg" 
                             class="d-block w-100" alt="Cookies & Pastries"
                             onerror="this.src='https://via.placeholder.com/1200x500/DEB887/8B4513?text=Cookies+and+Pastries'">
                        <div class="carousel-caption">
                            <h3><i class="fas fa-cookie"></i> Cookies & Pastries</h3>
                            <p>Indulge in our freshly baked cookies and pastries!</p>
                            <a href="Cakes.jsp?category=3" class="btn btn-warning btn-lg">
                                <i class="fas fa-arrow-right"></i> Explore Cookies & Pastries
                            </a>
                        </div>
                    </div>
                    
                    <div class="carousel-item">
                        <img src="images/cakes/custom-cakes.jpeg" 
                             class="d-block w-100" alt="Custom Cakes"
                             onerror="this.src='https://via.placeholder.com/1200x500/F5DEB3/8B4513?text=Custom+Cakes'">
                        <div class="carousel-caption">
                            <h3><i class="fas fa-palette"></i> Custom Cakes</h3>
                            <p>Have a unique vision? We create custom cakes tailored to your exact specifications!</p>
                            <a href="Contact.jsp" class="btn btn-warning btn-lg">
                                <i class="fas fa-envelope"></i> Contact Us for Custom Orders
                            </a>
                        </div>
                    </div>
                </div>
                
                <button class="carousel-control-prev" type="button" data-bs-target="#cakeCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#cakeCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </button>
            </div>
        </div>
    </section>
    
    <!-- Featured Cakes Section -->
    <section class="container">
        <div class="section-title">
            <h2><i class="fas fa-star text-warning"></i> Featured Cakes</h2>
            <p>Handpicked selections that our customers love the most</p>
        </div>
        
        <div class="row g-4">
            <% 
            if (featuredCakes != null && !featuredCakes.isEmpty()) {
                int count = 0;
                for (Cake cake : featuredCakes) { 
                    if (count >= 6) break;
                    
                    String imagePath = cake.getImagePath();
                    System.out.println("🖼️ Rendering: " + cake.getCakeName() + " | Image: " + imagePath);
            %>
                    <div class="col-lg-4 col-md-6">
                        <div class="card cake-card">
                            <div style="position: relative; overflow: hidden;">
                                <span class="featured-badge">
                                    <i class="fas fa-star"></i> Featured
                                </span>
                                <img src="<%= imagePath != null && !imagePath.trim().isEmpty() ? imagePath : "https://via.placeholder.com/400x250/FFB6C1/8B4513?text=" + cake.getCakeName().replace(" ", "+") %>" 
                                     class="card-img-top" 
                                     alt="<%= cake.getCakeName() %>"
                                     onerror="this.src='https://via.placeholder.com/400x250/FFB6C1/8B4513?text=<%= cake.getCakeName().replace(" ", "+") %>'; console.log('Image failed: <%= imagePath %>');">
                            </div>
                            <div class="card-body">
                                <h5 class="card-title"><%= cake.getCakeName() %></h5>
                                <span class="category-badge">
                                    <i class="fas fa-tag"></i> <%= cake.getCategoryName() %>
                                </span>
                                <p class="card-text text-secondary small">
                                    <%= cake.getDescription() != null && cake.getDescription().length() > 60 
                                        ? cake.getDescription().substring(0, 60) + "..." 
                                        : (cake.getDescription() != null ? cake.getDescription() : "") %>
                                </p>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <span class="price">₹<%= String.format("%.2f", cake.getPrice()) %></span>
                                </div>
                                
                                <form action="AddToCartServlet" method="post" class="mt-2">
                                    <input type="hidden" name="cakeId" value="<%= cake.getCakeId() %>">
                                    <input type="hidden" name="quantity" value="1">
                                    <button type="submit" class="btn btn-add-cart">
                                        <i class="fas fa-shopping-cart"></i> Add to Cart
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
            <%      
                    count++;
                }
            } else { 
            %>
                <div class="col-12 text-center">
                    <p class="text-muted">No featured cakes available at the moment.</p>
                </div>
            <% } %>
        </div>
        
        <div class="text-center mt-5">
            <a href="Cakes.jsp" class="btn btn-lg btn-warning" style="padding: 15px 50px; border-radius: 30px;">
                <i class="fas fa-arrow-right"></i> View All Cakes
            </a>
        </div>
    </section>
    
    <!-- Why Choose Us Section -->
    <section class="why-choose">
        <div class="container">
            <div class="section-title">
                <h2><i class="fas fa-heart text-danger"></i> Why Choose CaKeZo?</h2>
                <p>What makes us the best choice for your celebrations</p>
            </div>
            
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="feature-box">
                        <i class="fas fa-check-circle"></i>
                        <h4>Fresh Ingredients</h4>
                        <p>100% fresh, premium quality ingredients used daily</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="feature-box">
                        <i class="fas fa-truck"></i>
                        <h4>Fast Delivery</h4>
                        <p>Same-day delivery available in select areas</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="feature-box">
                        <i class="fas fa-palette"></i>
                        <h4>Custom Designs</h4>
                        <p>Personalized cakes tailored to your vision</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="feature-box">
                        <i class="fas fa-smile"></i>
                        <h4>100% Satisfaction</h4>
                        <p>5000+ happy customers and counting</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-3">
                    <h5><i class="fas fa-birthday-cake"></i> CaKeZo</h5>
                    <p class="text-light">Your trusted partner for fresh, delicious cakes delivered with love.</p>
                </div>
                <div class="col-md-4 mb-3">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                        <li class="mb-2"><a href="Cakes.jsp"><i class="fas fa-cookie-bite"></i> Cakes</a></li>
                        <li class="mb-2"><a href="About.jsp"><i class="fas fa-info-circle"></i> About Us</a></li>
                        <li class="mb-2"><a href="Contact.jsp"><i class="fas fa-envelope"></i> Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-4 mb-3">
                    <h5>Contact Info</h5>
                    <p class="text-light">
                        <i class="fas fa-envelope"></i> info@cakezo.com<br>
                        <i class="fas fa-phone"></i> +91 12345 67890<br>
                        <i class="fas fa-map-marker-alt"></i> Cake Street, Sweet City
                    </p>
                </div>
            </div>
            <hr class="bg-light my-3">
            <p class="text-center mb-0">&copy; 2025 CaKeZo. All Rights Reserved.</p>
        </div>
    </footer>
    
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
