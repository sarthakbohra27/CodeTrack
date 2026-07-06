<%-- ============================================================
     CodeTrack – Login Form (Fragment)
     ============================================================
     This file contains ONLY the Login Form.
     It integrates into the existing auth-layout.jsp container.
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctx = request.getContextPath(); %>

<!-- Link the isolated Login CSS -->
<link rel="stylesheet" href="<%= ctx %>/assets/css/pages/auth/login.css">

<!-- Login Form Wrapper -->
<div class="login-wrapper" id="loginWrapper">
  
  <div class="login-header">
    <h1 class="login-title">Welcome Back 👋</h1>
    <p class="login-subtitle">Sign in to continue your coding journey.</p>
  </div>

  <form id="loginForm" class="login-form" novalidate>
    
    <!-- Email Field -->
    <div class="login-form-group">
      <label class="login-label" for="email">Email Address</label>
      <div class="login-input-wrapper">
        <input type="email" id="email" name="email" class="login-input" placeholder="you@example.com" autocomplete="email" required>
        <i class="fa-solid fa-circle-exclamation login-validation-icon error-icon"></i>
        <i class="fa-solid fa-circle-check login-validation-icon success-icon"></i>
      </div>
      <span class="login-error-text"></span>
    </div>

    <!-- Password Field -->
    <div class="login-form-group password-group">
      <div class="login-label">
        <label for="password">Password</label>
        <a href="#" class="login-forgot-link" tabindex="-1">Forgot Password?</a>
      </div>
      <div class="login-input-wrapper">
        <input type="password" id="password" name="password" class="login-input" placeholder="••••••••" autocomplete="current-password" required>
        <button type="button" id="passwordToggleBtn" class="login-password-toggle" aria-label="Toggle password visibility" tabindex="-1">
          <i class="fa-solid fa-eye"></i>
        </button>
        <i class="fa-solid fa-circle-exclamation login-validation-icon error-icon"></i>
        <i class="fa-solid fa-circle-check login-validation-icon success-icon"></i>
      </div>
      <span class="login-error-text"></span>
    </div>

    <!-- Remember Me -->
    <div class="login-options">
      <label class="login-checkbox-group">
        <input type="checkbox" id="remember" name="remember" class="login-checkbox">
        <span class="login-checkbox-label">Remember me for 30 days</span>
      </label>
    </div>

    <!-- Submit Button -->
    <button type="submit" id="loginSubmitBtn" class="login-btn login-btn-primary">
      <span class="btn-text">Sign In</span>
      <i class="fa-solid fa-spinner spinner"></i>
    </button>

  </form>

  <div class="login-divider">OR</div>

  <!-- Social Login -->
  <button type="button" class="login-btn login-btn-social">
    <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/google/google-original.svg" alt="Google">
    Continue with Google
  </button>

  <div class="login-footer">
    Don't have an account? <a href="<%= ctx %>/pages/auth/register.jsp">Register</a>
  </div>

</div>

<!-- Load the isolated Login JS -->
<script src="<%= ctx %>/assets/js/auth/login.js"></script>

<%-- 
  ============================================================
  INJECTION SCRIPT (Development Convenience)
  ============================================================
  If this page is opened directly in a browser (or via a framework), 
  and the auth-layout container is missing, this script will 
  attempt to fetch the layout and inject the form into it. 
  This respects the strict rule to NOT modify auth-layout.jsp.
--%>
<script>
  (function() {
    // If the auth layout container doesn't exist around us...
    if (!document.querySelector('.auth-form-container')) {
      // 1. Fetch the layout
      fetch('<%= ctx %>/pages/auth/auth-layout.jsp')
        .then(response => response.text())
        .then(html => {
          // 2. Parse the layout
          const parser = new DOMParser();
          const doc = parser.parseFromString(html, 'text/html');
          
          // 3. Find the container in the layout
          const container = doc.querySelector('.auth-form-container');
          if (container) {
            // 4. Move our form into the container
            const formHtml = document.getElementById('loginWrapper').outerHTML;
            const cssHtml = document.querySelector('link[href*="login.css"]').outerHTML;
            const jsHtml = document.querySelector('script[src*="login.js"]').outerHTML;
            
            container.innerHTML = cssHtml + formHtml;
            
            // 5. Replace current document with the new layout
            document.open();
            document.write(doc.documentElement.outerHTML);
            document.close();

            // Re-evaluate the script since document.write strips execution
            const script = document.createElement('script');
            script.src = '<%= ctx %>/assets/js/auth/login.js';
            document.body.appendChild(script);
          }
        })
        .catch(err => console.warn('Could not auto-inject into auth layout:', err));
    } else {
      // If the container exists, replace its inner placeholder text
      const container = document.querySelector('.auth-form-container');
      const wrapper = document.getElementById('loginWrapper');
      
      // Make sure we don't infinitely append. If there's placeholder text, clear it.
      if (container.innerHTML.includes('Authentication Form Here')) {
         container.innerHTML = '';
         container.appendChild(document.querySelector('link[href*="login.css"]'));
         container.appendChild(wrapper);
         container.appendChild(document.querySelector('script[src*="login.js"]'));
      }
    }
  })();
</script>
