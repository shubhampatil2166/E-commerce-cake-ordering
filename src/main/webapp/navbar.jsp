<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.org.dao.CartDAO" %>
<%
    // Check if user is logged in
    String navUserName = (String) session.getAttribute("userName");
    String navUserRole = (String) session.getAttribute("role");
    Integer navUserId = (Integer) session.getAttribute("userId");
    boolean isLoggedIn = (navUserName != null && navUserId != null);
    
    // Get cart count if user is logged in
    int cartCount = 0;
    if (isLoggedIn) {
        try {
            CartDAO navCartDAO = new CartDAO();  // ← CHANGED: navCartDAO instead of cartDAO
            cartCount = navCartDAO.getCartCount(navUserId);
        } catch (Exception e) {
            System.out.println("Error getting cart count: " + e.getMessage());
            cartCount = 0;
        }
    }
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold text-warning" href="index.jsp">
            <i class="fas fa-birthday-cake"></i> CaKeZo
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                data-bs-target="#navbarNav" aria-controls="navbarNav" 
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">
                        <i class="fas fa-home"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Cakes.jsp">
                        <i class="fas fa-cookie-bite"></i> Cakes
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="About.jsp">
                        <i class="fas fa-info-circle"></i> About
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Contact.jsp">
                        <i class="fas fa-envelope"></i> Contact
                    </a>
                </li>
            </ul>
            
            <!-- Right Side Menu -->
            <ul class="navbar-nav">
                <% if (isLoggedIn) { %>
                    <!-- Logged In User Menu -->
                    <li class="nav-item">
                        <a class="nav-link position-relative" href="Cart.jsp">
                            <i class="fas fa-shopping-cart"></i> Cart 
                            <% if (cartCount > 0) { %>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-warning text-dark">
                                    <%= cartCount %>
                                </span>
                            <% } %>
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" 
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user-circle"></i> <%= navUserName %>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li><a class="dropdown-item" href="index.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                            <li><a class="dropdown-item" href="Cart.jsp"><i class="fas fa-shopping-cart"></i> My Cart 
                                <% if (cartCount > 0) { %><span class="badge bg-warning text-dark"><%= cartCount %></span><% } %>
                            </a></li>
                            <li>
    <a class="dropdown-item" href="MyOrders.jsp">
        <i class="fas fa-box"></i> My Orders
    </a>
</li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                        </ul>
                    </li>
                <% } else { %>
                    <!-- Guest User Menu -->
                    <li class="nav-item">
                        <a class="nav-link" href="Login.jsp">
                            <i class="fas fa-sign-in-alt"></i> Login
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="UserSignUp.jsp">
                            <i class="fas fa-user-plus"></i> Sign Up
                        </a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

</nav>
</nav>

<!-- Bottom Toast Notification -->
<style>
    @keyframes slideIn {
        from {
            transform: translate(-50%, 100px);
            opacity: 0;
        }
        to {
            transform: translate(-50%, 0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translate(-50%, 0);
            opacity: 1;
        }
        to {
            transform: translate(-50%, 100px);
            opacity: 0;
        }
    }
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Check if item was just added to cart
    var urlParams = new URLSearchParams(window.location.search);
    
    if (urlParams.get('msg') === 'added') {
        // Show bottom toast notification
        showBottomToast('✓ Added to cart', 'success');
        
        // Clean up URL (remove ?msg=added)
        var cleanUrl = window.location.pathname;
        var searchParams = window.location.search.replace(/[?&]msg=added/, '').replace(/^&/, '?');
        if (searchParams && searchParams !== '?') {
            cleanUrl += searchParams;
        }
        window.history.replaceState({}, document.title, cleanUrl);
    }
});

// Bottom toast notification function
function showBottomToast(message, type) {
    var toast = document.createElement('div');
    
    // Determine color
    var bgColor = (type === 'success') ? '#28a745' : '#dc3545';
    
    // Set styles
    toast.style.position = 'fixed';
    toast.style.bottom = '30px';
    toast.style.left = '50%';
    toast.style.transform = 'translateX(-50%)';
    toast.style.background = bgColor;
    toast.style.color = 'white';
    toast.style.padding = '12px 30px';
    toast.style.borderRadius = '25px';
    toast.style.boxShadow = '0 4px 15px rgba(0,0,0,0.3)';
    toast.style.zIndex = '9999';
    toast.style.fontSize = '15px';
    toast.style.fontWeight = '500';
    toast.style.animation = 'slideIn 0.4s ease-out';
    toast.style.minWidth = '200px';
    toast.style.textAlign = 'center';
    
    toast.textContent = message;
    
    document.body.appendChild(toast);
    
    // Auto-remove after 2 seconds
    setTimeout(function() {
        toast.style.animation = 'slideOut 0.4s ease-in';
        setTimeout(function() {
            toast.remove();
        }, 400);
    }, 2000);
}
</script>