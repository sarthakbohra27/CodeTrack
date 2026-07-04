<%-- ============================================================
     CodeTrack – Error Pages Component
     Usage: <%@ include file="../components/error.jsp" %>
     Params:
       - errorCode:    404 | 500 | "network"
       - errorTitle:   Override title (optional)
       - errorMessage: Override message (optional)
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String errorCode    = (String) request.getAttribute("errorCode");
    String errorTitle   = (String) request.getAttribute("errorTitle");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String ctx = request.getContextPath();

    if (errorCode == null) errorCode = "404";

    String icon, defaultTitle, defaultMsg, defaultColor;

    switch (errorCode) {
        case "500":
            icon         = "fa-solid fa-server";
            defaultTitle = "Server Error";
            defaultMsg   = "Something went wrong on our end. Please try again in a moment.";
            defaultColor = "var(--color-danger)";
            break;
        case "network":
            icon         = "fa-solid fa-wifi";
            defaultTitle = "Connection Lost";
            defaultMsg   = "Unable to reach the server. Check your internet connection and try again.";
            defaultColor = "var(--color-warning)";
            break;
        default: /* 404 */
            icon         = "fa-solid fa-ghost";
            defaultTitle = "Page Not Found";
            defaultMsg   = "The page you're looking for doesn't exist or has been moved.";
            defaultColor = "var(--color-primary)";
    }

    if (errorTitle   == null) errorTitle   = defaultTitle;
    if (errorMessage == null) errorMessage = defaultMsg;
%>

<div class="error-page" style="
    display:flex; flex-direction:column; align-items:center;
    justify-content:center; text-align:center;
    min-height:70vh; padding:var(--space-8);
    gap:var(--space-6); animation:fadeIn 0.4s ease;">

  <!-- Icon -->
  <div style="
      width:96px; height:96px; border-radius:var(--radius-full);
      background:var(--color-surface-2);
      display:flex; align-items:center; justify-content:center;
      font-size:40px; color:<%= defaultColor %>;" aria-hidden="true">
    <i class="<%= icon %>"></i>
  </div>

  <!-- Error Code -->
  <div style="font-size:5rem; font-weight:var(--fw-bold);
       color:var(--color-surface-3); line-height:1;
       letter-spacing:-0.05em;" aria-hidden="true">
    <%= errorCode.equals("network") ? "⚡" : errorCode %>
  </div>

  <!-- Text -->
  <div style="max-width:440px;">
    <h1 style="font-size:var(--text-2xl); font-weight:var(--fw-bold);
         color:var(--color-text); margin-bottom:var(--space-3);">
      <%= errorTitle %>
    </h1>
    <p style="font-size:var(--text-base); color:var(--color-text-secondary);
         line-height:var(--leading-relaxed);">
      <%= errorMessage %>
    </p>
  </div>

  <!-- Actions -->
  <div style="display:flex;gap:var(--space-3);flex-wrap:wrap;justify-content:center;">
    <a href="javascript:history.back()" class="btn btn-secondary btn-md">
      <i class="fa-solid fa-arrow-left" aria-hidden="true"></i> Go Back
    </a>
    <a href="<%= ctx %>/pages/index.jsp" class="btn btn-primary btn-md">
      <i class="fa-solid fa-house" aria-hidden="true"></i> Home
    </a>
  </div>

</div>
