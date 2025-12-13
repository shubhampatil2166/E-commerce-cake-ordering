<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.org.model.Cake, com.org.model.Category, com.org.dao.CakeDAO, com.org.dao.CategoryDAO" %>
<%
    // Check admin authentication
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("Login.jsp?error=Admin access required");
        return;
    }
    
    String adminName = (String) session.getAttribute("userName");
    
    // Get cake ID from URL
    String cakeIdParam = request.getParameter("id");
    if (cakeIdParam == null) {
        response.sendRedirect("ManageCakes.jsp?msg=error");
        return;
    }
    
    int cakeId = Integer.parseInt(cakeIdParam);
    
    // Fetch cake details
    CakeDAO cakeDAO = new CakeDAO();
    Cake cake = cakeDAO.getCakeById(cakeId);
    
    if (cake == null) {
        response.sendRedirect("ManageCakes.jsp?msg=error");
        return;
    }
    
    // Fetch all categories for dropdown
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categories = categoryDAO.getAllCategories();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Cake - Admin</title>
    
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
            <h1 class="mb-2"><i class="fas fa-edit"></i> Edit Cake</h1>
            <p class="text-muted mb-0">Update cake details below</p>
        </div>
        
        <!-- Edit Cake Form -->
        <div class="form-container">
            <form action="EditCakeServlet" method="post">
                <input type="hidden" name="cakeId" value="<%= cake.getCakeId() %>">
                
                <div class="row">
                    <!-- Cake Name -->
                    <div class="col-md-6 mb-3">
                        <label for="cakeName" class="form-label">
                            <i class="fas fa-birthday-cake"></i> Cake Name *
                        </label>
                        <input type="text" class="form-control" id="cakeName" name="cakeName" 
                               value="<%= cake.getCakeName() %>" required>
                    </div>
                    
                    <!-- Category -->
                    <div class="col-md-6 mb-3">
                        <label for="categoryId" class="form-label">
                            <i class="fas fa-tag"></i> Category *
                        </label>
                        <select class="form-select" id="categoryId" name="categoryId" required>
                            <% if (categories != null && !categories.isEmpty()) {
                                for (Category cat : categories) { %>
                                    <option value="<%= cat.getCategoryId() %>" 
                                            <%= cat.getCategoryId() == cake.getCategoryId() ? "selected" : "" %>>
                                        <%= cat.getCategoryName() %>
                                    </option>
                            <%  }
                            } %>
                        </select>
                    </div>
                    
                    <!-- Price -->
                    <div class="col-md-6 mb-3">
                        <label for="price" class="form-label">
                            <i class="fas fa-rupee-sign"></i> Price (₹) *
                        </label>
                        <input type="number" class="form-control" id="price" name="price" 
                               step="0.01" min="0" value="<%= cake.getPrice() %>" required>
                    </div>
                    
                    <!-- Stock Quantity -->
                    <div class="col-md-6 mb-3">
                        <label for="stockQuantity" class="form-label">
                            <i class="fas fa-boxes"></i> Stock Quantity *
                        </label>
                        <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" 
                               min="0" value="<%= cake.getStockQuantity() %>" required>
                    </div>
                    
                    <!-- Description -->
                    <div class="col-12 mb-3">
                        <label for="description" class="form-label">
                            <i class="fas fa-align-left"></i> Description
                        </label>
                        <textarea class="form-control" id="description" name="description" 
                                  rows="4"><%= cake.getDescription() != null ? cake.getDescription() : "" %></textarea>
                    </div>
                    
                    <!-- Image Path -->
                    <div class="col-12 mb-3">
                        <label for="imagePath" class="form-label">
                            <i class="fas fa-image"></i> Image URL
                        </label>
                        <input type="text" class="form-control" id="imagePath" name="imagePath" 
                               value="<%= cake.getImagePath() != null ? cake.getImagePath() : "" %>">
                    </div>
                    
                    <!-- Checkboxes -->
                    <div class="col-12 mb-4">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="isAvailable" 
                                   name="isAvailable" value="true" <%= cake.isAvailable() ? "checked" : "" %>>
                            <label class="form-check-label" for="isAvailable">
                                <i class="fas fa-check-circle text-success"></i> Available for Sale
                            </label>
                        </div>
                        
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="isFeatured" 
                                   name="isFeatured" value="true" <%= cake.isFeatured() ? "checked" : "" %>>
                            <label class="form-check-label" for="isFeatured">
                                <i class="fas fa-star text-warning"></i> Mark as Featured
                            </label>
                        </div>
                    </div>
                    
                    <!-- Buttons -->
                    <div class="col-12">
                        <button type="submit" class="btn btn-warning btn-lg">
                            <i class="fas fa-save"></i> Update Cake
                        </button>
                        <a href="ManageCakes.jsp" class="btn btn-secondary btn-lg">
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
