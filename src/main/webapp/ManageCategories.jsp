<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.org.model.Category, com.org.dao.CategoryDAO" %>
<%
    // Check admin authentication
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("Login.jsp?error=Admin access required");
        return;
    }
    
    String adminName = (String) session.getAttribute("userName");
    
    // Fetch all categories
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categories = categoryDAO.getAllCategories();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories - Admin</title>
    
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
        
        .category-table {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
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
                        <a class="nav-link" href="ManageCakes.jsp">
                            <i class="fas fa-birthday-cake"></i> Manage Cakes
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="ManageCategories.jsp">
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
                    <h1 class="mb-2"><i class="fas fa-tags"></i> Manage Categories</h1>
                    <p class="text-muted mb-0">View, edit, and organize cake categories</p>
                </div>
                <div>
                    <a href="AddCategory.jsp" class="btn btn-primary btn-lg">
                        <i class="fas fa-plus-circle"></i> Add New Category
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Success/Error Messages -->
        <% 
            String msg = request.getParameter("msg");
            if (msg != null) {
        %>
            <div class="alert alert-dismissible fade show <%= "success".equals(msg) || "added".equals(msg) || "updated".equals(msg) || "deleted".equals(msg) ? "alert-success" : "alert-danger" %>" role="alert">
                <% if ("added".equals(msg)) { %>
                    <i class="fas fa-check-circle"></i> <strong>Success!</strong> Category added successfully.
                <% } else if ("updated".equals(msg)) { %>
                    <i class="fas fa-check-circle"></i> <strong>Success!</strong> Category updated successfully.
                <% } else if ("deleted".equals(msg)) { %>
                    <i class="fas fa-check-circle"></i> <strong>Success!</strong> Category deleted successfully.
                <% } else if ("has_cakes".equals(msg)) { %>
                    <i class="fas fa-exclamation-triangle"></i> <strong>Warning!</strong> Cannot delete category with existing cakes.
                <% } else { %>
                    <i class="fas fa-exclamation-circle"></i> <strong>Error!</strong> Operation failed.
                <% } %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <!-- Categories Table -->
        <div class="category-table">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Category Name</th>
                            <th>Description</th>
                            <th>Total Cakes</th>
                            <th>Created Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (categories != null && !categories.isEmpty()) {
                            for (Category cat : categories) { 
                                int cakesCount = categoryDAO.getCakesCountByCategory(cat.getCategoryId());
                        %>
                                <tr>
                                    <td><%= cat.getCategoryId() %></td>
                                    <td><strong><%= cat.getCategoryName() %></strong></td>
                                    <td><%= cat.getDescription() != null ? cat.getDescription() : "-" %></td>
                                    <td><span class="badge bg-info"><%= cakesCount %> cakes</span></td>
                                    <td><%= cat.getCreatedDate() != null ? cat.getCreatedDate().toString().substring(0, 10) : "-" %></td>
                                    <td>
                                        <a href="EditCategory.jsp?id=<%= cat.getCategoryId() %>" class="btn btn-warning btn-sm">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <% if (cakesCount == 0) { %>
                                            <a href="DeleteCategoryServlet?id=<%= cat.getCategoryId() %>" 
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Are you sure you want to delete this category?')">
                                                <i class="fas fa-trash"></i> Delete
                                            </a>
                                        <% } else { %>
                                            <button class="btn btn-secondary btn-sm" disabled title="Cannot delete category with cakes">
                                                <i class="fas fa-ban"></i> Delete
                                            </button>
                                        <% } %>
                                    </td>
                                </tr>
                        <%  }
                        } else { %>
                            <tr>
                                <td colspan="6" class="text-center text-muted">
                                    <i class="fas fa-inbox fa-3x mb-3"></i>
                                    <p>No categories found. Add your first category!</p>
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
