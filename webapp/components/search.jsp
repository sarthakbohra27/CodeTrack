<%-- ============================================================
     CodeTrack – Search Component
     Usage: <%@ include file="../components/search.jsp" %>
     Params:
       - searchPlaceholder: e.g. "Search questions..."
       - searchValue:       pre-filled value from request
       - searchFormAction:  URL to submit to, e.g. "/questions"
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String searchPlaceholder = (String) request.getAttribute("searchPlaceholder");
    String searchValue       = (String) request.getAttribute("searchValue");
    String searchFormAction  = (String) request.getAttribute("searchFormAction");
    String ctx = request.getContextPath();

    if (searchPlaceholder == null) searchPlaceholder = "Search...";
    if (searchValue       == null) searchValue       = "";
    if (searchFormAction  == null) searchFormAction  = "";
%>

<form class="search-component"
      id="search-form"
      role="search"
      action="<%= ctx + searchFormAction %>"
      method="get"
      autocomplete="off">

  <!-- Icon -->
  <span class="search-icon" aria-hidden="true">
    <i class="fa-solid fa-magnifying-glass"></i>
  </span>

  <!-- Input -->
  <input type="search"
         class="search-input"
         id="search-input"
         name="q"
         value="<%= searchValue %>"
         placeholder="<%= searchPlaceholder %>"
         aria-label="<%= searchPlaceholder %>"
         spellcheck="false"
         maxlength="150">

  <!-- Clear button -->
  <button type="button"
          class="search-clear"
          id="search-clear-btn"
          aria-label="Clear search"
          title="Clear"
          style="<%= searchValue.isEmpty() ? "" : "display:flex;" %>">
    <i class="fa-solid fa-xmark" aria-hidden="true"></i>
  </button>

</form>
