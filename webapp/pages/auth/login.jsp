<%-- ============================================================
     CodeTrack – Login Page
     Phase 2 – Step 5
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    // Simulate non-logged in state for frontend phase
    request.setAttribute("isLoggedIn", false);
%>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Log in to CodeTrack</title>
  
  <!-- ── Favicon ─────────────────────────────────────────── -->
  <link rel="icon"             type="image/svg+xml" href="<%= ctx %>/assets/images/icon.svg">
  <link rel="icon"             type="image/png"     href="<%= ctx %>/assets/images/icon-512.png">
  <link rel="apple-touch-icon"                      href="<%= ctx %>/assets/images/icon-512.png">

  <!-- ── Fonts ───────────────────────────────────────────── -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">

  <!-- ── Font Awesome ────────────────────────────────────── -->
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
        integrity="sha512-Avb2QiuDEEvB4bZJYdab3bGvVblMzfv0L+07ckOzaJjCXnMZiMjzOWbXFdpPbMQaWxX2deMFB3I2pnYS+qow=="
        crossorigin="anonymous" referrerpolicy="no-referrer">

  <!-- ── Design System CSS ───────────────────────────────── -->
  <link rel="stylesheet" href="<%= ctx %>/assets/css/base/variables.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/base/global.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/base/animations.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/components/buttons.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/components/forms.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/components/components.css">
  
  <!-- ── Page Specific CSS ───────────────────────────────── -->
  <link rel="stylesheet" href="<%= ctx %>/assets/css/pages/auth.css">

  <!-- Prevent FOWT -->
  <script>
    (function(){var t=localStorage.getItem('codetrack-theme');if(!t){t=window.matchMedia('(prefers-color-scheme:light)').matches?'light':'dark';}document.documentElement.setAttribute('data-theme',t);})();
  </script>
</head>

<body>

  <!-- Loaders & Toasts -->
  <%@ include file="../../components/common/loader.jsp" %>
  <%@ include file="../../components/common/toast.jsp" %>

  <div class="auth-page">
    <main class="auth-main">
      
      <!-- Back Button -->
      <a href="<%= ctx %>/pages/index.jsp" class="auth-back" aria-label="Back to Home">
        <i class="fa-solid fa-arrow-left"></i> Home
      </a>

      <!-- Login Card -->
      <div class="auth-card">
        
        <header class="auth-header">
          <a href="<%= ctx %>/pages/index.jsp" class="auth-logo" aria-label="CodeTrack Home">
            <img src="<%= ctx %>/assets/images/logo-dark.png" alt="CodeTrack" class="logo-img-dark">
            <img src="<%= ctx %>/assets/images/logo-light.png" alt="CodeTrack" class="logo-img-light" style="display: none;">
          </a>
          <h1 class="auth-title">Welcome back</h1>
          <p class="auth-subtitle">Log in to track your DSA progress</p>
        </header>

        <!-- OAuth / Social Logins -->
        <div class="auth-social">
          <button class="btn-social" type="button">
            <i class="fa-brands fa-github"></i> Continue with GitHub
          </button>
          <button class="btn-social" type="button">
            <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/google/google-original.svg" alt="Google" style="width: 18px; height: 18px;">
            Continue with Google
          </button>
        </div>

        <div class="auth-divider">or log in with email</div>

        <!-- Email Login Form -->
        <form class="auth-form" action="#" method="POST" id="loginForm">
          
          <div class="form-group">
            <label class="form-label" for="email">Email address</label>
            <input type="email" id="email" name="email" class="form-input" placeholder="you@example.com" required autocomplete="email">
          </div>

          <div class="form-group">
            <div class="form-row">
              <label class="form-label" for="password">Password</label>
              <a href="#" class="forgot-link" tabindex="-1">Forgot password?</a>
            </div>
            <div class="password-wrapper">
              <input type="password" id="password" name="password" class="form-input" placeholder="••••••••" required autocomplete="current-password">
              <button type="button" class="password-toggle" aria-label="Toggle password visibility" tabindex="-1">
                <i class="fa-regular fa-eye"></i>
              </button>
            </div>
          </div>

          <button type="submit" class="btn btn-primary auth-submit">Log In</button>
        </form>

        <footer class="auth-footer">
          Don't have an account? <a href="<%= ctx %>/pages/auth/register.jsp">Sign up</a>
        </footer>

      </div>
    </main>
  </div>

  <!-- ── Scripts ─────────────────────────────────────────── -->
  <script src="<%= ctx %>/assets/js/theme/theme.js"></script>
  <script src="<%= ctx %>/assets/js/common/toast.js"></script>
  <script src="<%= ctx %>/assets/js/auth/auth.js"></script>
  
  <script>
    // Simple inline script to swap logo based on theme (handled normally by theme.js, but manual here for auth pages)
    document.addEventListener('DOMContentLoaded', () => {
      const updateLogo = () => {
        const theme = document.documentElement.getAttribute('data-theme');
        const darkLogo = document.querySelector('.logo-img-dark');
        const lightLogo = document.querySelector('.logo-img-light');
        if (darkLogo && lightLogo) {
          if (theme === 'light') {
            darkLogo.style.display = 'none';
            lightLogo.style.display = 'block';
          } else {
            darkLogo.style.display = 'block';
            lightLogo.style.display = 'none';
          }
        }
      };
      
      updateLogo();
      
      // Listen for theme toggle clicks if added later
      const observer = new MutationObserver(updateLogo);
      observer.observe(document.documentElement, { attributes: true, attributeFilter: ['data-theme'] });
    });
  </script>
</body>
</html>
