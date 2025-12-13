<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CaKeZo</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.4.0/css/all.css">
    
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-pink: #FFB6C1;
            --cream: #FFF8DC;
            --chocolate: #8B4513;
            --dark-chocolate: #5D4037;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--primary-pink) 0%, var(--cream) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .login-container {
            background: white;
            border-radius: 25px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
            display: flex;
            flex-direction: row;
        }
        
        /* Left Side - Branding */
        .login-brand {
            background: linear-gradient(135deg, var(--chocolate) 0%, var(--dark-chocolate) 100%);
            color: white;
            padding: 60px 40px;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        
        .login-brand i {
            font-size: 5rem;
            margin-bottom: 20px;
            color: var(--primary-pink);
        }
        
        .login-brand h2 {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .login-brand p {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        /* Right Side - Form */
        .login-form {
            padding: 60px 50px;
            flex: 1;
        }
        
        .login-form h3 {
            color: var(--dark-chocolate);
            font-weight: bold;
            margin-bottom: 10px;
            font-size: 2rem;
        }
        
        .login-form .subtitle {
            color: #666;
            margin-bottom: 30px;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--dark-chocolate);
            margin-bottom: 8px;
        }
        
        .form-control {
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 12px 15px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--chocolate);
            box-shadow: 0 0 0 0.2rem rgba(139, 69, 19, 0.15);
        }
        
        .input-group .btn-outline-secondary {
            border: 2px solid #e0e0e0;
            border-left: none;
            color: #6c757d;
            border-radius: 0 10px 10px 0;
        }
        
        .input-group .btn-outline-secondary:hover {
            background-color: #f8f9fa;
            border-color: #e0e0e0;
            color: #495057;
        }
        
        .input-group .form-control {
            border-right: none;
            border-radius: 10px 0 0 10px;
        }
        
        .btn-login {
            background-color: var(--chocolate);
            color: white;
            padding: 12px;
            font-size: 1.1rem;
            border-radius: 10px;
            border: none;
            width: 100%;
            transition: all 0.3s;
            margin-top: 20px;
        }
        
        .btn-login:hover {
            background-color: var(--dark-chocolate);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .alert {
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .divider {
            text-align: center;
            margin: 25px 0;
            position: relative;
        }
        
        .divider::before {
            content: "";
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
            background: #ddd;
        }
        
        .divider span {
            background: white;
            padding: 0 15px;
            position: relative;
            color: #999;
        }
        
        .signup-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        
        .signup-link a {
            color: var(--chocolate);
            font-weight: 600;
            text-decoration: none;
        }
        
        .signup-link a:hover {
            color: var(--dark-chocolate);
            text-decoration: underline;
        }
        
        .back-home {
            position: absolute;
            top: 20px;
            left: 20px;
        }
        
        .back-home a {
            color: var(--dark-chocolate);
            text-decoration: none;
            font-weight: 600;
            background: white;
            padding: 10px 20px;
            border-radius: 25px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            transition: all 0.3s;
        }
        
        .back-home a:hover {
            background: var(--cream);
            transform: translateY(-2px);
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }
            
            .login-brand {
                padding: 40px 30px;
            }
            
            .login-form {
                padding: 40px 30px;
            }
        }
    </style>
</head>
<body>
    
    <!-- Back to Home Button -->
    <div class="back-home">
        <a href="index.jsp">
            <i class="fas fa-arrow-left"></i> Back to Home
        </a>
    </div>
    
    <div class="login-container">
        <!-- Left Side - Branding -->
        <div class="login-brand">
            <i class="fas fa-birthday-cake"></i>
            <h2>CaKeZo</h2>
            <p>Welcome back! Login to explore delicious cakes and sweet treats.</p>
            <div class="mt-4">
                <i class="fas fa-cookie-bite fa-2x mx-2"></i>
                <i class="fas fa-ice-cream fa-2x mx-2"></i>
                <i class="fas fa-cupcake fa-2x mx-2"></i>
            </div>
        </div>
        
        <!-- Right Side - Login Form -->
        <div class="login-form">
            <h3><i class="fas fa-sign-in-alt"></i> Login</h3>
            <p class="subtitle">Enter your credentials to access your account</p>
            
            <!-- Error/Success Messages -->
            <% 
                String msg = request.getParameter("msg");
                String error = request.getParameter("error");
                
                if ("invalid".equals(msg)) { 
            %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle"></i> <strong>Invalid credentials!</strong> Please check your email and password.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% 
                } else if ("error".equals(msg)) { 
            %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-times-circle"></i> <strong>Error!</strong> Something went wrong. Please try again.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% 
                } else if ("logout".equals(msg)) { 
            %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> <strong>Logged out successfully!</strong> Come back soon!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% 
                } else if (error != null) { 
            %>
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <i class="fas fa-info-circle"></i> <%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% 
                } 
            %>
            
            <!-- Login Form -->
            <form action="LoginServlet" method="post">
                <!-- Email Field -->
                <div class="mb-3">
                    <label for="email" class="form-label">
                        <i class="fas fa-envelope"></i> Email Address
                    </label>
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="Enter your email" required>
                </div>
                
                <!-- Password Field with Eye Icon -->
                <div class="mb-3">
                    <label for="password" class="form-label">
                        <i class="fas fa-lock"></i> Password
                    </label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" name="password" 
                               placeholder="Enter your password" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="fas fa-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                </div>
                
                <!-- Remember Me & Forgot Password -->
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe">
                        <label class="form-check-label" for="rememberMe">
                            Remember me
                        </label>
                    </div>
                    <a href="#" class="text-decoration-none" style="color: var(--chocolate);">
                        Forgot Password?
                    </a>
                </div>
                
                <!-- Login Button -->
                <button type="submit" class="btn btn-login">
                    <i class="fas fa-sign-in-alt"></i> Login
                </button>
            </form>
            
            <!-- Divider -->
            <div class="divider">
                <span>OR</span>
            </div>
            
            <!-- Sign Up Link -->
            <div class="signup-link">
                Don't have an account? <a href="UserSignUp.jsp">
                    <i class="fas fa-user-plus"></i> Sign Up Now
                </a>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Password Toggle Script -->
    <script>
        const togglePassword = document.getElementById('togglePassword');
        const passwordField = document.getElementById('password');
        const eyeIcon = document.getElementById('eyeIcon');

        togglePassword.addEventListener('click', function () {
            const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordField.setAttribute('type', type);
            
            if (type === 'password') {
                eyeIcon.classList.remove('fa-eye-slash');
                eyeIcon.classList.add('fa-eye');
            } else {
                eyeIcon.classList.remove('fa-eye');
                eyeIcon.classList.add('fa-eye-slash');
            }
        });
    </script>
</body>
</html>
