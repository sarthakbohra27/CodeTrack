<%-- ============================================================
     CodeTrack – Filters Component
     Usage: <%@ include file="../components/filters.jsp" %>
     This provides the filter bar structure + active tags row.
     Actual option lists are populated by each page.
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    // Read currently applied filters from request params
    String filterDifficulty = request.getParameter("difficulty");
    String filterPlatform   = request.getParameter("platform");
    String filterStatus     = request.getParameter("status");
    String filterTopic      = request.getParameter("topic");
    String ctx = request.getContextPath();
    String baseUrl = (String) request.getAttribute("searchFormAction");
    if (baseUrl == null) baseUrl = request.getServletPath();
%>

<div class="filter-section" id="filter-section">

  <!-- Filter Bar -->
  <div class="filter-bar" role="group" aria-label="Filter controls">

    <!-- Difficulty Filter -->
    <div class="filter-wrap" style="position:relative;">
      <button class="filter-trigger
                     <%= filterDifficulty != null && !filterDifficulty.isEmpty() ? "active" : "" %>"
              id="filter-difficulty-btn"
              aria-haspopup="listbox"
              aria-expanded="false"
              aria-controls="filter-difficulty-panel">
        <i class="fa-solid fa-signal" aria-hidden="true"></i>
        Difficulty
        <% if (filterDifficulty != null && !filterDifficulty.isEmpty()) { %>
          <span class="filter-count">1</span>
        <% } %>
        <i class="fa-solid fa-chevron-down" style="font-size:10px;" aria-hidden="true"></i>
      </button>

      <div class="filter-panel" id="filter-difficulty-panel" style="display:none;" role="listbox">
        <div class="filter-panel-header">
          <span class="filter-panel-title">Difficulty</span>
          <a href="<%= ctx + baseUrl %>?difficulty=" class="btn btn-ghost btn-sm" style="font-size:var(--text-xs);padding:2px 8px;">Reset</a>
        </div>
        <div class="filter-panel-body">
          <% String[] difficulties = {"Easy", "Medium", "Hard"}; %>
          <% for (String diff : difficulties) { %>
          <label class="filter-option">
            <input type="checkbox"
                   name="difficulty"
                   value="<%= diff.toLowerCase() %>"
                   <%= diff.toLowerCase().equals(filterDifficulty) ? "checked" : "" %>
                   onchange="CodeTrack.Filter.apply(this, '<%= ctx + baseUrl %>')">
            <span class="filter-option-label">
              <span class="badge badge-<%= diff.toLowerCase() %>"><%= diff %></span>
            </span>
          </label>
          <% } %>
        </div>
      </div>
    </div>

    <!-- Platform Filter -->
    <div class="filter-wrap" style="position:relative;">
      <button class="filter-trigger
                     <%= filterPlatform != null && !filterPlatform.isEmpty() ? "active" : "" %>"
              id="filter-platform-btn"
              aria-haspopup="listbox"
              aria-expanded="false"
              aria-controls="filter-platform-panel">
        <i class="fa-solid fa-layer-group" aria-hidden="true"></i>
        Platform
        <% if (filterPlatform != null && !filterPlatform.isEmpty()) { %>
          <span class="filter-count">1</span>
        <% } %>
        <i class="fa-solid fa-chevron-down" style="font-size:10px;" aria-hidden="true"></i>
      </button>

      <div class="filter-panel" id="filter-platform-panel" style="display:none;" role="listbox">
        <div class="filter-panel-header">
          <span class="filter-panel-title">Platform</span>
          <a href="<%= ctx + baseUrl %>?platform=" class="btn btn-ghost btn-sm" style="font-size:var(--text-xs);padding:2px 8px;">Reset</a>
        </div>
        <div class="filter-panel-body">
          <% String[] platforms = {"LeetCode", "GeeksforGeeks", "Codeforces", "HackerRank", "Other"}; %>
          <% for (String plat : platforms) { %>
          <label class="filter-option">
            <input type="checkbox"
                   name="platform"
                   value="<%= plat.toLowerCase().replace(" ", "") %>"
                   <%= plat.toLowerCase().replace(" ", "").equals(filterPlatform) ? "checked" : "" %>
                   onchange="CodeTrack.Filter.apply(this, '<%= ctx + baseUrl %>')">
            <span class="filter-option-label"><%= plat %></span>
          </label>
          <% } %>
        </div>
      </div>
    </div>

    <!-- Status Filter -->
    <div class="filter-wrap" style="position:relative;">
      <button class="filter-trigger
                     <%= filterStatus != null && !filterStatus.isEmpty() ? "active" : "" %>"
              id="filter-status-btn"
              aria-haspopup="listbox"
              aria-expanded="false"
              aria-controls="filter-status-panel">
        <i class="fa-solid fa-circle-check" aria-hidden="true"></i>
        Status
        <% if (filterStatus != null && !filterStatus.isEmpty()) { %>
          <span class="filter-count">1</span>
        <% } %>
        <i class="fa-solid fa-chevron-down" style="font-size:10px;" aria-hidden="true"></i>
      </button>

      <div class="filter-panel" id="filter-status-panel" style="display:none;" role="listbox">
        <div class="filter-panel-header">
          <span class="filter-panel-title">Status</span>
        </div>
        <div class="filter-panel-body">
          <label class="filter-option">
            <input type="checkbox" name="status" value="solved"
                   <%= "solved".equals(filterStatus) ? "checked" : "" %>
                   onchange="CodeTrack.Filter.apply(this, '<%= ctx + baseUrl %>')">
            <span class="filter-option-label">
              <span class="badge badge-solved">Solved</span>
            </span>
          </label>
          <label class="filter-option">
            <input type="checkbox" name="status" value="unsolved"
                   <%= "unsolved".equals(filterStatus) ? "checked" : "" %>
                   onchange="CodeTrack.Filter.apply(this, '<%= ctx + baseUrl %>')">
            <span class="filter-option-label">
              <span class="badge badge-unsolved">Unsolved</span>
            </span>
          </label>
        </div>
      </div>
    </div>

    <!-- Reset All -->
    <% boolean hasAnyFilter =
        (filterDifficulty != null && !filterDifficulty.isEmpty()) ||
        (filterPlatform   != null && !filterPlatform.isEmpty())   ||
        (filterStatus     != null && !filterStatus.isEmpty()); %>
    <% if (hasAnyFilter) { %>
    <a href="<%= ctx + baseUrl %>" class="btn btn-ghost btn-sm" aria-label="Reset all filters">
      <i class="fa-solid fa-rotate-left" aria-hidden="true"></i> Reset
    </a>
    <% } %>

  </div><!-- /filter-bar -->

  <!-- Active Filter Tags -->
  <% if (hasAnyFilter) { %>
  <div class="filter-tags" style="display:flex;flex-wrap:wrap;gap:var(--space-2);margin-top:var(--space-3);"
       aria-label="Active filters">
    <% if (filterDifficulty != null && !filterDifficulty.isEmpty()) { %>
    <span class="filter-tag">
      <%= Character.toUpperCase(filterDifficulty.charAt(0)) + filterDifficulty.substring(1) %>
      <a href="<%= ctx + baseUrl %>?platform=<%= filterPlatform != null ? filterPlatform : "" %>&status=<%= filterStatus != null ? filterStatus : "" %>"
         class="filter-tag-remove" aria-label="Remove difficulty filter">
        <i class="fa-solid fa-xmark" aria-hidden="true"></i>
      </a>
    </span>
    <% } %>
    <% if (filterPlatform != null && !filterPlatform.isEmpty()) { %>
    <span class="filter-tag">
      <%= filterPlatform %>
      <a href="<%= ctx + baseUrl %>?difficulty=<%= filterDifficulty != null ? filterDifficulty : "" %>&status=<%= filterStatus != null ? filterStatus : "" %>"
         class="filter-tag-remove" aria-label="Remove platform filter">
        <i class="fa-solid fa-xmark" aria-hidden="true"></i>
      </a>
    </span>
    <% } %>
    <% if (filterStatus != null && !filterStatus.isEmpty()) { %>
    <span class="filter-tag">
      <%= Character.toUpperCase(filterStatus.charAt(0)) + filterStatus.substring(1) %>
      <a href="<%= ctx + baseUrl %>?difficulty=<%= filterDifficulty != null ? filterDifficulty : "" %>&platform=<%= filterPlatform != null ? filterPlatform : "" %>"
         class="filter-tag-remove" aria-label="Remove status filter">
        <i class="fa-solid fa-xmark" aria-hidden="true"></i>
      </a>
    </span>
    <% } %>
  </div>
  <% } %>

</div><!-- /filter-section -->
