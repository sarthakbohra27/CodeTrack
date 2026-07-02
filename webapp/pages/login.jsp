<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Login to CodeTrack and continue tracking your DSA progress."/>
    <title>Login â€“ CodeTrack</title>
    <link rel="icon" type="image/png" href="images/logo/favicon.png"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/variables.css"/>
    <link rel="stylesheet" href="css/global.css"/>
    <link rel="stylesheet" href="css/auth.css"/>
    <link rel="stylesheet" href="css/animations.css"/>
</head>
<body class="auth-page">

<div class="auth-container">

    <!-- Left Panel: Branding -->
    <div class="auth-left">
        <div class="auth-branding">
            <a href="index.jsp" class="auth-logo">
                <i class="fa-solid fa-code"></i>
                <span>Code<strong>Track</strong></span>
            </a>
            <h2>Welcome Back, Coder!</h2>
            <p>Your DSA journey continues. Login to see your progress.</p>
            <div class="auth-illustration">
                <!-- Decorative stats panel -->
                <div class="auth-stat-card">
                    <i class="fa-solid fa-fire"></i>
                    <div>
                        <strong>159</strong>
                        <span>Problems Solved</span>
                    </div>
                </div>
                <div class="auth-stat-card">
                    <i class="fa-solid fa-trophy"></i>
                    <div>
                        <strong>7-Day Streak</strong>
                        <span>Keep it going!</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Right Panel: Form -->
    <div class="auth-right">
        <div class="auth-form-card">
            <div class="auth-form-header">
                <h1>Sign In</h1>
                <p>Don't have an account? <a href="register.jsp">Register here</a></p>
            </div>

            <!-- Error Message (set by LoginServlet) -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error" id="loginError">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <!-- Login Form -->
            <form action="login" method="POST" id="loginForm" novalidate>
                <div class="form-group">
                    <label for="usernameOrEmail">Username or Email</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-user input-icon"></i>
                        <input type="text"
                               id="usernameOrEmail"
                               name="usernameOrEmail"
                               class="form-control"
                               placeholder="Enter username or email"
                               autocomplete="username"
                               required/>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-lock input-icon"></i>
                        <input type="password"
                               id="password"
                               name="password"
                               class="form-control"
                               placeholder="Enter your password"
                               autocomplete="current-password"
                               required/>
                        <button type="button" class="toggle-password" id="togglePassword" aria-label="Toggle password visibility">
                            <i class="fa-solid fa-eye" id="togglePasswordIcon"></i>
                        </button>
                    </div>
                </div>

                <div class="form-options">
                    <label class="checkbox-label">
                        <input type="checkbox" id="rememberMe" name="rememberMe"/>
                        <span>Remember me</span>
                    </label>
                    <a href="#" class="forgot-link">Forgot password?</a>
                </div>

                <button type="submit" class="btn btn-primary btn-full" id="loginSubmitBtn">
                    <span class="btn-text">Sign In</span>
                    <i class="fa-solid fa-arrow-right-to-bracket"></i>
                </button>
            </form>

            <div class="auth-divider"><span>or continue with</span></div>

            <div class="social-buttons">
                <button class="btn-social" id="githubLoginBtn">
                    <i class="fa-brands fa-github"></i> GitHub
                </button>
                <button class="btn-social" id="googleLoginBtn">
                    <i class="fa-brands fa-google"></i> Google
                </button>
            </div>
        </div>
    </div>

</div>

<script src="js/auth.js"></script>
<script src="js/validation.js"></script>
</body>
</html>

