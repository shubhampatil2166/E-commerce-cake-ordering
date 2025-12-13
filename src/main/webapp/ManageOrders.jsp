<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.org.model.Order, com.org.model.OrderItem, com.org.dao.OrderDAO" %>
<%
    // Check admin authentication
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("Login.jsp?error=Admin access required");
        return;
    }
    
    String adminName = (String) session.getAttribute("userName");
    
    // Fetch all orders
    OrderDAO orderDAO = new OrderDAO();
    List<Order> orders = orderDAO.getAllOrders();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Admin</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.4.0/css/all.css">
    
    <style>
        body {
            background-color: #f4f6f9;
        }
        
        .navbar-dark {
            background-color: #2c3e50 !important;
        }
        
        .page-header {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        
        .orders-table {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .status-select {
            padding: 5px 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        
        .badge-pending { background-color: #ffc107; color: #000; }
        .badge-processing { background-color: #17a2b8; }
        .badge-shipped { background-color: #007bff; }
        .badge-delivered { background-color: #28a745; }
        .badge-cancelled { background-color: #dc3545; }
    </style>
</head>
<body>
    
    <!-- Admin Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark shadow">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="AdminDashboard.jsp">
                <i class="fas fa-shield-alt"></i> CaKeZo Admin Panel
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="adminNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="AdminDashboard.jsp">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ManageCakes.jsp">
                            <i class="fas fa-birthday-cake"></i> Manage Cakes
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ManageCategories.jsp">
                            <i class="fas fa-tags"></i> Categories
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="ManageOrders.jsp">
                            <i class="fas fa-box"></i> Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ManageUsers.jsp">
                            <i class="fas fa-users"></i> Users
                        </a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp" target="_blank">
                            <i class="fas fa-external-link-alt"></i> View Site
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" 
                           role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-shield"></i> <%= adminName %>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <a class="dropdown-item text-danger" href="LogoutServlet">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Page Content -->
    <div class="container mt-5">
        
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="mb-2"><i class="fas fa-box"></i> Manage Orders</h1>
            <p class="text-muted mb-0">View and manage all customer orders</p>
        </div>
        
        <!-- Success/Error Messages -->
        <% 
            String msg = request.getParameter("msg");
            if (msg != null) {
        %>
            <div class="alert alert-dismissible fade show <%= "updated".equals(msg) ? "alert-success" : "alert-danger" %>" role="alert">
                <% if ("updated".equals(msg)) { %>
                    <i class="fas fa-check-circle"></i> <strong>Success!</strong> Order status updated successfully.
                <% } else { %>
                    <i class="fas fa-exclamation-circle"></i> <strong>Error!</strong> Operation failed.
                <% } %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <!-- Orders Table -->
        <div class="orders-table">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Phone</th>
                            <th>Total Amount</th>
                            <th>Payment</th>
                            <th>Status</th>
                            <th>Order Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (orders != null && !orders.isEmpty()) {
                            for (Order order : orders) { 
                                String statusBadge = "badge-pending";
                                if ("Processing".equals(order.getOrderStatus())) statusBadge = "badge-processing";
                                else if ("Shipped".equals(order.getOrderStatus())) statusBadge = "badge-shipped";
                                else if ("Delivered".equals(order.getOrderStatus())) statusBadge = "badge-delivered";
                                else if ("Cancelled".equals(order.getOrderStatus())) statusBadge = "badge-cancelled";
                        %>
                                <tr>
                                    <td><strong>#<%= order.getOrderId() %></strong></td>
                                    <td><%= order.getFullName() %></td>
                                    <td><%= order.getPhone() %></td>
                                    <td><strong>₹<%= String.format("%.2f", order.getTotalAmount()) %></strong></td>
                                    <td><span class="badge bg-secondary"><%= order.getPaymentMethod() %></span></td>
                                    <td>
                                        <span class="badge <%= statusBadge %>"><%= order.getOrderStatus() %></span>
                                    </td>
                                    <td><%= order.getOrderDate().toString().substring(0, 16) %></td>
                                    <td>
                                        <form action="UpdateOrderStatusServlet" method="post" style="display: inline;">
                                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                            <select name="status" class="status-select" onchange="this.form.submit()">
                                                <option value="Pending" <%= "Pending".equals(order.getOrderStatus()) ? "selected" : "" %>>Pending</option>
                                                <option value="Processing" <%= "Processing".equals(order.getOrderStatus()) ? "selected" : "" %>>Processing</option>
                                                <option value="Shipped" <%= "Shipped".equals(order.getOrderStatus()) ? "selected" : "" %>>Shipped</option>
                                                <option value="Delivered" <%= "Delivered".equals(order.getOrderStatus()) ? "selected" : "" %>>Delivered</option>
                                                <option value="Cancelled" <%= "Cancelled".equals(order.getOrderStatus()) ? "selected" : "" %>>Cancelled</option>
                                            </select>
                                        </form>
                                    </td>
                                </tr>
                        <%  }
                        } else { %>
                            <tr>
                                <td colspan="8" class="text-center text-muted">
                                    <i class="fas fa-inbox fa-3x mb-3"></i>
                                    <p>No orders found.</p>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            
            <!-- Summary -->
            <div class="mt-3 text-muted">
                <small><i class="fas fa-info-circle"></i> Total Orders: <%= orders != null ? orders.size() : 0 %></small>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
