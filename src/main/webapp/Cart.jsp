<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.org.model.CartItem, com.org.dao.CartDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart - CaKeZo</title>
    
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
        
        .cart-item {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .cart-item img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 10px;
        }
        
        .item-name {
            font-size: 1.3rem;
            font-weight: bold;
            color: var(--dark-chocolate);
        }
        
        .item-price {
            font-size: 1.1rem;
            color: var(--chocolate);
            font-weight: 600;
        }
        
        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .quantity-btn {
            background-color: var(--chocolate);
            color: white;
            border: none;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            cursor: pointer;
        }
        
        .quantity-btn:hover {
            background-color: var(--dark-chocolate);
        }
        
        .quantity-display {
            font-size: 1.2rem;
            font-weight: bold;
            min-width: 40px;
            text-align: center;
        }
        
        .btn-remove {
            background-color: #dc3545;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
        }
        
        .cart-summary {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 1.1rem;
        }
        
        .summary-total {
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--chocolate);
            border-top: 2px solid var(--cream);
            padding-top: 15px;
            margin-top: 15px;
        }
        
        .btn-checkout {
            background-color: var(--chocolate);
            color: white;
            padding: 15px;
            font-size: 1.2rem;
            border-radius: 10px;
            width: 100%;
            margin-top: 20px;
            border: none;
            transition: all 0.3s;
        }
        
        .btn-checkout:hover {
            background-color: var(--dark-chocolate);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .btn-continue-shopping {
            background: white;
            color: var(--chocolate);
            border: 2px solid var(--chocolate);
            padding: 15px;
            font-size: 1.2rem;
            border-radius: 10px;
            width: 100%;
            margin-top: 15px;
            transition: all 0.3s;
        }
        
        .btn-continue-shopping:hover {
            background: var(--chocolate);
            color: white;
            border-color: var(--chocolate);
        }
        
        .empty-cart {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 20px;
        }
        
        .empty-cart i {
            font-size: 5rem;
            color: #ddd;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    
    <!-- Include Navbar -->
    <%@ include file="navbar.jsp" %>
    
    <%
        // Session check - use variables from navbar.jsp
        if (!isLoggedIn || navUserId == null) {
            response.sendRedirect("Login.jsp?error=Please login to view your cart");
            return;
        }
        
        // Fetch cart items
        CartDAO cartDAO = new CartDAO();
        List<CartItem> cartItems = cartDAO.getCartItems(navUserId);
        double cartTotal = cartDAO.getCartTotal(navUserId);
        int totalItems = cartDAO.getCartCount(navUserId);
    %>
    
    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <h1><i class="fas fa-shopping-cart"></i> My Shopping Cart</h1>
            <p class="lead">Welcome <%= navUserName %>! Review your items below</p>
        </div>
    </section>
    
    <!-- Cart Content -->
    <section class="container mb-5">
        <% if (cartItems != null && !cartItems.isEmpty()) { %>
            <div class="row">
                <!-- Left Column: Cart Items -->
                <div class="col-lg-8">
                    <% for (CartItem item : cartItems) { %>
                        <div class="cart-item">
                            <div class="row align-items-center">
                                <div class="col-md-2 text-center">
                                    <!-- UPDATED: Show Real Images -->
                                    <img src="<%= item.getImagePath() != null && !item.getImagePath().trim().isEmpty() ? item.getImagePath() : "https://via.placeholder.com/120x120/FFB6C1/8B4513?text=Cake" %>" 
                                         alt="<%= item.getCakeName() %>"
                                         onerror="this.src='https://via.placeholder.com/120x120/FFB6C1/8B4513?text=Cake'">
                                </div>
                                <div class="col-md-4">
                                    <div class="item-name"><%= item.getCakeName() %></div>
                                    <div class="item-price">₹<%= String.format("%.2f", item.getPrice()) %> / item</div>
                                </div>
                                <div class="col-md-3">
                                    <div class="quantity-controls">
                                        <form action="UpdateCartServlet" method="post" style="display: inline;">
                                            <input type="hidden" name="cartId" value="<%= item.getCartId() %>">
                                            <input type="hidden" name="action" value="decrease">
                                            <button type="submit" class="quantity-btn">-</button>
                                        </form>
                                        <span class="quantity-display"><%= item.getQuantity() %></span>
                                        <form action="UpdateCartServlet" method="post" style="display: inline;">
                                            <input type="hidden" name="cartId" value="<%= item.getCartId() %>">
                                            <input type="hidden" name="action" value="increase">
                                            <button type="submit" class="quantity-btn">+</button>
                                        </form>
                                    </div>
                                </div>
                                <div class="col-md-3 text-end">
                                    <div class="item-price mb-3">₹<%= String.format("%.2f", item.getSubtotal()) %></div>
                                    <a href="RemoveFromCartServlet?cartId=<%= item.getCartId() %>" 
                                       class="btn btn-remove btn-sm"
                                       onclick="return confirm('Remove this item?')">Remove</a>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
                
                <!-- Right Column: Order Summary -->
                <div class="col-lg-4">
                    <div class="cart-summary">
                        <h3><i class="fas fa-receipt"></i> Order Summary</h3>
                        <hr>
                        <div class="summary-row">
                            <span>Total Items:</span>
                            <span><strong><%= totalItems %></strong></span>
                        </div>
                        <div class="summary-row">
                            <span>Subtotal:</span>
                            <span>₹<%= String.format("%.2f", cartTotal) %></span>
                        </div>
                        <div class="summary-row">
                            <span>Delivery:</span>
                            <span class="text-success"><strong>FREE</strong></span>
                        </div>
                        <div class="summary-row summary-total">
                            <span>Total:</span>
                            <span>₹<%= String.format("%.2f", cartTotal) %></span>
                        </div>
                        
                        <!-- Checkout Button -->
                        <a href="Checkout.jsp" class="btn btn-checkout">
                            <i class="fas fa-shopping-bag"></i> Proceed to Checkout
                        </a>
                        
                        <!-- Continue Shopping Button -->
                        <a href="Cakes.jsp" class="btn btn-continue-shopping">
                            <i class="fas fa-arrow-left"></i> Continue Shopping
                        </a>
                    </div>
                </div>
            </div>
        <% } else { %>
            <!-- Empty Cart -->
            <div class="empty-cart">
                <i class="fas fa-shopping-cart"></i>
                <h3>Your Cart is Empty</h3>
                <p class="text-muted">Start adding some delicious cakes!</p>
                <a href="Cakes.jsp" class="btn btn-warning btn-lg mt-3">
                    <i class="fas fa-birthday-cake"></i> Start Shopping
                </a>
            </div>
        <% } %>
    </section>
    
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
