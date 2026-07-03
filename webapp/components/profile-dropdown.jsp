<%-- ============================================================
     CodeTrack – Profile Dropdown Component
     Usage: <%@ include file="../components/profile-dropdown.jsp" %>
     Included automatically by navbar.jsp when isLoggedIn=true
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    Object userObj2 = session.getAttribute("currentUser");
    String pdName  = "User";
    String pdEmail = "";
    String pdInitials = "U";
    if (userObj2 instanceof com.codetrack.model.User) {
        com.codetrack.model.User u = (com.codetrack.model.User) userObj2;
        pdName  = u.getFullName() != null ? u.getFullName() : u.getUsername();
        pdEmail = u.getEmail() != null    ? u.getEmail()    : "";
        pdInitials = pdName.length() >= 1 ? String.valueOf(pdName.charAt(0)).toUpperCase() : "U";
    }
    String ctx2 = request.getContextPath();
%>

<style>
/* ── Profile Dropdown styles ──────────────────────────────── */
.profile-dropdown         { position:relative; display:inline-flex; }
.profile-dropdown-btn     {
  display:inline-flex; align-items:center; gap:var(--space-2);
  padding:4px var(--space-2);
  border-radius:var(--radius-full); border:1px solid var(--color-border);
  background:transparent; cursor:pointer; transition:var(--transition-fast);
}
.profile-dropdown-btn:hover { background:var(--color-surface-2); border-color:var(--color-text-muted); }
.profile-dropdown-avatar  {
  width:28px; height:28px; border-radius:50%;
  background:linear-gradient(135deg,var(--color-primary),#818CF8);
  color:#fff; font-size:var(--text-xs); font-weight:var(--fw-bold);
  display:flex; align-items:center; justify-content:center; flex-shrink:0;
}
.profile-dropdown-name    {
  font-size:var(--text-sm); font-weight:var(--fw-medium);
  color:var(--color-text); max-width:100px;
  overflow:hidden; text-overflow:ellipsis; white-space:nowrap;
}
.profile-dropdown-chevron { font-size:10px; color:var(--color-text-muted); transition:transform 0.2s ease; }
.profile-dropdown-btn[aria-expanded="true"] .profile-dropdown-chevron { transform:rotate(180deg); }

.profile-dropdown-menu {
  position:absolute; top:calc(100% + var(--space-2)); right:0;
  min-width:200px; background:var(--color-surface);
  border:1px solid var(--color-border); border-radius:var(--radius-xl);
  box-shadow:var(--shadow-dropdown); z-index:var(--z-dropdown);
  display:none; overflow:hidden; animation:slideDown 0.2s ease;
}
.profile-dropdown-menu.open { display:block; }

.profile-dropdown-user {
  padding:var(--space-4); border-bottom:1px solid var(--color-border);
}
.profile-dropdown-user-name  { font-size:var(--text-sm); font-weight:var(--fw-semibold); color:var(--color-text); }
.profile-dropdown-user-email { font-size:var(--text-xs); color:var(--color-text-muted); margin-top:2px; }

.profile-dropdown-items { padding:var(--space-2); }
.profile-dropdown-item  {
  display:flex; align-items:center; gap:var(--space-3);
  padding:var(--space-2) var(--space-3); border-radius:var(--radius-md);
  font-size:var(--text-sm); color:var(--color-text-secondary);
  text-decoration:none; transition:var(--transition-fast);
  cursor:pointer; background:none; border:none; width:100%; text-align:left;
}
.profile-dropdown-item:hover { background:var(--color-surface-2); color:var(--color-text); }
.profile-dropdown-item.danger:hover { background:var(--color-danger-light); color:var(--color-danger); }
.profile-dropdown-item i { width:16px; text-align:center; font-size:13px; }
.profile-dropdown-divider { height:1px; background:var(--color-border); margin:var(--space-1) var(--space-2); }
</style>

<div class="profile-dropdown" id="profile-dropdown">
  <!-- Trigger Button -->
  <button class="profile-dropdown-btn"
          id="profile-dropdown-btn"
          aria-label="Open user menu"
          aria-haspopup="menu"
          aria-expanded="false"
          aria-controls="profile-dropdown-menu">
    <div class="profile-dropdown-avatar" aria-hidden="true"><%= pdInitials %></div>
    <span class="profile-dropdown-name hide-mobile"><%= pdName %></span>
    <i class="fa-solid fa-chevron-down profile-dropdown-chevron" aria-hidden="true"></i>
  </button>

  <!-- Dropdown Menu -->
  <div class="profile-dropdown-menu"
       id="profile-dropdown-menu"
       role="menu"
       aria-label="User menu">

    <!-- User info -->
    <div class="profile-dropdown-user">
      <div class="profile-dropdown-user-name"><%= pdName %></div>
      <div class="profile-dropdown-user-email"><%= pdEmail %></div>
    </div>

    <!-- Menu Items -->
    <div class="profile-dropdown-items">
      <a href="<%= ctx2 %>/dashboard" class="profile-dropdown-item" role="menuitem">
        <i class="fa-solid fa-gauge" aria-hidden="true"></i> Dashboard
      </a>
      <a href="<%= ctx2 %>/profile" class="profile-dropdown-item" role="menuitem">
        <i class="fa-solid fa-circle-user" aria-hidden="true"></i> Profile
      </a>
      <a href="<%= ctx2 %>/settings" class="profile-dropdown-item" role="menuitem">
        <i class="fa-solid fa-gear" aria-hidden="true"></i> Settings
      </a>

      <div class="profile-dropdown-divider" role="separator"></div>

      <button class="profile-dropdown-item danger"
              role="menuitem"
              onclick="CodeTrack.Modal.open('modal-confirm-logout')">
        <i class="fa-solid fa-right-from-bracket" aria-hidden="true"></i> Logout
      </button>
    </div>

  </div>
</div>

<script>
/* Profile dropdown toggle */
(function() {
  var btn  = document.getElementById('profile-dropdown-btn');
  var menu = document.getElementById('profile-dropdown-menu');
  if (!btn || !menu) return;

  btn.addEventListener('click', function(e) {
    e.stopPropagation();
    var isOpen = menu.classList.toggle('open');
    btn.setAttribute('aria-expanded', isOpen.toString());
  });

  document.addEventListener('click', function(e) {
    if (!menu.contains(e.target) && e.target !== btn) {
      menu.classList.remove('open');
      btn.setAttribute('aria-expanded', 'false');
    }
  });

  document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape' && menu.classList.contains('open')) {
      menu.classList.remove('open');
      btn.setAttribute('aria-expanded', 'false');
      btn.focus();
    }
  });
})();
</script>
