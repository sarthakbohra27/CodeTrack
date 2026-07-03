<%-- ============================================================
     CodeTrack – Breadcrumb Component
     Usage: <%@ include file="../components/breadcrumb.jsp" %>
     Params (pass as request attr):
       - breadcrumbs: List<String[]> where each entry = {label, url}
         e.g. [["Dashboard","/dashboard"], ["Questions",""], ...]
         An empty URL = current page (non-clickable)
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%
    @SuppressWarnings("unchecked")
    List<String[]> breadcrumbs = (List<String[]>) request.getAttribute("breadcrumbs");
    String ctx = request.getContextPath();
%>

<% if (breadcrumbs != null && !breadcrumbs.isEmpty()) { %>
<nav class="breadcrumb-nav" aria-label="Breadcrumb" style="
    display:flex; align-items:center; gap:0;
    font-size:var(--text-sm); margin-bottom:var(--space-5);
    flex-wrap:wrap;">

  <ol style="display:flex;align-items:center;gap:0;list-style:none;flex-wrap:wrap;">
    <% for (int i = 0; i < breadcrumbs.size(); i++) {
        String[] crumb = breadcrumbs.get(i);
        String label   = crumb[0];
        String url     = (crumb.length > 1 && crumb[1] != null) ? crumb[1] : "";
        boolean isLast = (i == breadcrumbs.size() - 1);
    %>
    <li style="display:flex;align-items:center;gap:6px;">
      <% if (!isLast && !url.isEmpty()) { %>
        <a href="<%= ctx + url %>"
           style="color:var(--color-text-secondary);text-decoration:none;
                  transition:color 0.15s ease;"
           onmouseover="this.style.color='var(--color-primary)'"
           onmouseout="this.style.color='var(--color-text-secondary)'">
          <%= label %>
        </a>
      <% } else { %>
        <span style="color:<%= isLast ? "var(--color-text)" : "var(--color-text-secondary)" %>;
                     font-weight:<%= isLast ? "var(--fw-medium)" : "var(--fw-regular)" %>;"
              <% if (isLast) { %> aria-current="page" <% } %>>
          <%= label %>
        </span>
      <% } %>

      <% if (!isLast) { %>
        <span aria-hidden="true"
              style="color:var(--color-text-muted);font-size:var(--text-xs);
                     margin-inline:2px;user-select:none;">
          <i class="fa-solid fa-chevron-right" style="font-size:9px;"></i>
        </span>
      <% } %>
    </li>
    <% } %>
  </ol>
</nav>
<% } %>
