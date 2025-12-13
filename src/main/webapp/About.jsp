<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - CaKeZo</title>
    
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
        }
        
        /* Page Header */
        .page-header {
            background: linear-gradient(135deg, var(--primary-pink) 0%, var(--cream) 100%);
            padding: 80px 0;
            text-align: center;
            color: var(--dark-chocolate);
            margin-bottom: 50px;
        }
        
        .page-header h1 {
            font-size: 3.5rem;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        /* Content Sections */
        .content-section {
            margin-bottom: 50px;
        }
        
        .content-section h2 {
            color: var(--dark-chocolate);
            font-weight: bold;
            margin-bottom: 20px;
            font-size: 2rem;
        }
        
        .content-section p {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #555;
        }
        
        /* Feature Cards */
        .feature-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            height: 100%;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .feature-card i {
            font-size: 3.5rem;
            color: var(--chocolate);
            margin-bottom: 20px;
        }
        
        .feature-card h4 {
            color: var(--dark-chocolate);
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .feature-card p {
            color: #666;
            font-size: 1rem;
        }
        
        /* Stats Section */
        .stats-section {
            background: linear-gradient(135deg, var(--chocolate) 0%, var(--dark-chocolate) 100%);
            color: white;
            padding: 60px 0;
            margin: 60px 0;
        }
        
        .stat-box {
            text-align: center;
            padding: 20px;
        }
        
        .stat-box i {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        
        .stat-box h3 {
            font-size: 3rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .stat-box p {
            font-size: 1.2rem;
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


    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <h1><i class="fas fa-info-circle"></i> About CaKeZo</h1>
            <p class="lead">Crafting Sweet Memories Since 2020</p>
        </div>
    </section>
    
    <!-- Our Story Section -->
    <section class="container content-section">
        <div class="row align-items-center">
            <div class="col-lg-6 mb-4">
                <h2><i class="fas fa-book-open"></i> Our Story</h2>
                <p>
                    CaKeZo was born from a simple passion: creating delicious, handcrafted cakes that bring joy to every celebration. 
                    What started as a small home bakery has grown into a trusted name for quality cakes delivered fresh to your doorstep.
                </p>
                <p>
                    We believe every occasion deserves a cake that's as special as the moment itself. Our expert bakers use only 
                    the finest ingredients, traditional techniques, and a whole lot of love to create cakes that not only look 
                    beautiful but taste absolutely divine.
                </p>
                <p>
                    From birthdays to weddings, anniversaries to simple everyday celebrations, CaKeZo is here to make your 
                    moments sweeter and more memorable.
                </p>
            </div>
            <div class="col-lg-6 mb-4">
                <img src="https://via.placeholder.com/600x400/FFB6C1/8B4513?text=Our+Bakery" 
                     class="img-fluid rounded shadow" alt="Our Bakery">
            </div>
        </div>
    </section>
    
    <!-- Why Choose Us Section -->
    <section class="container content-section">
        <div class="text-center mb-5">
            <h2><i class="fas fa-star text-warning"></i> Why Choose CaKeZo?</h2>
            <p class="lead text-muted">What makes us the best choice for your celebrations</p>
        </div>
        
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <i class="fas fa-check-circle"></i>
                    <h4>100% Fresh Ingredients</h4>
                    <p>We use only premium, fresh ingredients sourced daily to ensure the highest quality in every bite.</p>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <i class="fas fa-hand-sparkles"></i>
                    <h4>Handcrafted with Love</h4>
                    <p>Every cake is handmade by our expert bakers who pour their passion into creating edible masterpieces.</p>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <i class="fas fa-truck"></i>
                    <h4>Timely Delivery</h4>
                    <p>We guarantee on-time delivery so your cake arrives fresh and ready for your special celebration.</p>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <i class="fas fa-palette"></i>
                    <h4>Custom Designs</h4>
                    <p>Need something unique? Our team can create custom cakes tailored to your specific vision and theme.</p>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <i class="fas fa-shield-alt"></i>
                    <h4>Hygiene Standards</h4>
                    <p>We maintain the strictest hygiene protocols in our kitchen to ensure safe and clean food preparation.</p>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6">
                <div class="feature-card">
                    <i class="fas fa-heart"></i>
                    <h4>Customer Satisfaction</h4>
                    <p>Your happiness is our priority. We go the extra mile to ensure every customer leaves with a smile.</p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <div class="stat-box">
                        <i class="fas fa-birthday-cake"></i>
                        <h3>5000+</h3>
                        <p>Cakes Delivered</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="stat-box">
                        <i class="fas fa-smile"></i>
                        <h3>4500+</h3>
                        <p>Happy Customers</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="stat-box">
                        <i class="fas fa-award"></i>
                        <h3>50+</h3>
                        <p>Cake Varieties</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="stat-box">
                        <i class="fas fa-clock"></i>
                        <h3>5 Years</h3>
                        <p>Experience</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Our Mission Section -->
    <section class="container content-section">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h2><i class="fas fa-bullseye"></i> Our Mission</h2>
                <p class="lead" style="max-width: 800px; margin: 0 auto;">
                    To deliver happiness, one cake at a time. We're committed to making every celebration more special 
                    by providing exceptional quality cakes that create lasting memories. Our goal is to be your trusted 
                    partner for all of life's sweet moments.
                </p>
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
                        <li class="mb-2"><a href="index.jsp" class="text-decoration-none"><i class="fas fa-home"></i> Home</a></li>
                        <li class="mb-2"><a href="Cakes.jsp" class="text-decoration-none"><i class="fas fa-cookie-bite"></i> Cakes</a></li>
                        <li class="mb-2"><a href="About.jsp" class="text-decoration-none"><i class="fas fa-info-circle"></i> About Us</a></li>
                        <li class="mb-2"><a href="Contact.jsp" class="text-decoration-none"><i class="fas fa-envelope"></i> Contact</a></li>
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
