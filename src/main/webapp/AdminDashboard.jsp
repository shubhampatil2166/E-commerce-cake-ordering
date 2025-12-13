<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.org.dao.CakeDAO, com.org.dao.CategoryDAO, com.org.dao.UserDAO, com.org.dao.OrderDAO" %>
<%
    // Check if admin is logged in
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("../Login.jsp?error=Admin access required");
        return;
    }
    
    String adminName = (String) session.getAttribute("userName");
    
    // Fetch statistics
    CakeDAO cakeDAO = new CakeDAO();
    CategoryDAO categoryDAO = new CategoryDAO();
    UserDAO userDAO = new UserDAO();
    OrderDAO orderDAO = new OrderDAO();
    
    int totalCakes = cakeDAO.getTotalCakesCount();
    int totalCategories = categoryDAO.getTotalCategoriesCount();
    int totalUsers = userDAO.getTotalUsersCount();
    int totalOrders = orderDAO.getTotalOrders();  // FIXED: Changed from getTotalOrdersCount()
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - CaKeZo</title>
    
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
        
        .stat-card {
            border-radius: 15px;
            padding: 30px;
            color: white;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        }
        
        .stat-card i {
            font-size: 3.5rem;
            opacity: 0.9;
            margin-bottom: 15px;
        }
        
        .stat-card h3 {
            font-size: 3rem;
            font-weight: bold;
            margin: 10px 0;
        }
        
        .stat-card p {
            font-size: 1.1rem;
            margin: 0;
            opacity: 0.9;
        }
        
        .bg-primary-gradient { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .bg-success-gradient { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); }
        .bg-warning-gradient { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
        .bg-info-gradient { background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%); }
        
        .quick-actions .btn {
            margin: 10px 5px;
            padding: 15px 30px;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .quick-actions .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .page-header {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
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
                        <a class="nav-link active" href="AdminDashboard.jsp">
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
                        <a class="nav-link" href="ManageOrders.jsp">
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
                        <a class="nav-link" href="../index.jsp" target="_blank">
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
                                <a class="dropdown-item text-danger" href="../LogoutServlet">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Dashboard Content -->
    <div class="container mt-5">
        
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="mb-2"><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h1>
            <p class="text-muted mb-0">Welcome back, <%= adminName %>! Here's your overview.</p>
        </div>
        
        <!-- Statistics Cards -->
        <div class="row g-4 mb-5">
            <!-- Total Cakes -->
            <div class="col-lg-3 col-md-6">
                <div class="stat-card bg-primary-gradient text-center">
                    <i class="fas fa-birthday-cake"></i>
                    <h3><%= totalCakes %></h3>
                    <p>Total Cakes</p>
                </div>
            </div>
            
            <!-- Total Categories -->
            <div class="col-lg-3 col-md-6">
                <div class="stat-card bg-success-gradient text-center">
                    <i class="fas fa-tags"></i>
                    <h3><%= totalCategories %></h3>
                    <p>Categories</p>
                </div>
            </div>
            
            <!-- Total Users -->
            <div class="col-lg-3 col-md-6">
                <div class="stat-card bg-warning-gradient text-center">
                    <i class="fas fa-users"></i>
                    <h3><%= totalUsers %></h3>
                    <p>Registered Users</p>
                </div>
            </div>
            
            <!-- Total Orders -->
            <div class="col-lg-3 col-md-6">
                <div class="stat-card bg-info-gradient text-center">
                    <i class="fas fa-shopping-cart"></i>
                    <h3><%= totalOrders %></h3>
                    <p>Total Orders</p>
                </div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="row">
            <div class="col">
                <div class="card shadow-sm" style="border-radius: 15px;">
                    <div class="card-body text-center quick-actions p-4">
                        <h4 class="mb-4">
                            <i class="fas fa-bolt text-warning"></i> Quick Actions
                        </h4>
                        
                        <a href="AddCake.jsp" class="btn btn-primary btn-lg">
                            <i class="fas fa-plus-circle"></i> Add New Cake
                        </a>
                        
                        <a href="ManageCakes.jsp" class="btn btn-success btn-lg">
                            <i class="fas fa-birthday-cake"></i> View All Cakes
                        </a>
                        
                        <a href="ManageCategories.jsp" class="btn btn-warning btn-lg">
                            <i class="fas fa-tags"></i> Manage Categories
                        </a>
                        
                        <a href="ManageOrders.jsp" class="btn btn-danger btn-lg">
                            <i class="fas fa-box"></i> Manage Orders
                        </a>
                        
                        <a href="ManageUsers.jsp" class="btn btn-info btn-lg">
                            <i class="fas fa-users"></i> View Users
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
