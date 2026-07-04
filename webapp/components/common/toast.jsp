<%-- ============================================================
     CodeTrack – Toast Notification Container
     Usage: <%@ include file="../components/toast.jsp" %>
     JS API: CodeTrack.Toast.show({ type, title, message, duration })
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!-- ══════════════════════════════════════════════════════════
     TOAST CONTAINER — injected toasts appear here
     ══════════════════════════════════════════════════════════ -->
<div id="toast-container"
     role="region"
     aria-label="Notifications"
     aria-live="polite"
     aria-atomic="false">
</div>

<!-- Server-side flash messages → auto-convert to toasts -->
<%
    String flashSuccess = (String) session.getAttribute("flashSuccess");
    String flashError   = (String) session.getAttribute("flashError");
    String flashWarning = (String) session.getAttribute("flashWarning");
    String flashInfo    = (String) session.getAttribute("flashInfo");

    if (flashSuccess != null) session.removeAttribute("flashSuccess");
    if (flashError   != null) session.removeAttribute("flashError");
    if (flashWarning != null) session.removeAttribute("flashWarning");
    if (flashInfo    != null) session.removeAttribute("flashInfo");
%>

<% if (flashSuccess != null || flashError != null || flashWarning != null || flashInfo != null) { %>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    <% if (flashSuccess != null) { %>
      CodeTrack.Toast.show({ type: 'success', title: 'Success', message: '<%= flashSuccess.replace("'", "\\'") %>' });
    <% } %>
    <% if (flashError != null) { %>
      CodeTrack.Toast.show({ type: 'error', title: 'Error', message: '<%= flashError.replace("'", "\\'") %>' });
    <% } %>
    <% if (flashWarning != null) { %>
      CodeTrack.Toast.show({ type: 'warning', title: 'Warning', message: '<%= flashWarning.replace("'", "\\'") %>' });
    <% } %>
    <% if (flashInfo != null) { %>
      CodeTrack.Toast.show({ type: 'info', title: 'Info', message: '<%= flashInfo.replace("'", "\\'") %>' });
    <% } %>
  });
</script>
<% } %>
