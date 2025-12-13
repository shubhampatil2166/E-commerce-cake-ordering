<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.org.model.Cake, com.org.dao.CakeDAO" %>
<%
    // Check admin authentication
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("Login.jsp?error=Admin access required");
        return;
    }
    
    String adminName = (String) session.getAttribute("userName");
    
    // Fetch all cakes (including unavailable)
    CakeDAO cakeDAO = new CakeDAO();
    List<Cake> cakes = cakeDAO.getAllCakesForAdmin();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Cakes - Admin</title>
    
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
        
        .cake-table {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .badge-available {
            background-color: #28a745;
        }
        
        .badge-unavailable {
            background-color: #dc3545;
        }
        
        .badge-featured {
            background-color: #ffc107;
            color: #000;
        }
        
        .btn-sm {
            margin: 2px;
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
                        <a class="nav-link" href="AdminDashboard.jsp">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="ManageCakes.jsp">
                            <i class="fas fa-birthday-cake"></i> Manage Cakes
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ManageCategories.jsp">
                            <i class="fas fa-tags"></i> Categories
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " href="ManageOrders.jsp">
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
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="mb-2"><i class="fas fa-birthday-cake"></i> Manage Cakes</h1>
                    <p class="text-muted mb-0">View, edit, and manage all cakes</p>
                </div>
                <div>
                    <a href="AddCake.jsp" class="btn btn-primary btn-lg">
                        <i class="fas fa-plus-circle"></i> Add New Cake
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Success/Error Messages -->
        <% 
            String msg = request.getParameter("msg");
            if (msg != null) {
        %>
            <div class="alert alert-dismissible fade show <%= "success".equals(msg) ? "alert-success" : "alert-danger" %>" role="alert">
                <% if ("success".equals(msg)) { %>
                    <i class="fas fa-check-circle"></i> <strong>Success!</strong> Operation completed successfully.
                <% } else if ("added".equals(msg)) { %>
                    <i class="fas fa-check-circle"></i> <strong>Success!</strong> Cake added successfully.
                <% } else if ("updated".equals(msg)) { %>
                    <i class="fas fa-check-circle"></i> <strong>Success!</strong> Cake updated successfully.
                <% } else if ("deleted".equals(msg)) { %>
                    <i class="fas fa-check-circle"></i> <strong>Success!</strong> Cake deleted successfully.
                <% } else { %>
                    <i class="fas fa-exclamation-circle"></i> <strong>Error!</strong> Operation failed.
                <% } %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <!-- Cakes Table -->
        <div class="cake-table">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Cake Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Status</th>
                            <th>Featured</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (cakes != null && !cakes.isEmpty()) {
                            for (Cake cake : cakes) { %>
                                <tr>
                                    <td><%= cake.getCakeId() %></td>
                                    <td><strong><%= cake.getCakeName() %></strong></td>
                                    <td><span class="badge bg-secondary"><%= cake.getCategoryName() %></span></td>
                                    <td>₹<%= String.format("%.2f", cake.getPrice()) %></td>
                                    <td><%= cake.getStockQuantity() %></td>
                                    <td>
                                        <% if (cake.isAvailable()) { %>
                                            <span class="badge badge-available">Available</span>
                                        <% } else { %>
                                            <span class="badge badge-unavailable">Unavailable</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <% if (cake.isFeatured()) { %>
                                            <span class="badge badge-featured"><i class="fas fa-star"></i> Featured</span>
                                        <% } else { %>
                                            <span class="badge bg-secondary">-</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <a href="EditCake.jsp?id=<%= cake.getCakeId() %>" class="btn btn-warning btn-sm">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <a href="DeleteCakeServlet?id=<%= cake.getCakeId() %>" 
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Are you sure you want to delete this cake?')">
                                            <i class="fas fa-trash"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                        <%  }
                        } else { %>
                            <tr>
                                <td colspan="8" class="text-center text-muted">
                                    <i class="fas fa-inbox fa-3x mb-3"></i>
                                    <p>No cakes found. Add your first cake!</p>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
