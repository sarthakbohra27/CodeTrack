<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Error - CodeTrack</title>
    <%@ include file="../components/header.jsp" %>
    <style>
        .error-container {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: var(--space-8);
        }
        .error-code {
            font-size: 6rem;
            font-weight: var(--fw-extrabold);
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: var(--space-4);
        }
        .error-message {
            font-size: var(--text-xl);
            color: var(--text-secondary);
            margin-bottom: var(--space-8);
        }
    </style>
</head>
<body class="app-body" data-theme="dark">
    <div class="error-container">
        <h1 class="error-code">Oops!</h1>
        <p class="error-message">Something went wrong or the page you are looking for doesn't exist.</p>
        <a href="${pageContext.request.contextPath}/pages/index.jsp" class="btn btn-primary">
            <i class="fa-solid fa-house"></i> Back to Home
        </a>
    </div>
</body>
</html>
