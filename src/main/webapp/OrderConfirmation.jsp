<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    // Check if user is logged in
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    
    // Get order ID from URL
    String orderIdParam = request.getParameter("orderId");
    if (orderIdParam == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Confirmed - CaKeZo</title>

 <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.4.0/css/all.css">
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        
        .confirmation-container {
            max-width: 700px;
            margin: 100px auto;
            text-align: center;
        }
        
        .success-icon {
            font-size: 5rem;
            color: #28a745;
            margin-bottom: 30px;
            animation: checkmark 0.5s ease-in-out;
        }
        
        @keyframes checkmark {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }
        
        .confirmation-card {
            background: white;
            border-radius: 15px;
            padding: 50px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        
        .order-id {
            font-size: 1.5rem;
            color: #6c757d;
            margin: 20px 0;
        }
        
        .btn-custom {
            margin: 10px;
            padding: 12px 30px;
            border-radius: 25px;
        }
    </style>
</head>
<body>

 <!-- Include Navbar -->
    <%@ include file="navbar.jsp" %>
    
    <!-- Confirmation Container -->
    <div class="container confirmation-container">
        <div class="confirmation-card">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            
            <h1 class="mb-3">Order Placed Successfully!</h1>
            <p class="lead mb-4">Thank you for your order. Your cakes will be delivered soon!</p>
            
            <div class="order-id">
                <strong>Order ID:</strong> <%= orderIdParam %>
            </div>
            
            <hr class="my-4">
            
            <p class="text-muted mb-4">
                <i class="fas fa-info-circle"></i> 
                You will receive an email confirmation shortly. You can track your order in "My Orders" section.
            </p>
            
            <div class="mt-4">
                <a href="MyOrders.jsp" class="btn btn-primary btn-lg btn-custom">
                    <i class="fas fa-list"></i> View My Orders
                </a>
                <a href="index.jsp" class="btn btn-success btn-lg btn-custom">
                    <i class="fas fa-home"></i> Continue Shopping
                </a>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>