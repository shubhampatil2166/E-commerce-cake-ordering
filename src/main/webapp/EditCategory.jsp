<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.org.model.Category, com.org.dao.CategoryDAO" %>
<%
    // Check admin authentication
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("Login.jsp?error=Admin access required");
        return;
    }
    
    String adminName = (String) session.getAttribute("userName");
    
    // Get category ID from URL
    String categoryIdParam = request.getParameter("id");
    if (categoryIdParam == null) {
        response.sendRedirect("ManageCategories.jsp?msg=error");
        return;
    }
    
    int categoryId = Integer.parseInt(categoryIdParam);
    
    // Fetch category details
    CategoryDAO categoryDAO = new CategoryDAO();
    Category category = categoryDAO.getCategoryById(categoryId);
    
    if (category == null) {
        response.sendRedirect("ManageCategories.jsp?msg=error");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Category - Admin</title>
    
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
        
        .form-container {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .form-label {
            font-weight: 600;
            color: #2c3e50;
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
            <h1 class="mb-2"><i class="fas fa-edit"></i> Edit Category</h1>
            <p class="text-muted mb-0">Update category details below</p>
        </div>
        
        <!-- Edit Category Form -->
        <div class="form-container">
            <form action="EditCategoryServlet" method="post">
                <input type="hidden" name="categoryId" value="<%= category.getCategoryId() %>">
                
                <div class="row">
                    <!-- Category Name -->
                    <div class="col-12 mb-3">
                        <label for="categoryName" class="form-label">
                            <i class="fas fa-tag"></i> Category Name *
                        </label>
                        <input type="text" class="form-control" id="categoryName" name="categoryName" 
                               value="<%= category.getCategoryName() %>" required>
                    </div>
                    
                    <!-- Description -->
                    <div class="col-12 mb-4">
                        <label for="description" class="form-label">
                            <i class="fas fa-align-left"></i> Description
                        </label>
                        <textarea class="form-control" id="description" name="description" 
                                  rows="4"><%= category.getDescription() != null ? category.getDescription() : "" %></textarea>
                    </div>
                    
                    <!-- Buttons -->
                    <div class="col-12">
                        <button type="submit" class="btn btn-warning btn-lg">
                            <i class="fas fa-save"></i> Update Category
                        </button>
                        <a href="ManageCategories.jsp" class="btn btn-secondary btn-lg">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
