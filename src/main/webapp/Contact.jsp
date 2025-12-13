<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - CaKeZo</title>
    
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
        
        /* Contact Form Section */
        .contact-form-section {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }
        
        .contact-form-section h3 {
            color: var(--dark-chocolate);
            font-weight: bold;
            margin-bottom: 30px;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--dark-chocolate);
            margin-bottom: 8px;
        }
        
        .form-control, .form-select {
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 12px 15px;
            transition: all 0.3s;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--chocolate);
            box-shadow: 0 0 0 0.2rem rgba(139, 69, 19, 0.15);
        }
        
        .btn-submit {
            background-color: var(--chocolate);
            color: white;
            padding: 12px 40px;
            font-size: 1.1rem;
            border-radius: 50px;
            border: none;
            transition: all 0.3s;
            margin-top: 20px;
        }
        
        .btn-submit:hover {
            background-color: var(--dark-chocolate);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        /* Contact Info Cards */
        .contact-info-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            height: 100%;
        }
        
        .contact-info-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .contact-info-card i {
            font-size: 3rem;
            color: var(--chocolate);
            margin-bottom: 20px;
        }
        
        .contact-info-card h5 {
            color: var(--dark-chocolate);
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .contact-info-card p {
            color: #666;
            margin: 0;
        }
        
        .contact-info-card a {
            color: var(--chocolate);
            text-decoration: none;
            font-weight: 500;
        }
        
        .contact-info-card a:hover {
            color: var(--dark-chocolate);
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
            <h1><i class="fas fa-envelope"></i> Contact Us</h1>
            <p class="lead">We'd love to hear from you! Get in touch with us</p>
        </div>
    </section>
    
    <!-- Contact Info Cards -->
    <section class="container mb-5">
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="contact-info-card">
                    <i class="fas fa-map-marker-alt"></i>
                    <h5>Visit Us</h5>
                    <p>123 Cake Street, Sweet City<br>Bakery District, BC 12345</p>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6">
                <div class="contact-info-card">
                    <i class="fas fa-phone"></i>
                    <h5>Call Us</h5>
                    <p>
                        <a href="tel:+911234567890">+91 12345 67890</a><br>
                        <small class="text-muted">Mon-Sat: 9AM - 8PM</small>
                    </p>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6">
                <div class="contact-info-card">
                    <i class="fas fa-envelope"></i>
                    <h5>Email Us</h5>
                    <p>
                        <a href="mailto:info@cakezo.com">info@cakezo.com</a><br>
                        <a href="mailto:support@cakezo.com">support@cakezo.com</a>
                    </p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Contact Form -->
    <section class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="contact-form-section">
                    <h3 class="text-center">
                        <i class="fas fa-paper-plane"></i> Send Us a Message
                    </h3>
                    
                    <!-- Success/Error Messages -->
    <% 
        String status = request.getParameter("status");
        if ("success".equals(status)) { 
    %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle"></i> <strong>Thank you!</strong> Your message has been sent successfully. We'll get back to you soon.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% 
        } else if ("error".equals(status)) { 
    %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle"></i> <strong>Oops!</strong> Something went wrong. Please try again later.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% 
        } 
    %>
                    
                    <form action="ContactServlet" method="post">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="name" class="form-label">
                                    <i class="fas fa-user"></i> Your Name *
                                </label>
                                <input type="text" class="form-control" id="name" name="name" 
                                       placeholder="Enter your full name" required>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope"></i> Email Address *
                                </label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       placeholder="your.email@example.com" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="phone" class="form-label">
                                    <i class="fas fa-phone"></i> Phone Number
                                </label>
                                <input type="tel" class="form-control" id="phone" name="phone" 
                                       placeholder="+91 1234567890" pattern="[0-9+\-\s()]*">
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="subject" class="form-label">
                                    <i class="fas fa-tag"></i> Subject *
                                </label>
                                <select class="form-select" id="subject" name="subject" required>
                                    <option value="">Select a subject</option>
                                    <option value="Order Inquiry">Order Inquiry</option>
                                    <option value="Custom Cake Request">Custom Cake Request</option>
                                    <option value="Feedback">Feedback</option>
                                    <option value="Complaint">Complaint</option>
                                    <option value="General Query">General Query</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="message" class="form-label">
                                <i class="fas fa-comment"></i> Your Message *
                            </label>
                            <textarea class="form-control" id="message" name="message" rows="6" 
                                      placeholder="Write your message here..." required></textarea>
                        </div>
                        
                        <div class="text-center">
                            <button type="submit" class="btn btn-submit">
                                <i class="fas fa-paper-plane"></i> Send Message
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Map Section (Placeholder) -->
    <section class="container mb-5">
        <div class="row">
            <div class="col-12">
                <div style="background: linear-gradient(135deg, var(--primary-pink) 0%, var(--cream) 100%); 
                            height: 400px; border-radius: 20px; display: flex; align-items: center; 
                            justify-content: center; color: var(--dark-chocolate);">
                    <div class="text-center">
                        <i class="fas fa-map-marked-alt" style="font-size: 4rem; margin-bottom: 20px;"></i>
                        <h3>Map Location</h3>
                        <p class="lead">123 Cake Street, Sweet City</p>
                        <small>(Google Maps integration can be added here)</small>
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
	