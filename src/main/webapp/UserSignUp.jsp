<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign up - CaKeZo</title>

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
            background: linear-gradient(135deg, var(--cream) 0%, var(--primary-pink) 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }
        
        .signup-container {
            background: white;
            border-radius: 25px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            overflow: hidden;
            max-width: 600px;
            margin: 0 auto;
        }
        
        .signup-header {
            background: linear-gradient(135deg, var(--chocolate) 0%, var(--dark-chocolate) 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }
        
        .signup-header i {
            font-size: 4rem;
            margin-bottom: 15px;
            color: var(--primary-pink);
        }
        
        .signup-header h2 {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .signup-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin: 0;
        }
        
        .signup-form {
            padding: 40px 50px;
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
        
        .btn-signup {
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
        
        .btn-signup:hover {
            background-color: var(--dark-chocolate);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .alert {
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .login-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #e0e0e0;
            color: #666;
        }
        
        .login-link a {
            color: var(--chocolate);
            font-weight: 600;
            text-decoration: none;
        }
        
        .login-link a:hover {
            color: var(--dark-chocolate);
            text-decoration: underline;
        }
        
        .back-home {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
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
        
        small.text-muted {
            font-size: 0.85rem;
        }
        
        /* Responsive */
        @media (max-width: 576px) {
            .signup-form {
                padding: 30px 25px;
            }
            
            .signup-header {
                padding: 30px 20px;
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
    
    <div class="signup-container">
        <!-- Header -->
        <div class="signup-header">
            <i class="fas fa-user-plus"></i>
            <h2>Join CaKeZo</h2>
            <p>Create an account to start ordering delicious cakes!</p>
        </div>
        
        <!-- Sign Up Form -->
        <div class="signup-form">
            <!-- Error/Success Messages -->
            <% 
                String msg = request.getParameter("msg");
                
                if ("success".equals(msg)) { 
            %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> <strong>Success!</strong> Account created. Please login.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% 
                } else if ("exists".equals(msg)) { 
            %>
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <i class="fas fa-info-circle"></i> <strong>Email already exists!</strong> Please use a different email.
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
                } 
            %>
            
            <form action="UserSignUpServlet" method="post" onsubmit="return validateForm()">
                <!-- Full Name -->
                <div class="mb-3">
                    <label for="fullName" class="form-label">
                        <i class="fas fa-user"></i> Full Name
                    </label>
                    <input type="text" class="form-control" id="fullName" name="fullName" 
                           placeholder="Enter your full name" required>
                </div>
                
                <!-- Email -->
                <div class="mb-3">
                    <label for="email" class="form-label">
                        <i class="fas fa-envelope"></i> Email Address
                    </label>
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="your.email@example.com" required>
                </div>
                
                <!-- Password with Eye Icon -->
                <div class="mb-3">
                    <label for="password" class="form-label">
                        <i class="fas fa-lock"></i> Password
                    </label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" name="password" 
                               placeholder="Create a strong password" required minlength="6">
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="fas fa-eye" id="eyeIcon"></i>
                        </button>
                    </div>
                    <small class="text-muted">Minimum 6 characters</small>
                </div>
                
                <!-- Confirm Password (Always Visible) -->
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">
                        <i class="fas fa-check-circle"></i> Confirm Password
                    </label>
                    <input type="text" class="form-control" id="confirmPassword" name="confirmPassword" 
                           placeholder="Re-enter your password" required minlength="6">
                    <small class="text-muted">Type the same password again</small>
                </div>
                
                <!-- Terms & Conditions -->
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="terms" required>
                    <label class="form-check-label" for="terms">
                        I agree to the <a href="#" style="color: var(--chocolate);">Terms & Conditions</a>
                    </label>
                </div>
                
                <!-- Sign Up Button -->
                <button type="submit" class="btn btn-signup">
                    <i class="fas fa-user-plus"></i> Create Account
                </button>
            </form>
            
            <!-- Login Link -->
            <div class="login-link">
                Already have an account? <a href="Login.jsp">
                    <i class="fas fa-sign-in-alt"></i> Login Here
                </a>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Password Toggle Script -->
    <script>
        // Toggle for Password field only
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
        
        // Password Match Validation
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                alert('Passwords do not match! Please check and try again.');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>