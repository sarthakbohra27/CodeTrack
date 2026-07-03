<%-- ============================================================
     CodeTrack – Navbar Component
     Usage: <%@ include file="../components/navbar.jsp" %>
     Params (set as request attributes before include):
       - activePage: "home" | "features" | "about" | "contact"
       - isLoggedIn: true | false (set by AuthFilter)
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String activePage  = (String)  request.getAttribute("activePage");
    if (activePage == null) activePage = "";
    Object loggedInAttr = request.getAttribute("isLoggedIn");
    boolean isLoggedIn  = (loggedInAttr instanceof Boolean) && (Boolean) loggedInAttr;
    String ctx = request.getContextPath();
%>

<!-- ══════════════════════════════════════════════════════════
     NAVBAR
     ══════════════════════════════════════════════════════════ -->
<link rel="stylesheet" href="<%= ctx %>/css/navbar.css">

<nav class="navbar" id="main-navbar" role="navigation" aria-label="Main navigation">
  <div class="navbar-inner">

    <!-- Brand -->
    <a href="<%= ctx %>/pages/index.jsp" class="navbar-brand" aria-label="CodeTrack Home">
      <div class="navbar-logo-icon" aria-hidden="true">
        <i class="fa-solid fa-code"></i>
      </div>
      <span class="navbar-brand-name">Code<span>Track</span></span>
    </a>

    <!-- Desktop Nav Links -->
    <ul class="navbar-nav" role="list">
      <li class="navbar-nav-item">
        <a href="<%= ctx %>/pages/index.jsp#hero"
           class="navbar-nav-link <%= "home".equals(activePage) ? "active" : "" %>"
           aria-current="<%= "home".equals(activePage) ? "page" : "false" %>">
          Home
        </a>
      </li>
      <li class="navbar-nav-item">
        <a href="<%= ctx %>/pages/index.jsp#features"
           class="navbar-nav-link <%= "features".equals(activePage) ? "active" : "" %>">
          Features
        </a>
      </li>
      <li class="navbar-nav-item">
        <a href="<%= ctx %>/pages/index.jsp#about"
           class="navbar-nav-link <%= "about".equals(activePage) ? "active" : "" %>">
          About
        </a>
      </li>
      <li class="navbar-nav-item">
        <a href="<%= ctx %>/pages/index.jsp#contact"
           class="navbar-nav-link <%= "contact".equals(activePage) ? "active" : "" %>">
          Contact
        </a>
      </li>
    </ul>

    <!-- Right Actions -->
    <div class="navbar-actions">

      <!-- GitHub -->
      <a href="https://github.com/sarthakbohra27/CodeTrack"
         class="navbar-github"
         target="_blank"
         rel="noopener noreferrer"
         aria-label="View on GitHub">
        <i class="fa-brands fa-github" aria-hidden="true"></i>
        <span class="hide-tablet">GitHub</span>
      </a>

      <!-- Theme Toggle -->
      <button class="theme-toggle"
              id="theme-toggle"
              data-theme-toggle
              aria-label="Switch to light mode"
              title="Toggle theme">
        <i class="fa-solid fa-moon" aria-hidden="true"></i>
        <i class="fa-solid fa-sun"  aria-hidden="true" style="display:none;"></i>
      </button>

      <% if (!isLoggedIn) { %>
      <!-- Auth Buttons -->
      <div class="navbar-auth flex-center gap-2">
        <a href="<%= ctx %>/pages/login.jsp" class="btn btn-ghost btn-sm">Log in</a>
        <a href="<%= ctx %>/pages/register.jsp" class="btn btn-primary btn-sm">Get Started</a>
      </div>
      <% } else { %>
      <!-- Logged in: show avatar/profile dropdown trigger -->
      <div class="profile-dropdown-wrap" id="profile-dropdown-trigger">
        <%@ include file="profile-dropdown.jsp" %>
      </div>
      <% } %>

      <!-- Hamburger (mobile) -->
      <button class="navbar-hamburger"
              id="navbar-hamburger"
              aria-label="Open menu"
              aria-expanded="false"
              aria-controls="navbar-mobile-menu">
        <span></span>
        <span></span>
        <span></span>
      </button>
    </div>
  </div>
</nav>

<!-- Mobile Menu -->
<div class="navbar-mobile-menu" id="navbar-mobile-menu" role="dialog" aria-label="Mobile navigation">
  <div class="navbar-mobile-inner">
    <a href="<%= ctx %>/pages/index.jsp#hero"
       class="navbar-mobile-link <%= "home".equals(activePage) ? "active" : "" %>">
      <i class="fa-solid fa-house fa-fw" aria-hidden="true"></i> Home
    </a>
    <a href="<%= ctx %>/pages/index.jsp#features"
       class="navbar-mobile-link <%= "features".equals(activePage) ? "active" : "" %>">
      <i class="fa-solid fa-star fa-fw" aria-hidden="true"></i> Features
    </a>
    <a href="<%= ctx %>/pages/index.jsp#about"
       class="navbar-mobile-link <%= "about".equals(activePage) ? "active" : "" %>">
      <i class="fa-solid fa-circle-info fa-fw" aria-hidden="true"></i> About
    </a>
    <a href="<%= ctx %>/pages/index.jsp#contact"
       class="navbar-mobile-link <%= "contact".equals(activePage) ? "active" : "" %>">
      <i class="fa-solid fa-envelope fa-fw" aria-hidden="true"></i> Contact
    </a>
    <a href="https://github.com/sarthakbohra27/CodeTrack"
       class="navbar-mobile-link"
       target="_blank" rel="noopener noreferrer">
      <i class="fa-brands fa-github fa-fw" aria-hidden="true"></i> GitHub
    </a>

    <div class="navbar-mobile-divider" role="separator"></div>

    <% if (!isLoggedIn) { %>
    <div class="navbar-mobile-actions">
      <a href="<%= ctx %>/pages/login.jsp"    class="btn btn-secondary">Log in</a>
      <a href="<%= ctx %>/pages/register.jsp" class="btn btn-primary">Get Started</a>
    </div>
    <% } else { %>
    <a href="<%= ctx %>/dashboard" class="navbar-mobile-link">
      <i class="fa-solid fa-gauge fa-fw" aria-hidden="true"></i> Dashboard
    </a>
    <a href="<%= ctx %>/logout" class="navbar-mobile-link" style="color: var(--color-danger);">
      <i class="fa-solid fa-right-from-bracket fa-fw" aria-hidden="true"></i> Logout
    </a>
    <% } %>
  </div>
</div>

<script src="<%= ctx %>/js/navbar.js" defer></script>
