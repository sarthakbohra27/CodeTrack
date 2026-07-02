<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Dashboard â€“ CodeTrack</title>
    <link rel="icon" type="image/png" href="images/logo/favicon.png"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <link rel="stylesheet" href="css/variables.css"/>
    <link rel="stylesheet" href="css/global.css"/>
    <link rel="stylesheet" href="css/navbar.css"/>
    <link rel="stylesheet" href="css/sidebar.css"/>
    <link rel="stylesheet" href="css/dashboard.css"/>
    <link rel="stylesheet" href="css/animations.css"/>
    <link rel="stylesheet" href="css/responsive.css"/>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body class="app-body" data-theme="dark">

    <!-- â”€â”€ Include Components â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ -->
    <%@ include file="../components/navbar.jsp" %>

    <div class="app-layout">
        <%@ include file="../components/sidebar.jsp" %>

        <!-- â”€â”€ Main Content â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ -->
        <main class="main-content" id="mainContent">

            <!-- Page Header -->
            <div class="page-header">
                <div>
                    <h1 class="page-title">Dashboard</h1>
                    <p class="page-subtitle">Here's your DSA progress at a glance</p>
                </div>
                <a href="add-question.jsp" class="btn btn-primary" id="addQuestionBtn">
                    <i class="fa-solid fa-plus"></i> Add Question
                </a>
            </div>

            <!-- â”€â”€ Stats Cards â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ -->
            <div class="stats-grid">
                <div class="stat-card total" id="statTotal">
                    <div class="stat-card-icon"><i class="fa-solid fa-check-double"></i></div>
                    <div class="stat-card-info">
                        <span class="stat-card-value" id="totalCount">
                            ${not empty totalCount ? totalCount : 'â€“'}
                        </span>
                        <span class="stat-card-label">Total Solved</span>
                    </div>
                    <div class="stat-card-trend up">
                        <i class="fa-solid fa-arrow-trend-up"></i>
                    </div>
                </div>

                <div class="stat-card easy" id="statEasy">
                    <div class="stat-card-icon"><i class="fa-solid fa-circle"></i></div>
                    <div class="stat-card-info">
                        <span class="stat-card-value" id="easyCount">
                            ${not empty easyCount ? easyCount : 'â€“'}
                        </span>
                        <span class="stat-card-label">Easy</span>
                    </div>
                </div>

                <div class="stat-card medium" id="statMedium">
                    <div class="stat-card-icon"><i class="fa-solid fa-circle"></i></div>
                    <div class="stat-card-info">
                        <span class="stat-card-value" id="mediumCount">
                            ${not empty mediumCount ? mediumCount : 'â€“'}
                        </span>
                        <span class="stat-card-label">Medium</span>
                    </div>
                </div>

                <div class="stat-card hard" id="statHard">
                    <div class="stat-card-icon"><i class="fa-solid fa-circle"></i></div>
                    <div class="stat-card-info">
                        <span class="stat-card-value" id="hardCount">
                            ${not empty hardCount ? hardCount : 'â€“'}
                        </span>
                        <span class="stat-card-label">Hard</span>
                    </div>
                </div>

                <div class="stat-card favorites" id="statFavorites">
                    <div class="stat-card-icon"><i class="fa-solid fa-star"></i></div>
                    <div class="stat-card-info">
                        <span class="stat-card-value" id="favoritesCount">
                            ${not empty favoritesCount ? favoritesCount : 'â€“'}
                        </span>
                        <span class="stat-card-label">Favorites</span>
                    </div>
                </div>

                <div class="stat-card topics" id="statTopics">
                    <div class="stat-card-icon"><i class="fa-solid fa-tags"></i></div>
                    <div class="stat-card-info">
                        <span class="stat-card-value" id="topicsCount">
                            ${not empty topicsCount ? topicsCount : 'â€“'}
                        </span>
                        <span class="stat-card-label">Topics Covered</span>
                    </div>
                </div>
            </div>

            <!-- â”€â”€ Charts Row â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ -->
            <div class="charts-row">
                <div class="chart-card" id="difficultyChartCard">
                    <div class="chart-card-header">
                        <h3>Difficulty Breakdown</h3>
                        <span class="chart-subtitle">Easy / Medium / Hard</span>
                    </div>
                    <div class="chart-wrapper">
                        <canvas id="difficultyChart"></canvas>
                    </div>
                </div>

                <div class="chart-card" id="platformChartCard">
                    <div class="chart-card-header">
                        <h3>By Platform</h3>
                        <span class="chart-subtitle">Questions per platform</span>
                    </div>
                    <div class="chart-wrapper">
                        <canvas id="platformChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- â”€â”€ Recent Questions Table â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ -->
            <div class="table-card" id="recentQuestionsCard">
                <div class="table-card-header">
                    <h3>Recent Questions</h3>
                    <a href="questions.jsp" class="btn btn-ghost btn-sm">View All</a>
                </div>
                <div class="table-wrapper">
                    <table class="questions-table" id="recentQuestionsTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Platform</th>
                                <th>Topic</th>
                                <th>Difficulty</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- TODO: Populate with recentQuestions list from DashboardServlet --%>
                            <tr>
                                <td colspan="7" class="table-empty">
                                    <i class="fa-solid fa-inbox"></i>
                                    <p>No questions yet. <a href="add-question.jsp">Add your first one!</a></p>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>
    </div>

    <!-- Include Loader -->
    <%@ include file="../components/loader.jsp" %>

    <!-- Scripts -->
    <script src="js/app.js"></script>
    <script src="js/dashboard.js"></script>
    <script src="js/chart.js"></script>
    <script src="js/theme.js"></script>
</body>
</html>

