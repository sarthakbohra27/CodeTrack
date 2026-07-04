<%-- ============================================================
     CodeTrack – Empty State Component
     Usage: <%@ include file="../components/empty-state.jsp" %>
     Params:
       - emptyIcon:    FontAwesome class, e.g. "fa-solid fa-inbox"
       - emptyTitle:   e.g. "No Questions Yet"
       - emptyDesc:    e.g. "Add your first question to get started."
       - emptyBtnText: e.g. "Add Question"
       - emptyBtnUrl:  e.g. "/questions/add"
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String emptyIcon    = (String) request.getAttribute("emptyIcon");
    String emptyTitle   = (String) request.getAttribute("emptyTitle");
    String emptyDesc    = (String) request.getAttribute("emptyDesc");
    String emptyBtnText = (String) request.getAttribute("emptyBtnText");
    String emptyBtnUrl  = (String) request.getAttribute("emptyBtnUrl");
    String ctx = request.getContextPath();

    if (emptyIcon    == null) emptyIcon    = "fa-solid fa-inbox";
    if (emptyTitle   == null) emptyTitle   = "Nothing Here Yet";
    if (emptyDesc    == null) emptyDesc    = "There's no data to display right now.";
%>

<div class="card-empty anim-fade-in" role="status" aria-label="<%= emptyTitle %>">

  <!-- Icon -->
  <div class="card-empty-icon" aria-hidden="true">
    <i class="<%= emptyIcon %>" style="font-size:28px;"></i>
  </div>

  <!-- Text -->
  <div>
    <h3 class="card-empty-title"><%= emptyTitle %></h3>
    <p class="card-empty-desc"><%= emptyDesc %></p>
  </div>

  <!-- CTA Button (optional) -->
  <% if (emptyBtnText != null && emptyBtnUrl != null) { %>
  <a href="<%= ctx + emptyBtnUrl %>" class="btn btn-primary btn-md">
    <i class="fa-solid fa-plus" aria-hidden="true"></i>
    <%= emptyBtnText %>
  </a>
  <% } %>

</div>
