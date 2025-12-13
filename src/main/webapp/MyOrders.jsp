<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.org.model.Order, com.org.model.OrderItem, com.org.dao.OrderDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - CaKeZo</title>
    
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
        
        .order-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        }
        
        .order-header {
            border-bottom: 2px solid var(--cream);
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        
        .order-id {
            font-size: 1.3rem;
            font-weight: bold;
            color: var(--dark-chocolate);
        }
        
        .order-date {
            color: #666;
            font-size: 0.95rem;
        }
        
        .status-badge {
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            display: inline-block;
        }
        
        .status-pending {
            background-color: rgba(255, 193, 7, 0.2);
            color: #856404;
            border: 1px solid rgba(255, 193, 7, 0.5);
        }
        
        .status-processing {
            background-color: rgba(23, 162, 184, 0.2);
            color: #0c5460;
            border: 1px solid rgba(23, 162, 184, 0.5);
        }
        
        .status-shipped {
            background-color: rgba(111, 66, 193, 0.2);
            color: #4a148c;
            border: 1px solid rgba(111, 66, 193, 0.5);
        }
        
        .status-delivered {
            background-color: rgba(40, 167, 69, 0.2);
            color: #155724;
            border: 1px solid rgba(40, 167, 69, 0.5);
        }
        
        .status-cancelled {
            background-color: rgba(220, 53, 69, 0.2);
            color: #721c24;
            border: 1px solid rgba(220, 53, 69, 0.5);
        }
        
        .order-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .item-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
            margin-right: 20px;
        }
        
        .item-details {
            flex: 1;
        }
        
        .item-name {
            font-weight: 600;
            color: var(--dark-chocolate);
            font-size: 1.1rem;
            margin-bottom: 5px;
        }
        
        .item-quantity {
            color: #666;
            font-size: 0.9rem;
        }
        
        .item-price {
            font-size: 1.2rem;
            color: var(--chocolate);
            font-weight: 600;
        }
        
        .order-total {
            text-align: right;
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--chocolate);
            padding-top: 15px;
            border-top: 2px solid var(--cream);
            margin-top: 15px;
        }
        
        .delivery-address {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-top: 15px;
        }
        
        .empty-orders {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 20px;
        }
        
        .empty-orders i {
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
            response.sendRedirect("Login.jsp?error=Please login to view your orders");
            return;
        }
        
        // Fetch user's orders
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.getOrdersByUserId(navUserId);
    %>
    
    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <h1><i class="fas fa-box"></i> My Orders</h1>
            <p class="lead">Track and view your order history</p>
        </div>
    </section>
    
    <!-- Orders Content -->
    <section class="container mb-5">
        <% if (orders != null && !orders.isEmpty()) { %>
            <% for (Order order : orders) { 
                List<OrderItem> items = orderDAO.getOrderItems(order.getOrderId());
                String statusClass = "status-" + order.getOrderStatus().toLowerCase();
            %>
                <div class="order-card">
                    <!-- Order Header -->
                    <div class="order-header">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <div class="order-id">
                                    <i class="fas fa-receipt"></i> Order #<%= order.getOrderId() %>
                                </div>
                                <div class="order-date">
                                    <i class="far fa-calendar-alt"></i> Placed on: <%= order.getOrderDate() %>
                                </div>
                            </div>
                            <div class="col-md-6 text-end">
                                <span class="status-badge <%= statusClass %>">
                                    <i class="fas fa-info-circle"></i> <%= order.getOrderStatus() %>
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Order Items -->
                    <div class="order-items">
                        <% if (items != null && !items.isEmpty()) {
                            for (OrderItem item : items) { %>
                                <div class="order-item">
                                    <!-- UPDATED: Show Real Images -->
                                    <img src="<%= item.getImagePath() != null && !item.getImagePath().trim().isEmpty() ? item.getImagePath() : "https://via.placeholder.com/80x80/FFB6C1/8B4513?text=Cake" %>" 
                                         alt="<%= item.getCakeName() %>"
                                         class="item-image"
                                         onerror="this.src='https://via.placeholder.com/80x80/FFB6C1/8B4513?text=Cake'">
                                    <div class="item-details">
                                        <div class="item-name"><%= item.getCakeName() %></div>
                                        <div class="item-quantity">
                                            Quantity: <%= item.getQuantity() %> × ₹<%= String.format("%.2f", item.getPrice()) %>
                                        </div>
                                    </div>
                                    <div class="item-price">
                                        ₹<%= String.format("%.2f", item.getSubtotal()) %>
                                    </div>
                                </div>
                        <%  }
                        } %>
                    </div>
                    
                    <!-- Order Total -->
                    <div class="order-total">
                        Total Amount: ₹<%= String.format("%.2f", order.getTotalAmount()) %>
                    </div>
                    
                    <!-- Delivery Address -->
                    <div class="delivery-address">
                        <h6><i class="fas fa-map-marker-alt"></i> Delivery Address:</h6>
                        <p class="mb-0">
                            <strong><%= order.getFullName() %></strong><br>
                            <%= order.getAddress() %>, <%= order.getCity() %>, <%= order.getPincode() %><br>
                            Phone: <%= order.getPhone() %>
                        </p>
                    </div>
                </div>
            <% } %>
        <% } else { %>
            <!-- Empty State -->
            <div class="empty-orders">
                <i class="fas fa-box-open"></i>
                <h3>No Orders Yet</h3>
                <p class="text-muted">You haven't placed any orders yet. Start shopping now!</p>
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