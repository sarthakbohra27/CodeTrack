<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Analytics - CodeTrack</title>
    <%@ include file="../components/header.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forms.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body class="app-body" data-theme="dark">
    <%@ include file="../components/navbar.jsp" %>
    <div class="app-layout">
        <%@ include file="../components/sidebar.jsp" %>
        <main class="main-content" id="mainContent">
            <div class="page-header">
                <div>
                    <h1 class="page-title">Analytics</h1>
                    <p class="page-subtitle">TODO: Implement Analytics page</p>
                </div>
            </div>
            <%-- TODO: Implement Analytics page content --%>
        </main>
    </div>
    <%@ include file="../components/loader.jsp" %>
    <script src="${pageContext.request.contextPath}/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/js/theme.js"></script>
</body>
</html>

