<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="CodeTrack – Track your DSA practice across LeetCode, GeeksforGeeks, and Codeforces in one place."/>
    <meta name="keywords"    content="DSA, LeetCode, GeeksforGeeks, Codeforces, coding tracker, algorithm practice"/>
    <meta name="author"      content="Sarthak Bohra"/>

    <title>CodeTrack – DSA Progress Tracker</title>

    <!-- Favicon -->
    <link rel="icon" type="image/png" href="images/logo/favicon.png"/>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet"/>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <!-- App Stylesheets -->
    <link rel="stylesheet" href="css/variables.css"/>
    <link rel="stylesheet" href="css/global.css"/>
    <link rel="stylesheet" href="css/animations.css"/>
</head>
<body class="landing-page">

    <!-- ── Navigation ─────────────────────────────────────────── -->
    <nav class="landing-nav" id="landingNav">
        <div class="nav-container">
            <a href="index.jsp" class="nav-logo" id="navLogo">
                <i class="fa-solid fa-code"></i>
                <span>Code<strong>Track</strong></span>
            </a>
            <div class="nav-links" id="navLinks">
                <a href="#features" class="nav-link">Features</a>
                <a href="#tech"     class="nav-link">Tech Stack</a>
                <a href="#about"    class="nav-link">About</a>
                <a href="login.jsp"    class="btn btn-outline">Login</a>
                <a href="register.jsp" class="btn btn-primary">Get Started</a>
            </div>
            <button class="hamburger" id="hamburgerBtn" aria-label="Toggle navigation">
                <i class="fa-solid fa-bars"></i>
            </button>
        </div>
    </nav>

    <!-- ── Hero Section ───────────────────────────────────────── -->
    <section class="hero" id="hero">
        <div class="hero-content">
            <div class="hero-badge">
                <i class="fa-solid fa-star"></i> Your Personal DSA Journal
            </div>
            <h1 class="hero-title">
                Track Your DSA Journey<br/>
                <span class="gradient-text">One Problem at a Time</span>
            </h1>
            <p class="hero-subtitle">
                Organize your solved problems from LeetCode, GeeksforGeeks & Codeforces.
                Visualize your progress. Never lose track of what you've learned.
            </p>
            <div class="hero-cta">
                <a href="register.jsp" class="btn btn-primary btn-lg" id="heroGetStarted">
                    <i class="fa-solid fa-rocket"></i> Start Tracking Free
                </a>
                <a href="#features" class="btn btn-ghost btn-lg">
                    <i class="fa-solid fa-play"></i> See Features
                </a>
            </div>
            <div class="hero-stats">
                <div class="stat-item">
                    <strong>3+</strong>
                    <span>Platforms</span>
                </div>
                <div class="stat-divider"></div>
                <div class="stat-item">
                    <strong>20+</strong>
                    <span>DSA Topics</span>
                </div>
                <div class="stat-divider"></div>
                <div class="stat-item">
                    <strong>∞</strong>
                    <span>Questions</span>
                </div>
            </div>
        </div>
        <div class="hero-visual">
            <div class="dashboard-preview">
                <!-- Decorative fake dashboard card -->
                <div class="preview-card">
                    <div class="preview-header">
                        <span class="preview-dot red"></span>
                        <span class="preview-dot yellow"></span>
                        <span class="preview-dot green"></span>
                        <span class="preview-title">My Progress</span>
                    </div>
                    <div class="preview-stats">
                        <div class="preview-stat easy">
                            <span class="ps-num">47</span>
                            <span class="ps-label">Easy</span>
                        </div>
                        <div class="preview-stat medium">
                            <span class="ps-num">89</span>
                            <span class="ps-label">Medium</span>
                        </div>
                        <div class="preview-stat hard">
                            <span class="ps-num">23</span>
                            <span class="ps-label">Hard</span>
                        </div>
                    </div>
                    <div class="preview-bar">
                        <div class="preview-bar-fill" style="width: 72%"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ── Features Section ───────────────────────────────────── -->
    <section class="features-section" id="features">
        <div class="section-container">
            <div class="section-header">
                <h2>Everything You Need to <span class="gradient-text">Stay Consistent</span></h2>
                <p>Built for serious programmers who want to turn practice into progress.</p>
            </div>
            <div class="features-grid">
                <div class="feature-card" id="featureTrack">
                    <div class="feature-icon"><i class="fa-solid fa-check-circle"></i></div>
                    <h3>Track Questions</h3>
                    <p>Log every solved problem with platform, topic, difficulty, and URL.</p>
                </div>
                <div class="feature-card" id="featureAnalytics">
                    <div class="feature-icon"><i class="fa-solid fa-chart-pie"></i></div>
                    <h3>Visual Analytics</h3>
                    <p>See charts showing your difficulty breakdown and topic coverage at a glance.</p>
                </div>
                <div class="feature-card" id="featureSearch">
                    <div class="feature-icon"><i class="fa-solid fa-magnifying-glass"></i></div>
                    <h3>Search & Filter</h3>
                    <p>Instantly find any problem by name, platform, topic, or difficulty.</p>
                </div>
                <div class="feature-card" id="featureNotes">
                    <div class="feature-icon"><i class="fa-solid fa-note-sticky"></i></div>
                    <h3>Smart Notes</h3>
                    <p>Store key insights and approach notes directly alongside each problem.</p>
                </div>
                <div class="feature-card" id="featureFavorites">
                    <div class="feature-icon"><i class="fa-solid fa-star"></i></div>
                    <h3>Favorites</h3>
                    <p>Bookmark important problems for quick revision before interviews.</p>
                </div>
                <div class="feature-card" id="featureMultiPlatform">
                    <div class="feature-icon"><i class="fa-solid fa-layer-group"></i></div>
                    <h3>Multi-Platform</h3>
                    <p>Supports LeetCode, GeeksforGeeks, Codeforces, HackerRank, and more.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ── Footer ─────────────────────────────────────────────── -->
    <footer class="landing-footer">
        <div class="footer-content">
            <div class="footer-logo">
                <i class="fa-solid fa-code"></i>
                <span>Code<strong>Track</strong></span>
            </div>
            <p class="footer-text">
                Built with ❤️ by
                <a href="https://github.com/sarthakbohra27" target="_blank" rel="noopener">Sarthak Bohra</a>
            </p>
            <div class="footer-links">
                <a href="https://github.com/sarthakbohra27/CodeTrack" target="_blank" rel="noopener">
                    <i class="fa-brands fa-github"></i> GitHub
                </a>
                <a href="LICENSE">MIT License</a>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="js/app.js"></script>
</body>
</html>
