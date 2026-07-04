<%-- ============================================================
     CodeTrack – Pagination Component
     Usage: <%@ include file="../components/pagination.jsp" %>
     Params:
       - currentPage:  int  (1-based)
       - totalPages:   int
       - totalItems:   int
       - pageSize:     int
       - paginationUrl: base URL, e.g. "/questions?page="
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    int currentPage = 1;
    int totalPages  = 1;
    int totalItems  = 0;
    int pageSize    = 10;

    Object cpAttr = request.getAttribute("currentPage");
    Object tpAttr = request.getAttribute("totalPages");
    Object tiAttr = request.getAttribute("totalItems");
    Object psAttr = request.getAttribute("pageSize");

    if (cpAttr instanceof Integer) currentPage = (Integer) cpAttr;
    if (tpAttr instanceof Integer) totalPages  = (Integer) tpAttr;
    if (tiAttr instanceof Integer) totalItems  = (Integer) tiAttr;
    if (psAttr instanceof Integer) pageSize    = (Integer) psAttr;

    String paginationUrl = (String) request.getAttribute("paginationUrl");
    if (paginationUrl == null) paginationUrl = "?page=";

    int startItem = (currentPage - 1) * pageSize + 1;
    int endItem   = Math.min(currentPage * pageSize, totalItems);

    // Calculate page window (show up to 5 pages)
    int windowSize = 5;
    int halfWindow = windowSize / 2;
    int pageStart  = Math.max(1, currentPage - halfWindow);
    int pageEnd    = Math.min(totalPages, pageStart + windowSize - 1);
    if (pageEnd - pageStart < windowSize - 1) {
        pageStart = Math.max(1, pageEnd - windowSize + 1);
    }
%>

<% if (totalPages > 1) { %>
<div class="pagination-wrap" role="navigation" aria-label="Pagination">

  <!-- Info -->
  <p class="pagination-info" aria-live="polite">
    Showing <strong><%= startItem %>–<%= endItem %></strong> of
    <strong><%= totalItems %></strong> results
  </p>

  <!-- Controls -->
  <ol class="pagination" role="list">

    <!-- Previous -->
    <li class="page-item <%= currentPage <= 1 ? "disabled" : "" %>">
      <a class="page-link"
         href="<%= currentPage > 1 ? paginationUrl + (currentPage - 1) : "#" %>"
         aria-label="Go to previous page"
         <%= currentPage <= 1 ? "aria-disabled='true' tabindex='-1'" : "" %>>
        <i class="fa-solid fa-chevron-left" aria-hidden="true" style="font-size:11px;"></i>
        <span class="hide-mobile">Prev</span>
      </a>
    </li>

    <!-- First page + ellipsis -->
    <% if (pageStart > 1) { %>
    <li class="page-item">
      <a class="page-link" href="<%= paginationUrl %>1" aria-label="Go to page 1">1</a>
    </li>
    <% if (pageStart > 2) { %>
    <li class="page-ellipsis" aria-hidden="true">…</li>
    <% } %>
    <% } %>

    <!-- Page window -->
    <% for (int p = pageStart; p <= pageEnd; p++) { %>
    <li class="page-item <%= p == currentPage ? "active" : "" %>">
      <a class="page-link"
         href="<%= paginationUrl + p %>"
         aria-label="Go to page <%= p %>"
         <%= p == currentPage ? "aria-current='page'" : "" %>>
        <%= p %>
      </a>
    </li>
    <% } %>

    <!-- Last page + ellipsis -->
    <% if (pageEnd < totalPages) { %>
    <% if (pageEnd < totalPages - 1) { %>
    <li class="page-ellipsis" aria-hidden="true">…</li>
    <% } %>
    <li class="page-item">
      <a class="page-link"
         href="<%= paginationUrl + totalPages %>"
         aria-label="Go to page <%= totalPages %>">
        <%= totalPages %>
      </a>
    </li>
    <% } %>

    <!-- Next -->
    <li class="page-item <%= currentPage >= totalPages ? "disabled" : "" %>">
      <a class="page-link"
         href="<%= currentPage < totalPages ? paginationUrl + (currentPage + 1) : "#" %>"
         aria-label="Go to next page"
         <%= currentPage >= totalPages ? "aria-disabled='true' tabindex='-1'" : "" %>>
        <span class="hide-mobile">Next</span>
        <i class="fa-solid fa-chevron-right" aria-hidden="true" style="font-size:11px;"></i>
      </a>
    </li>

  </ol>
</div>
<% } %>
