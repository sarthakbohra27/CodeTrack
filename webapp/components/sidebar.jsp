<%-- ============================================================
     CodeTrack – Sidebar Component (Authenticated Pages)
     Usage: <%@ include file="../components/sidebar.jsp" %>
     Params:
       - activeSidebarPage: "dashboard" | "questions" | "analytics"
                            | "profile" | "settings"
       - currentUser: User object (from session)
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String activeSidebar = (String) request.getAttribute("activeSidebarPage");
    if (activeSidebar == null) activeSidebar = "";
    String ctx = request.getContextPath();
    // Pull user from session for avatar/name display
    Object userObj = session.getAttribute("currentUser");
    String displayName = "User";
    String displayEmail = "";
    if (userObj instanceof com.codetrack.model.User) {
        com.codetrack.model.User u = (com.codetrack.model.User) userObj;
        displayName  = u.getFullName() != null ? u.getFullName()  : u.getUsername();
        displayEmail = u.getEmail() != null     ? u.getEmail()    : "";
    }
    String initials = displayName.length() >= 2
        ? String.valueOf(displayName.charAt(0)).toUpperCase()
        : displayName.toUpperCase();
%>

<!-- ══════════════════════════════════════════════════════════
     SIDEBAR OVERLAY (mobile backdrop)
     ══════════════════════════════════════════════════════════ -->
<div class="sidebar-overlay" id="sidebar-overlay" aria-hidden="true"></div>

<!-- ══════════════════════════════════════════════════════════
     SIDEBAR
     ══════════════════════════════════════════════════════════ -->
<aside class="app-sidebar" id="app-sidebar" role="complementary" aria-label="Main sidebar">

  <!-- Collapse toggle (desktop) -->
  <button class="sidebar-collapse-btn"
          id="sidebar-collapse-btn"
          aria-label="Collapse sidebar"
          title="Toggle sidebar">
    <i class="fa-solid fa-chevron-left" aria-hidden="true"></i>
  </button>

  <div class="sidebar-inner">

    <!-- User mini card -->
    <div class="sidebar-user" style="
      display:flex; align-items:center; gap:var(--space-3);
      padding:var(--space-3); margin-bottom:var(--space-2);
      border-radius:var(--radius-lg);
      background:var(--color-surface-2);
      overflow:hidden; min-height:52px;">
      <div class="avatar-placeholder avatar-sm" style="
        background:linear-gradient(135deg,var(--color-primary),#818CF8);
        color:#fff; font-weight:var(--fw-bold); flex-shrink:0;">
        <%= initials %>
      </div>
      <div class="sidebar-user-info" style="overflow:hidden;">
        <div style="font-size:var(--text-sm);font-weight:var(--fw-semibold);
             color:var(--color-text);white-space:nowrap;overflow:hidden;
             text-overflow:ellipsis;">
          <%= displayName %>
        </div>
        <div style="font-size:var(--text-xs);color:var(--color-text-muted);
             white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">
          <%= displayEmail %>
        </div>
      </div>
    </div>

    <!-- MAIN NAV -->
    <p class="sidebar-section-label">Main Menu</p>

    <ul role="list" style="display:flex;flex-direction:column;gap:2px;list-style:none;">

      <!-- Dashboard -->
      <li class="sidebar-nav-item">
        <a href="<%= ctx %>/dashboard"
           class="sidebar-nav-link <%= "dashboard".equals(activeSidebar) ? "active" : "" %>"
           data-tooltip="Dashboard"
           aria-current="<%= "dashboard".equals(activeSidebar) ? "page" : "false" %>">
          <span class="sidebar-nav-icon">
            <i class="fa-solid fa-gauge" aria-hidden="true"></i>
          </span>
          <span class="sidebar-nav-label">Dashboard</span>
        </a>
      </li>

      <!-- Questions -->
      <li class="sidebar-nav-item">
        <a href="<%= ctx %>/questions"
           class="sidebar-nav-link <%= "questions".equals(activeSidebar) ? "active" : "" %>"
           data-tooltip="Questions"
           aria-current="<%= "questions".equals(activeSidebar) ? "page" : "false" %>">
          <span class="sidebar-nav-icon">
            <i class="fa-solid fa-list-check" aria-hidden="true"></i>
          </span>
          <span class="sidebar-nav-label">Questions</span>
        </a>
      </li>

      <!-- Analytics -->
      <li class="sidebar-nav-item">
        <a href="<%= ctx %>/analytics"
           class="sidebar-nav-link <%= "analytics".equals(activeSidebar) ? "active" : "" %>"
           data-tooltip="Analytics"
           aria-current="<%= "analytics".equals(activeSidebar) ? "page" : "false" %>">
          <span class="sidebar-nav-icon">
            <i class="fa-solid fa-chart-line" aria-hidden="true"></i>
          </span>
          <span class="sidebar-nav-label">Analytics</span>
        </a>
      </li>
    </ul>

    <!-- ACCOUNT -->
    <p class="sidebar-section-label" style="margin-top:var(--space-4);">Account</p>

    <ul role="list" style="display:flex;flex-direction:column;gap:2px;list-style:none;">

      <!-- Profile -->
      <li class="sidebar-nav-item">
        <a href="<%= ctx %>/profile"
           class="sidebar-nav-link <%= "profile".equals(activeSidebar) ? "active" : "" %>"
           data-tooltip="Profile"
           aria-current="<%= "profile".equals(activeSidebar) ? "page" : "false" %>">
          <span class="sidebar-nav-icon">
            <i class="fa-solid fa-circle-user" aria-hidden="true"></i>
          </span>
          <span class="sidebar-nav-label">Profile</span>
        </a>
      </li>

      <!-- Settings -->
      <li class="sidebar-nav-item">
        <a href="<%= ctx %>/settings"
           class="sidebar-nav-link <%= "settings".equals(activeSidebar) ? "active" : "" %>"
           data-tooltip="Settings"
           aria-current="<%= "settings".equals(activeSidebar) ? "page" : "false" %>">
          <span class="sidebar-nav-icon">
            <i class="fa-solid fa-gear" aria-hidden="true"></i>
          </span>
          <span class="sidebar-nav-label">Settings</span>
        </a>
      </li>
    </ul>

    <!-- BOTTOM: Logout -->
    <div class="sidebar-bottom">
      <ul role="list" style="list-style:none;">
        <li class="sidebar-nav-item">
          <a href="<%= ctx %>/logout"
             class="sidebar-nav-link logout"
             data-tooltip="Logout"
             id="sidebar-logout-btn"
             aria-label="Logout from CodeTrack">
            <span class="sidebar-nav-icon">
              <i class="fa-solid fa-right-from-bracket" aria-hidden="true"></i>
            </span>
            <span class="sidebar-nav-label">Logout</span>
          </a>
        </li>
      </ul>
    </div>

  </div><!-- /sidebar-inner -->
</aside>

<script src="<%= ctx %>/js/sidebar.js" defer></script>
