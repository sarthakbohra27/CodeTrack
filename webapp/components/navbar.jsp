<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ============================================================
     CodeTrack – Navbar Component
     Include in pages with: <%@ include file="components/navbar.jsp" %>
     ============================================================ -->
<nav class="app-navbar" id="appNavbar">
    <div class="navbar-container">

        <!-- Brand Logo -->
        <a href="dashboard.jsp" class="navbar-brand" id="navbarBrand">
            <i class="fa-solid fa-code"></i>
            <span>Code<strong>Track</strong></span>
        </a>

        <!-- Search Bar -->
        <div class="navbar-search" id="navbarSearch">
            <i class="fa-solid fa-magnifying-glass search-icon"></i>
            <input type="text"
                   id="globalSearchInput"
                   class="search-input"
                   placeholder="Search questions…"
                   autocomplete="off"/>
            <div class="search-results-dropdown" id="searchDropdown"></div>
        </div>

        <!-- Right Actions -->
        <div class="navbar-right">

            <!-- Theme Toggle -->
            <button class="navbar-icon-btn" id="themeToggleBtn" aria-label="Toggle theme">
                <i class="fa-solid fa-moon" id="themeIcon"></i>
            </button>

            <!-- Notifications (Future) -->
            <button class="navbar-icon-btn" id="notificationsBtn" aria-label="Notifications">
                <i class="fa-solid fa-bell"></i>
                <span class="notification-badge" id="notificationBadge">3</span>
            </button>

            <!-- User Avatar Dropdown -->
            <div class="user-menu" id="userMenu">
                <button class="user-avatar-btn" id="userAvatarBtn" aria-expanded="false">
                    <div class="avatar" id="navAvatar">
                        <%-- TODO: Show user initials or profile pic --%>
                        <i class="fa-solid fa-user"></i>
                    </div>
                    <span class="user-name" id="navUsername">
                        ${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.displayName : 'User'}
                    </span>
                    <i class="fa-solid fa-chevron-down"></i>
                </button>

                <div class="user-dropdown" id="userDropdown">
                    <a href="profile.jsp"  class="dropdown-item"><i class="fa-solid fa-user"></i> Profile</a>
                    <a href="settings.jsp" class="dropdown-item"><i class="fa-solid fa-gear"></i> Settings</a>
                    <div class="dropdown-divider"></div>
                    <a href="logout"       class="dropdown-item danger"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
                </div>
            </div>

            <!-- Mobile Hamburger -->
            <button class="navbar-icon-btn" id="sidebarToggleBtn" aria-label="Toggle sidebar">
                <i class="fa-solid fa-bars"></i>
            </button>
        </div>

    </div>
</nav>
