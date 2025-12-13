<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.org.model.User, com.org.dao.UserDAO" %>
<%
    // Check admin authentication
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("Login.jsp?error=Admin access required");
        return;
    }
    
    String adminName = (String) session.getAttribute("userName");
    Integer adminId = (Integer) session.getAttribute("userId");
    
    // Fetch all users
    UserDAO userDAO = new UserDAO();
    List<User> users = userDAO.getAllUsers();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Admin</title>
    
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
        
        .users-table {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .badge-admin {
            background-color: #dc3545;
        }
        
        .badge-user {
            background-color: #28a745;
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
                        <a class="nav-link active" href="ManageUsers.jsp">
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
            <h1 class="mb-2"><i class="fas fa-users"></i> Manage Users</h1>
            <p class="text-muted mb-0">View and manage registered users</p>
        </div>
        
        <!-- Success/Error Messages -->
        <% 
            String msg = request.getParameter("msg");
            if (msg != null) {
        %>
            <div class="alert alert-dismissible fade show <%= "deleted".equals(msg) ? "alert-success" : "alert-danger" %>" role="alert">
                <% if ("deleted".equals(msg)) { %>
                    <i class="fas fa-check-circle"></i> <strong>Success!</strong> User deleted successfully.
                <% } else if ("cannot_delete_admin".equals(msg)) { %>
                    <i class="fas fa-exclamation-triangle"></i> <strong>Warning!</strong> Cannot delete admin account.
                <% } else { %>
                    <i class="fas fa-exclamation-circle"></i> <strong>Error!</strong> Operation failed.
                <% } %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <!-- Users Table -->
        <div class="users-table">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (users != null && !users.isEmpty()) {
                            for (User user : users) { 
                                boolean isCurrentAdmin = (adminId != null && adminId == user.getId());
                        %>
                                <tr>
                                    <td><%= user.getId() %></td>
                                    <td><strong><%= user.getFullName() %></strong></td>
                                    <td><%= user.getEmail() %></td>
                                    <td>
                                        <% if ("admin".equals(user.getRole())) { %>
                                            <span class="badge badge-admin">
                                                <i class="fas fa-user-shield"></i> Admin
                                            </span>
                                        <% } else { %>
                                            <span class="badge badge-user">
                                                <i class="fas fa-user"></i> User
                                            </span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <% if (isCurrentAdmin || "admin".equals(user.getRole())) { %>
                                            <button class="btn btn-secondary btn-sm" disabled 
                                                    title="Cannot delete admin accounts">
                                                <i class="fas fa-ban"></i> Delete
                                            </button>
                                        <% } else { %>
                                            <a href="DeleteUserServlet?id=<%= user.getId() %>" 
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Are you sure you want to delete user: <%= user.getFullName() %>?')">
                                                <i class="fas fa-trash"></i> Delete
                                            </a>
                                        <% } %>
                                    </td>
                                </tr>
                        <%  }
                        } else { %>
                            <tr>
                                <td colspan="5" class="text-center text-muted">
                                    <i class="fas fa-inbox fa-3x mb-3"></i>
                                    <p>No users found.</p>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            
            <!-- Summary -->
            <div class="mt-3 text-muted">
                <small><i class="fas fa-info-circle"></i> Total Users: <%= users != null ? users.size() : 0 %></small>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>