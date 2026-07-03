<%-- ============================================================
     CodeTrack – Dashboard Stat Card Component
     Usage: <%@ include file="../components/dashboard-card.jsp" %>
     Params:
       - cardIcon:    FA class, e.g. "fa-solid fa-list-check"
       - cardIconColor: "primary" | "success" | "warning" | "danger" | "info"
       - cardLabel:   e.g. "Total Questions"
       - cardValue:   e.g. "248"
       - cardChange:  e.g. "+12 this week" (optional)
       - cardTrend:   "up" | "down" | "neutral" (optional)
       - cardProgress: 0–100 integer (optional, shows progress bar)
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String cardIcon      = (String) request.getAttribute("cardIcon");
    String cardIconColor = (String) request.getAttribute("cardIconColor");
    String cardLabel     = (String) request.getAttribute("cardLabel");
    String cardValue     = (String) request.getAttribute("cardValue");
    String cardChange    = (String) request.getAttribute("cardChange");
    String cardTrend     = (String) request.getAttribute("cardTrend");
    Object cardProgressObj = request.getAttribute("cardProgress");

    if (cardIcon      == null) cardIcon      = "fa-solid fa-chart-bar";
    if (cardIconColor == null) cardIconColor = "primary";
    if (cardLabel     == null) cardLabel     = "Metric";
    if (cardValue     == null) cardValue     = "0";
    if (cardTrend     == null) cardTrend     = "neutral";

    int cardProgress = -1;
    if (cardProgressObj instanceof Integer) cardProgress = (Integer) cardProgressObj;

    String trendIcon = "neutral".equals(cardTrend) ? "fa-minus"
                     : "up".equals(cardTrend)      ? "fa-arrow-trend-up"
                     :                               "fa-arrow-trend-down";
%>

<div class="stat-card stat-card-<%= cardIconColor %> card-hover-anim anim-slide-up">

  <div class="stat-card-header">
    <span class="stat-card-label"><%= cardLabel %></span>
    <div class="stat-card-icon <%= cardIconColor %>" aria-hidden="true">
      <i class="<%= cardIcon %>"></i>
    </div>
  </div>

  <div class="stat-card-value" aria-label="<%= cardLabel %>: <%= cardValue %>">
    <%= cardValue %>
  </div>

  <% if (cardChange != null && !cardChange.isEmpty()) { %>
  <div class="stat-card-change <%= cardTrend %>" aria-label="Trend: <%= cardChange %>">
    <i class="fa-solid <%= trendIcon %>" aria-hidden="true"></i>
    <span><%= cardChange %></span>
  </div>
  <% } %>

  <% if (cardProgress >= 0) { %>
  <div role="progressbar"
       aria-valuenow="<%= cardProgress %>"
       aria-valuemin="0"
       aria-valuemax="100"
       aria-label="<%= cardLabel %> progress: <%= cardProgress %>%"
       style="height:4px; background:var(--color-surface-3); border-radius:var(--radius-full); overflow:hidden; margin-top:var(--space-2);">
    <div style="height:100%; width:<%= cardProgress %>%;
         background:var(--color-<%= cardIconColor %>);
         border-radius:var(--radius-full);
         transition:width 1s ease;"></div>
  </div>
  <% } %>

</div>
