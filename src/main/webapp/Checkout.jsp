<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.org.model.CartItem, com.org.dao.CartDAO" %>
<%
    // Check if user is logged in
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("email");
    
    if (userId == null) {
        response.sendRedirect("Login.jsp?error=Please login to checkout");
        return;
    }
    
    // Fetch cart items
    CartDAO cartDAO = new CartDAO();
    List<CartItem> cartItems = cartDAO.getCartItems(userId);
    
    // Calculate total
    double totalAmount = 0;
    if (cartItems != null && !cartItems.isEmpty()) {
        for (CartItem item : cartItems) {
            totalAmount += item.getSubtotal();
        }
    } else {
        response.sendRedirect("Cart.jsp?msg=empty");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - CaKeZo</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.4.0/css/all.css">
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        
        .checkout-container {
            max-width: 1200px;
            margin: 50px auto;
        }
        
        .checkout-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .order-summary {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }
        
        .order-item {
            border-bottom: 1px solid #ddd;
            padding: 15px 0;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .total-row {
            font-size: 1.3rem;
            font-weight: bold;
            color: #28a745;
        }
    </style>
</head>
<body>
    
    <!-- Include Navbar -->
    <%@ include file="navbar.jsp" %>
    
    <!-- Checkout Container -->
    <div class="container checkout-container">
        <h2 class="mb-4"><i class="fas fa-shopping-bag"></i> Checkout</h2>
        
        <div class="row">
            <!-- Left Column: Checkout Form -->
            <div class="col-lg-7">
                <div class="checkout-card">
                    <h4 class="mb-4"><i class="fas fa-shipping-fast"></i> Delivery Information</h4>
                    
                    <form action="CheckoutServlet" method="post">
                        <!-- Full Name -->
                        <div class="mb-3">
                            <label for="fullName" class="form-label">Full Name *</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" 
                                   value="<%= userName %>" required>
                        </div>
                        
                        <!-- Email -->
                        <div class="mb-3">
                            <label for="email" class="form-label">Email *</label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   value="<%= userEmail %>" required>
                        </div>
                        
                        <!-- Phone -->
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number *</label>
                            <input type="tel" class="form-control" id="phone" name="phone" 
                                   placeholder="e.g., 9876543210" pattern="[0-9]{10}" required>
                        </div>
                        
                        <!-- Address -->
                        <div class="mb-3">
                            <label for="address" class="form-label">Delivery Address *</label>
                            <textarea class="form-control" id="address" name="address" 
                                      rows="3" placeholder="House No., Street, Landmark" required></textarea>
                        </div>
                        
                        <!-- City & Pincode -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="city" class="form-label">City *</label>
                                <input type="text" class="form-control" id="city" name="city" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="pincode" class="form-label">Pincode *</label>
                                <input type="text" class="form-control" id="pincode" name="pincode" 
                                       pattern="[0-9]{6}" placeholder="e.g., 110001" required>
                            </div>
                        </div>
                        
                        <!-- Payment Method -->
                        <div class="mb-4">
                            <label class="form-label">Payment Method *</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" 
                                       id="cod" value="COD" checked>
                                <label class="form-check-label" for="cod">
                                    <i class="fas fa-money-bill-wave"></i> Cash on Delivery (COD)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" 
                                       id="online" value="Online" disabled>
                                <label class="form-check-label text-muted" for="online">
                                    <i class="fas fa-credit-card"></i> Online Payment (Coming Soon)
                                </label>
                            </div>
                        </div>
                        
                        <!-- Submit Button -->
                        <button type="submit" class="btn btn-success btn-lg w-100">
                            <i class="fas fa-check-circle"></i> Place Order
                        </button>
                    </form>
                </div>
            </div>
            
            <!-- Right Column: Order Summary -->
            <div class="col-lg-5">
                <div class="checkout-card">
                    <h4 class="mb-4"><i class="fas fa-receipt"></i> Order Summary</h4>
                    
                    <div class="order-summary">
                        <!-- Order Items -->
                        <% if (cartItems != null && !cartItems.isEmpty()) {
                            for (CartItem item : cartItems) { %>
                                <div class="order-item">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <strong><%= item.getCakeName() %></strong>
                                            <br>
                                            <small class="text-muted">
                                                Qty: <%= item.getQuantity() %> × ₹<%= String.format("%.2f", item.getPrice()) %>
                                            </small>
                                        </div>
                                        <div class="text-end">
                                            <strong>₹<%= String.format("%.2f", item.getSubtotal()) %></strong>
                                        </div>
                                    </div>
                                </div>
                        <%  }
                        } %>
                        
                        <!-- Total -->
                        <div class="order-item total-row">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>Total Amount</div>
                                <div>₹<%= String.format("%.2f", totalAmount) %></div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Additional Info -->
                    <div class="mt-3">
                        <small class="text-muted">
                            <i class="fas fa-info-circle"></i> Your order will be delivered within 2-3 business days.
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
