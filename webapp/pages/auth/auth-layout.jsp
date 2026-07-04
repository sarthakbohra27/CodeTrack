<%-- ============================================================
     CodeTrack – Shared Authentication Layout
     ============================================================
     This is a reusable template layout for Auth pages (Login, Register).
     Future pages will replace the placeholder block with actual forms.
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CodeTrack Authentication</title>

  <!-- ── Favicon ─────────────────────────────────────────── -->
  <link rel="icon" type="image/svg+xml" href="<%= ctx %>/assets/images/icon.svg">

  <!-- ── Fonts ───────────────────────────────────────────── -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">

  <!-- ── Font Awesome ────────────────────────────────────── -->
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
        integrity="sha512-Avb2QiuDEEvB4bZJYdab3bGvVblMzfv0L+07ckOzaJjCXnMZiMjzOWbXFdpPbMQaWxX2deMFB3I2pnYS+qow=="
        crossorigin="anonymous" referrerpolicy="no-referrer">

  <!-- ── Base Design System ──────────────────────────────── -->
  <link rel="stylesheet" href="<%= ctx %>/assets/css/base/variables.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/base/global.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/base/animations.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/base/utilities.css">
  
  <!-- ── Auth Layout Specific CSS ────────────────────────── -->
  <link rel="stylesheet" href="<%= ctx %>/assets/css/pages/auth/auth-layout.css">

  <!-- Prevent FOWT -->
  <script>
    (function(){var t=localStorage.getItem('codetrack-theme');if(!t){t=window.matchMedia('(prefers-color-scheme:light)').matches?'light':'dark';}document.documentElement.setAttribute('data-theme',t);})();
  </script>
</head>
<body>

  <!-- ══════════════════════════════════════════════════════════
       MAIN AUTH LAYOUT (SPLIT SCREEN)
       ══════════════════════════════════════════════════════════ -->
  <div class="auth-layout-wrapper">
    
    <!-- ── Top Bar ── -->
    <div class="auth-topbar">
      <button id="auth-theme-toggle" class="auth-theme-toggle" aria-label="Toggle dark and light theme">
        <i id="auth-theme-icon" class="fa-solid fa-moon"></i>
      </button>
    </div>

    <!-- ── LEFT PANEL (BRANDING 45%) ── -->
    <aside class="auth-panel-left" aria-label="CodeTrack Branding">
      <div class="auth-brand-content">
        
        <!-- Logo -->
        <a href="<%= ctx %>/pages/index.jsp" class="auth-brand-logo" aria-label="Go to Homepage">
          <i class="fa-solid fa-code"></i> CodeTrack
        </a>

        <!-- Content -->
        <div class="auth-brand-tagline">Track • Analyze • Improve</div>
        <h1 class="auth-brand-headline">Master Your<br>Coding Journey.</h1>
        <p class="auth-brand-desc">
          Stay organized, monitor your progress, and prepare for coding interviews with one powerful dashboard.
        </p>

        <!-- Feature List -->
        <ul class="auth-features-list">
          <li class="auth-feature-item">
            <i class="fa-solid fa-circle-check"></i> Track Questions
          </li>
          <li class="auth-feature-item">
            <i class="fa-solid fa-circle-check"></i> Analyze Progress
          </li>
          <li class="auth-feature-item">
            <i class="fa-solid fa-circle-check"></i> Organize Notes
          </li>
          <li class="auth-feature-item">
            <i class="fa-solid fa-circle-check"></i> Stay Consistent
          </li>
        </ul>

        <!-- CSS Only Illustration (Floating Dashboard Mock) -->
        <div class="auth-illustration" aria-hidden="true">
          <!-- Stat Cards -->
          <div class="mock-stat-card mock-stat-1">
            <i class="fa-solid fa-fire" style="color:#F59E0B"></i> 14 Day Streak
          </div>
          <div class="mock-stat-card mock-stat-2">
            <i class="fa-solid fa-bullseye" style="color:#10B981"></i> 95% Accuracy
          </div>

          <!-- Code Window -->
          <div class="mock-window">
            <div class="mock-header">
              <div class="mock-dot r"></div>
              <div class="mock-dot y"></div>
              <div class="mock-dot g"></div>
            </div>
            <div class="mock-body">
              <div class="mock-code-line w-60 accent"></div>
              <div class="mock-code-line w-80"></div>
              <div class="mock-code-line w-40"></div>
              <div class="mock-code-line w-50"></div>
              <div class="mock-code-line w-80"></div>
            </div>
          </div>
        </div>

      </div>
    </aside>

    <!-- ── RIGHT PANEL (AUTH CONTAINER 55%) ── -->
    <main class="auth-panel-right" aria-label="Authentication Area">
      
      <!-- Reusable Container (Forms injected here) -->
      <div class="auth-form-container">
        
        <!-- ============================================== -->
        <!--             AUTHENTICATION FORM HERE           -->
        <!-- ============================================== -->
        <div style="padding: 4rem; text-align: center; border: 2px dashed var(--color-border); border-radius: var(--radius-lg); color: var(--color-text-secondary); width: 100%;">
          <h3>Authentication Form Here</h3>
          <p style="font-size: var(--text-sm); margin-top: var(--spacing-sm);">
            (Login / Register forms will be injected into this placeholder)
          </p>
        </div>
        <!-- ============================================== -->

      </div>

    </main>
  </div>

  <!-- ── Scripts ── -->
  <script src="<%= ctx %>/assets/js/auth/auth-layout.js"></script>
</body>
</html>
