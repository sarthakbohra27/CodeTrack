<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Create your free CodeTrack account and start tracking your DSA practice."/>
    <title>Register â€“ CodeTrack</title>
    <link rel="icon" type="image/png" href="images/logo/favicon.png"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/variables.css"/>
    <link rel="stylesheet" href="css/global.css"/>
    <link rel="stylesheet" href="css/auth.css"/>
    <link rel="stylesheet" href="css/animations.css"/>
</head>
<body class="auth-page">

<div class="auth-container register-container">

    <!-- Left Panel: Branding -->
    <div class="auth-left">
        <div class="auth-branding">
            <a href="index.jsp" class="auth-logo">
                <i class="fa-solid fa-code"></i>
                <span>Code<strong>Track</strong></span>
            </a>
            <h2>Join Thousands of Coders!</h2>
            <p>Create your free account and take control of your DSA preparation.</p>
            <ul class="auth-benefits">
                <li><i class="fa-solid fa-check"></i> Track problems across all platforms</li>
                <li><i class="fa-solid fa-check"></i> Visualize your progress with charts</li>
                <li><i class="fa-solid fa-check"></i> Store notes for every problem</li>
                <li><i class="fa-solid fa-check"></i> 100% free, no credit card needed</li>
            </ul>
        </div>
    </div>

    <!-- Right Panel: Form -->
    <div class="auth-right">
        <div class="auth-form-card">
            <div class="auth-form-header">
                <h1>Create Account</h1>
                <p>Already have an account? <a href="login.jsp">Sign in</a></p>
            </div>

            <!-- Error / Success Messages -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">
                    <i class="fa-solid fa-circle-check"></i>
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <!-- Registration Form -->
            <form action="register" method="POST" id="registerForm" novalidate>

                <div class="form-row">
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-id-card input-icon"></i>
                            <input type="text"
                                   id="fullName"
                                   name="fullName"
                                   class="form-control"
                                   placeholder="Your full name"
                                   autocomplete="name"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="username">Username <span class="required">*</span></label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-at input-icon"></i>
                            <input type="text"
                                   id="username"
                                   name="username"
                                   class="form-control"
                                   placeholder="Choose a username"
                                   autocomplete="username"
                                   required/>
                        </div>
                        <span class="form-hint" id="usernameHint">3â€“50 chars, letters/numbers/_ only</span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">Email Address <span class="required">*</span></label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-envelope input-icon"></i>
                        <input type="email"
                               id="email"
                               name="email"
                               class="form-control"
                               placeholder="your@email.com"
                               autocomplete="email"
                               required/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="regPassword">Password <span class="required">*</span></label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-lock input-icon"></i>
                            <input type="password"
                                   id="regPassword"
                                   name="password"
                                   class="form-control"
                                   placeholder="Min. 8 characters"
                                   autocomplete="new-password"
                                   required/>
                            <button type="button" class="toggle-password" id="toggleRegPassword" aria-label="Show password">
                                <i class="fa-solid fa-eye"></i>
                            </button>
                        </div>
                        <div class="password-strength" id="passwordStrength"></div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                        <div class="input-wrapper">
                            <i class="fa-solid fa-lock input-icon"></i>
                            <input type="password"
                                   id="confirmPassword"
                                   name="confirmPassword"
                                   class="form-control"
                                   placeholder="Re-enter password"
                                   autocomplete="new-password"
                                   required/>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="checkbox-label">
                        <input type="checkbox" id="agreeTerms" name="agreeTerms" required/>
                        <span>I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></span>
                    </label>
                </div>

                <button type="submit" class="btn btn-primary btn-full" id="registerSubmitBtn">
                    <span class="btn-text">Create Account</span>
                    <i class="fa-solid fa-user-plus"></i>
                </button>
            </form>
        </div>
    </div>

</div>

<script src="js/auth.js"></script>
<script src="js/validation.js"></script>
</body>
</html>

