<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- ============================================================
     CodeTrack – Sidebar Component
     Include in pages with: <%@ include file="components/sidebar.jsp" %>
     ============================================================ --%>

<%
    // Determine current page for active link highlighting
    String currentPage = request.getServletPath();
    if (currentPage == null) currentPage = "";
%>

<aside class="app-sidebar" id="appSidebar">

    <!-- Sidebar Header -->
    <div class="sidebar-header">
        <span class="sidebar-label">Navigation</span>
        <button class="sidebar-collapse-btn" id="sidebarCollapseBtn" aria-label="Collapse sidebar">
            <i class="fa-solid fa-angles-left"></i>
        </button>
    </div>

    <!-- Main Navigation -->
    <nav class="sidebar-nav" aria-label="Main navigation">

        <div class="nav-section">
            <span class="nav-section-label">Main</span>

            <a href="${pageContext.request.contextPath}/dashboard"
               class="nav-item <%= currentPage.contains("dashboard") ? "active" : "" %>"
               id="navDashboard">
                <i class="fa-solid fa-house"></i>
                <span>Dashboard</span>
            </a>

            <a href="${pageContext.request.contextPath}/questions"
               class="nav-item <%= currentPage.contains("question") ? "active" : "" %>"
               id="navQuestions">
                <i class="fa-solid fa-list-check"></i>
                <span>My Questions</span>
                <span class="nav-badge" id="questionsBadge">0</span>
            </a>

            <a href="${pageContext.request.contextPath}/analytics"
               class="nav-item <%= currentPage.contains("analytics") ? "active" : "" %>"
               id="navAnalytics">
                <i class="fa-solid fa-chart-line"></i>
                <span>Analytics</span>
            </a>
        </div>

        <div class="nav-section">
            <span class="nav-section-label">Quick Filters</span>

            <a href="${pageContext.request.contextPath}/questions?difficulty=Easy"
               class="nav-item"
               id="navEasy">
                <i class="fa-solid fa-circle easy-dot"></i>
                <span>Easy Problems</span>
            </a>

            <a href="${pageContext.request.contextPath}/questions?difficulty=Medium"
               class="nav-item"
               id="navMedium">
                <i class="fa-solid fa-circle medium-dot"></i>
                <span>Medium Problems</span>
            </a>

            <a href="${pageContext.request.contextPath}/questions?difficulty=Hard"
               class="nav-item"
               id="navHard">
                <i class="fa-solid fa-circle hard-dot"></i>
                <span>Hard Problems</span>
            </a>

            <a href="${pageContext.request.contextPath}/questions?favorites=true"
               class="nav-item"
               id="navFavorites">
                <i class="fa-solid fa-star"></i>
                <span>Favorites</span>
            </a>
        </div>

        <div class="nav-section">
            <span class="nav-section-label">Account</span>

            <a href="${pageContext.request.contextPath}/profile"
               class="nav-item <%= currentPage.contains("profile") ? "active" : "" %>"
               id="navProfile">
                <i class="fa-solid fa-user-circle"></i>
                <span>Profile</span>
            </a>

            <a href="${pageContext.request.contextPath}/settings"
               class="nav-item <%= currentPage.contains("settings") ? "active" : "" %>"
               id="navSettings">
                <i class="fa-solid fa-gear"></i>
                <span>Settings</span>
            </a>
        </div>

    </nav>

    <!-- Add Question CTA -->
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/add-question"
           class="btn btn-primary btn-full sidebar-add-btn"
           id="sidebarAddBtn">
            <i class="fa-solid fa-plus"></i>
            <span>Add Question</span>
        </a>
    </div>

</aside>
