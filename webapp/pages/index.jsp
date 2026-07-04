<%-- ============================================================
     CodeTrack – Landing Page (index.jsp)
     Phase 2 – Step 4
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    request.setAttribute("activePage", "home");
    request.setAttribute("isLoggedIn", false);
%><!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">

  <!-- ── SEO ─────────────────────────────────────────────── -->
  <title>CodeTrack – DSA Progress Tracker | Master Your Coding Journey</title>
  <meta name="description"
        content="CodeTrack is a modern SaaS dashboard for tracking your DSA practice across LeetCode, GeeksforGeeks, Codeforces and more. Organize questions, analyze progress, and become placement-ready.">
  <meta name="keywords"
        content="DSA tracker, LeetCode tracker, coding practice, GeeksforGeeks, data structures, algorithms, placement preparation, coding dashboard">
  <meta name="author" content="Sarthak Bohra">
  <meta name="robots" content="index, follow">
  <link rel="canonical" href="https://codetrack.app/">

  <!-- ── Open Graph ──────────────────────────────────────── -->
  <meta property="og:type"        content="website">
  <meta property="og:site_name"   content="CodeTrack">
  <meta property="og:title"       content="CodeTrack – Master Your Coding Journey">
  <meta property="og:description" content="Track your DSA practice, analyze your progress, and become placement-ready—all from one powerful dashboard.">
  <meta property="og:url"         content="https://codetrack.app/">
  <meta property="og:image"       content="<%= ctx %>/assets/images/logo-dark.png">

  <!-- ── Twitter Card ────────────────────────────────────── -->
  <meta name="twitter:card"        content="summary_large_image">
  <meta name="twitter:title"       content="CodeTrack – DSA Progress Tracker">
  <meta name="twitter:description" content="Track DSA practice, analyze progress, and become placement-ready.">
  <meta name="twitter:image"       content="<%= ctx %>/assets/images/logo-dark.png">

  <!-- ── Favicon ─────────────────────────────────────────── -->
  <link rel="icon"             type="image/svg+xml" href="<%= ctx %>/assets/images/icon.svg">
  <link rel="icon"             type="image/png"     href="<%= ctx %>/assets/images/icon-512.png">
  <link rel="apple-touch-icon"                      href="<%= ctx %>/assets/images/icon-512.png">

  <!-- ── Fonts ───────────────────────────────────────────── -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">

  <!-- ── Font Awesome ────────────────────────────────────── -->
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
        integrity="sha512-Avb2QiuDEEvB4bZJYdab3bGvVblMzfv0L+07ckOzaJjCXnMZiMjzOWbXFdpPbMQaWxX2deMFB3I2pnYS+qow=="
        crossorigin="anonymous" referrerpolicy="no-referrer">

  <!-- ── Design System CSS (base) ─────────────────────────── -->
  <link rel="stylesheet" href="<%= ctx %>/assets/css/base/variables.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/base/global.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/base/utilities.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/base/animations.css">
  <!-- ── Layout ─────────────────────────────────────────── -->
  <link rel="stylesheet" href="<%= ctx %>/assets/css/layout/navbar.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/layout/footer.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/layout/responsive.css">
  <!-- ── Components ─────────────────────────────────────── -->
  <link rel="stylesheet" href="<%= ctx %>/assets/css/components/buttons.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/components/cards.css">
  <link rel="stylesheet" href="<%= ctx %>/assets/css/components/components.css">
  <!-- ── Page ───────────────────────────────────────────── -->
  <link rel="stylesheet" href="<%= ctx %>/assets/css/pages/landing.css">

  <!-- Prevent FOWT – apply theme before paint -->
  <script>
    (function(){var t=localStorage.getItem('codetrack-theme');if(!t){t=window.matchMedia('(prefers-color-scheme:light)').matches?'light':'dark';}document.documentElement.setAttribute('data-theme',t);})();
  </script>
</head>

<body>

<!-- ════════════════════════════════════════════════════════════
     PAGE LOADER
     ════════════════════════════════════════════════════════════ -->
<%@ include file="../components/common/loader.jsp" %>

<!-- ════════════════════════════════════════════════════════════
     NAVBAR
     ════════════════════════════════════════════════════════════ -->
<%@ include file="../components/layout/navbar.jsp" %>

<!-- ════════════════════════════════════════════════════════════
     TOAST CONTAINER
     ════════════════════════════════════════════════════════════ -->
<%@ include file="../components/common/toast.jsp" %>

<!-- ════════════════════════════════════════════════════════════
     MAIN CONTENT
     ════════════════════════════════════════════════════════════ -->
<main>

  <!-- ══════════════════════════════════════════════════════════
       1. HERO SECTION
       ══════════════════════════════════════════════════════════ -->
  <section class="hero-section" id="hero" aria-label="Hero">
    <div class="container">
      <div class="hero-inner">

        <!-- Left Column -->
        <div class="hero-content">
          <div class="hero-badge" aria-label="Status">
            <span class="hero-badge-dot" aria-hidden="true"></span>
            Now in Public Beta — Free Forever
          </div>

          <h1 class="hero-headline">
            Master Your<br>
            <span class="gradient-text">Coding Journey.</span>
          </h1>

          <p class="hero-subheadline">
            Track your DSA practice, analyze your progress, organize your notes, and
            become placement-ready — all from one powerful dashboard.
          </p>

          <div class="hero-cta">
            <a href="<%= ctx %>/pages/register.jsp" class="btn btn-primary btn-lg" id="hero-cta-start">
              <i class="fa-solid fa-rocket" aria-hidden="true"></i>
              Start Tracking Free
            </a>
            <a href="#features" class="btn btn-secondary btn-lg" id="hero-cta-features">
              <i class="fa-solid fa-compass" aria-hidden="true"></i>
              Explore Features
            </a>
          </div>

          <div class="hero-trust" aria-label="Social proof">
            <div class="hero-avatars" aria-hidden="true">
              <div class="avatar-chip">A</div>
              <div class="avatar-chip">R</div>
              <div class="avatar-chip">S</div>
              <div class="avatar-chip">K</div>
            </div>
            <span>Trusted by <strong>500+</strong> students across India</span>
          </div>
        </div>

        <!-- Right Column: Dashboard Illustration -->
        <div class="hero-visual" aria-hidden="true">

          <div class="hero-visual-glow"></div>

          <!-- Main dashboard card -->
          <div class="dash-mock">

            <!-- Browser chrome bar -->
            <div class="dash-topbar">
              <div class="dash-topbar-dots">
                <div class="dash-dot red"></div>
                <div class="dash-dot yellow"></div>
                <div class="dash-dot green"></div>
              </div>
              <div class="dash-topbar-tabs">
                <span>Questions</span>
                <span class="tab-active">Dashboard</span>
                <span>Analytics</span>
              </div>
              <div class="dash-topbar-avatar">S</div>
            </div>

            <!-- Dashboard body -->
            <div class="dash-body">

              <!-- Mini sidebar -->
              <div class="dash-mini-sidebar">
                <div class="dash-mini-nav active" title="Dashboard">
                  <i class="fa-solid fa-gauge"></i>
                </div>
                <div class="dash-mini-nav" title="Questions">
                  <i class="fa-solid fa-list-check"></i>
                </div>
                <div class="dash-mini-nav" title="Analytics">
                  <i class="fa-solid fa-chart-line"></i>
                </div>
                <div class="dash-mini-nav" title="Profile">
                  <i class="fa-solid fa-circle-user"></i>
                </div>
              </div>

              <!-- Content area -->
              <div class="dash-content">
                <div class="dash-page-title">
                  <i class="fa-solid fa-gauge" style="color:var(--color-primary);margin-right:4px;"></i>
                  Dashboard
                </div>

                <!-- Stat cards -->
                <div class="dash-stat-row">
                  <div class="dash-stat-mini primary">
                    <div class="dash-stat-mini-val">248</div>
                    <div class="dash-stat-mini-label">Solved</div>
                  </div>
                  <div class="dash-stat-mini success">
                    <div class="dash-stat-mini-val">78</div>
                    <div class="dash-stat-mini-label">Easy</div>
                  </div>
                  <div class="dash-stat-mini warning">
                    <div class="dash-stat-mini-val">42</div>
                    <div class="dash-stat-mini-label">Medium</div>
                  </div>
                  <div class="dash-stat-mini danger">
                    <div class="dash-stat-mini-val">12</div>
                    <div class="dash-stat-mini-label">Hard</div>
                  </div>
                </div>

                <!-- Charts row -->
                <div class="dash-panels">

                  <!-- Progress ring -->
                  <div class="dash-ring-card">
                    <div class="dash-ring-label">Progress</div>
                    <div class="dash-ring-wrap">
                      <div class="dash-ring"></div>
                    </div>
                    <div class="dash-ring-legend">
                      <div class="ring-legend-item">
                        <div class="ring-legend-dot" style="background:var(--color-success);"></div>
                        Easy (78)
                      </div>
                      <div class="ring-legend-item">
                        <div class="ring-legend-dot" style="background:var(--color-warning);"></div>
                        Med (42)
                      </div>
                      <div class="ring-legend-item">
                        <div class="ring-legend-dot" style="background:var(--color-danger);"></div>
                        Hard (12)
                      </div>
                    </div>
                  </div>

                  <!-- Recent activity -->
                  <div class="dash-activity-card">
                    <div class="dash-act-header">Recent Activity</div>
                    <div class="dash-act-row">
                      <div class="dash-act-dot"></div>
                      <span class="dash-act-name">Two Sum</span>
                      <span class="dash-act-badge easy">Easy</span>
                    </div>
                    <div class="dash-act-row">
                      <div class="dash-act-dot"></div>
                      <span class="dash-act-name">Binary Search</span>
                      <span class="dash-act-badge easy">Easy</span>
                    </div>
                    <div class="dash-act-row">
                      <div class="dash-act-dot"></div>
                      <span class="dash-act-name">Merge Sort</span>
                      <span class="dash-act-badge med">Med</span>
                    </div>
                    <div class="dash-act-row">
                      <div class="dash-act-dot unsolved"></div>
                      <span class="dash-act-name">Dijkstra's</span>
                      <span class="dash-act-badge hard">Hard</span>
                    </div>
                    <div class="dash-act-row">
                      <div class="dash-act-dot unsolved"></div>
                      <span class="dash-act-name">LRU Cache</span>
                      <span class="dash-act-badge hard">Hard</span>
                    </div>
                  </div>
                </div>

                <!-- Mini bar chart -->
                <div class="dash-chart-strip" title="Weekly Progress">
                  <div class="dash-bar" style="height:55%;"></div>
                  <div class="dash-bar" style="height:75%;"></div>
                  <div class="dash-bar" style="height:40%;"></div>
                  <div class="dash-bar" style="height:90%;"></div>
                  <div class="dash-bar" style="height:65%;"></div>
                  <div class="dash-bar" style="height:50%;"></div>
                  <div class="dash-bar" style="height:85%;"></div>
                </div>

              </div>
            </div>
          </div>

          <!-- Floating badges -->
          <div class="hero-float-badge float-b1" style="background:var(--color-surface);">
            <i class="fa-solid fa-fire" style="color:#F59E0B;"></i>
            7-Day Streak
          </div>
          <div class="hero-float-badge float-b2">
            <i class="fa-solid fa-circle-check" style="color:var(--color-success);"></i>
            +12 Today
          </div>
          <div class="hero-float-badge float-b3">
            <i class="fa-brands fa-github" style="color:var(--color-text-muted);"></i>
            LeetCode Synced
          </div>
        </div>
        <!-- /hero-visual -->

      </div>
    </div>
  </section>

  <!-- ══════════════════════════════════════════════════════════
       2. TRUSTED PLATFORMS
       ══════════════════════════════════════════════════════════ -->
  <section class="platforms-section" aria-label="Supported coding platforms">
    <div class="container">
      <p class="platforms-label">Sync questions from your favorite platforms</p>
    </div>
    <div class="platforms-track-wrap">
      <div class="platforms-track" id="platforms-track">
        <!-- Original items — JS will duplicate for infinite scroll -->
        <div class="platform-card">
          <div class="platform-icon lc">LC</div>
          <div>
            <div class="platform-name">LeetCode</div>
            <div class="platform-count">3,000+ problems</div>
          </div>
        </div>
        <div class="platform-card">
          <div class="platform-icon gfg"><i class="fa-solid fa-g"></i></div>
          <div>
            <div class="platform-name">GeeksforGeeks</div>
            <div class="platform-count">2,500+ articles</div>
          </div>
        </div>
        <div class="platform-card">
          <div class="platform-icon cf">CF</div>
          <div>
            <div class="platform-name">Codeforces</div>
            <div class="platform-count">5,000+ contests</div>
          </div>
        </div>
        <div class="platform-card">
          <div class="platform-icon hr"><i class="fa-solid fa-h"></i></div>
          <div>
            <div class="platform-name">HackerRank</div>
            <div class="platform-count">1,500+ challenges</div>
          </div>
        </div>
        <div class="platform-card">
          <div class="platform-icon cn">CN</div>
          <div>
            <div class="platform-name">Coding Ninjas</div>
            <div class="platform-count">1,000+ courses</div>
          </div>
        </div>
        <div class="platform-card">
          <div class="platform-icon" style="background:rgba(100,116,139,0.15);color:var(--color-text-muted);">
            <i class="fa-solid fa-plus"></i>
          </div>
          <div>
            <div class="platform-name">Custom Platform</div>
            <div class="platform-count">Add your own</div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ══════════════════════════════════════════════════════════
       3. FEATURES SECTION
       ══════════════════════════════════════════════════════════ -->
  <section class="features-section section" id="features" aria-labelledby="features-title">
    <div class="container">
      <div class="section-center">
        <div class="section-tag" aria-hidden="true">
          <i class="fa-solid fa-star fa-xs"></i>
          Features
        </div>
        <h2 class="section-heading" id="features-title">
          Everything You Need to<br><span class="gradient-text">Level Up</span>
        </h2>
        <p class="section-subheading">
          Built for serious DSA learners. Every feature is designed to
          maximize your study efficiency and give you deep insights into your progress.
        </p>
      </div>

      <div class="features-grid">

        <!-- 1 -->
        <article class="feature-card reveal" aria-labelledby="feat-1">
          <div class="feature-icon" aria-hidden="true">
            <i class="fa-solid fa-list-check"></i>
          </div>
          <h3 class="feature-title" id="feat-1">Track Questions</h3>
          <p class="feature-desc">
            Log every question you solve with difficulty, platform, topic, and status.
            Never forget what you've practiced.
          </p>
          <span class="feature-link" aria-hidden="true">
            Learn more <i class="fa-solid fa-arrow-right fa-xs"></i>
          </span>
        </article>

        <!-- 2 -->
        <article class="feature-card reveal reveal-delay-1" aria-labelledby="feat-2">
          <div class="feature-icon" aria-hidden="true">
            <i class="fa-solid fa-chart-pie"></i>
          </div>
          <h3 class="feature-title" id="feat-2">Topic Analytics</h3>
          <p class="feature-desc">
            Visualize your weak areas with beautiful charts. Know exactly which
            topics need more practice.
          </p>
          <span class="feature-link" aria-hidden="true">
            Learn more <i class="fa-solid fa-arrow-right fa-xs"></i>
          </span>
        </article>

        <!-- 3 -->
        <article class="feature-card reveal reveal-delay-2" aria-labelledby="feat-3">
          <div class="feature-icon" aria-hidden="true">
            <i class="fa-solid fa-magnifying-glass"></i>
          </div>
          <h3 class="feature-title" id="feat-3">Smart Search</h3>
          <p class="feature-desc">
            Instantly find any question by name, topic, or difficulty. Filter
            by platform, status, or date — in milliseconds.
          </p>
          <span class="feature-link" aria-hidden="true">
            Learn more <i class="fa-solid fa-arrow-right fa-xs"></i>
          </span>
        </article>

        <!-- 4 -->
        <article class="feature-card reveal reveal-delay-3" aria-labelledby="feat-4">
          <div class="feature-icon" aria-hidden="true">
            <i class="fa-solid fa-gauge"></i>
          </div>
          <h3 class="feature-title" id="feat-4">Progress Dashboard</h3>
          <p class="feature-desc">
            A real-time dashboard with streak tracking, weekly heatmaps, and
            trend analysis — inspired by GitHub's contribution graph.
          </p>
          <span class="feature-link" aria-hidden="true">
            Learn more <i class="fa-solid fa-arrow-right fa-xs"></i>
          </span>
        </article>

        <!-- 5 -->
        <article class="feature-card reveal reveal-delay-4" aria-labelledby="feat-5">
          <div class="feature-icon" aria-hidden="true">
            <i class="fa-solid fa-note-sticky"></i>
          </div>
          <h3 class="feature-title" id="feat-5">Personal Notes</h3>
          <p class="feature-desc">
            Attach rich notes, approaches, and complexity analysis to each
            question. Your personal DSA notebook — always organized.
          </p>
          <span class="feature-link" aria-hidden="true">
            Learn more <i class="fa-solid fa-arrow-right fa-xs"></i>
          </span>
        </article>

        <!-- 6 -->
        <article class="feature-card reveal reveal-delay-5" aria-labelledby="feat-6">
          <div class="feature-icon" aria-hidden="true">
            <i class="fa-solid fa-moon"></i>
          </div>
          <h3 class="feature-title" id="feat-6">Theme Customization</h3>
          <p class="feature-desc">
            Switch between beautiful dark and light themes. Your eyes,
            your preference — CodeTrack adapts to you.
          </p>
          <span class="feature-link" aria-hidden="true">
            Learn more <i class="fa-solid fa-arrow-right fa-xs"></i>
          </span>
        </article>

      </div>
    </div>
  </section>

  <!-- ══════════════════════════════════════════════════════════
       4. HOW IT WORKS
       ══════════════════════════════════════════════════════════ -->
  <section class="steps-section section" id="how-it-works" aria-labelledby="steps-title">
    <div class="container">
      <div class="section-center">
        <div class="section-tag">
          <i class="fa-solid fa-route fa-xs"></i>
          How It Works
        </div>
        <h2 class="section-heading" id="steps-title">
          Start in <span class="gradient-text">3 Simple Steps</span>
        </h2>
        <p class="section-subheading">
          No setup hassle. Create an account, start logging, and watch your
          progress insights build automatically.
        </p>
      </div>

      <div class="steps-grid" role="list">

        <div class="step-item reveal" role="listitem">
          <div class="step-number" aria-hidden="true">1</div>
          <div class="step-icon" aria-hidden="true" style="display:none;">
            <i class="fa-solid fa-user-plus"></i>
          </div>
          <h3 class="step-title">Create Account</h3>
          <p class="step-desc">
            Sign up for free in under 30 seconds. No credit card required.
            Your personal DSA vault is ready instantly.
          </p>
        </div>

        <div class="step-item reveal reveal-delay-2" role="listitem">
          <div class="step-number" aria-hidden="true">2</div>
          <h3 class="step-title">Track Every Question</h3>
          <p class="step-desc">
            Log questions from LeetCode, GFG, Codeforces and more.
            Add notes, tags, difficulty, and status in seconds.
          </p>
        </div>

        <div class="step-item reveal reveal-delay-4" role="listitem">
          <div class="step-number" aria-hidden="true">3</div>
          <h3 class="step-title">Analyze Progress</h3>
          <p class="step-desc">
            View beautiful analytics, spot weak topics, track streaks,
            and measure your placement readiness — visually.
          </p>
        </div>

      </div>
    </div>
  </section>

  <!-- ══════════════════════════════════════════════════════════
       5. DASHBOARD PREVIEW (Full CSS Mock)
       ══════════════════════════════════════════════════════════ -->
  <section class="preview-section section" id="preview" aria-labelledby="preview-title">
    <div class="container">
      <div class="section-center">
        <div class="section-tag">
          <i class="fa-solid fa-desktop fa-xs"></i>
          Live Preview
        </div>
        <h2 class="section-heading" id="preview-title">
          See CodeTrack in <span class="gradient-text">Action</span>
        </h2>
        <p class="section-subheading">
          A fully featured dashboard that gives you clarity on your DSA journey.
          Everything in one place.
        </p>
      </div>

      <div class="preview-wrap reveal" aria-label="Dashboard preview illustration" aria-hidden="true">

        <!-- Browser chrome bar -->
        <div class="preview-chrome">
          <div class="chrome-dots">
            <div class="chrome-dot r"></div>
            <div class="chrome-dot y"></div>
            <div class="chrome-dot g"></div>
          </div>
          <div class="chrome-url">app.codetrack.io/dashboard</div>
        </div>

        <!-- App layout -->
        <div class="preview-app">

          <!-- Sidebar -->
          <nav class="preview-sidebar" aria-label="Preview sidebar">
            <div class="preview-sidebar-logo">
              <div class="preview-sidebar-logo-icon">&lt;/&gt;</div>
              <span class="preview-sidebar-logo-text">CodeTrack</span>
            </div>
            <div class="preview-nav-item active">
              <i class="fa-solid fa-gauge"></i> Dashboard
            </div>
            <div class="preview-nav-item">
              <i class="fa-solid fa-list-check"></i> Questions
            </div>
            <div class="preview-nav-item">
              <i class="fa-solid fa-chart-line"></i> Analytics
            </div>
            <div class="preview-nav-item">
              <i class="fa-solid fa-circle-user"></i> Profile
            </div>
            <div class="preview-nav-item">
              <i class="fa-solid fa-gear"></i> Settings
            </div>
          </nav>

          <!-- Main content -->
          <div class="preview-main">

            <!-- App navbar -->
            <div class="preview-appnav">
              <span class="preview-appnav-title">Dashboard</span>
              <div class="preview-appnav-actions">
                <button class="preview-mini-btn secondary">
                  <i class="fa-solid fa-magnifying-glass"></i> Search
                </button>
                <button class="preview-mini-btn primary">
                  <i class="fa-solid fa-plus"></i> Add Question
                </button>
              </div>
            </div>

            <!-- Content -->
            <div class="preview-content">

              <!-- Stat cards -->
              <div class="preview-stats">
                <div class="preview-stat">
                  <div class="preview-stat-icon" style="background:var(--color-primary-light);color:var(--color-primary);">
                    <i class="fa-solid fa-list-check"></i>
                  </div>
                  <div class="preview-stat-val">248</div>
                  <div class="preview-stat-label">Total Solved</div>
                  <div class="preview-stat-trend">↑ +12 this week</div>
                </div>
                <div class="preview-stat">
                  <div class="preview-stat-icon" style="background:var(--color-success-light);color:var(--color-success);">
                    <i class="fa-solid fa-circle-check"></i>
                  </div>
                  <div class="preview-stat-val">78</div>
                  <div class="preview-stat-label">Easy Solved</div>
                  <div class="preview-stat-trend" style="color:var(--color-text-muted);">All time</div>
                </div>
                <div class="preview-stat">
                  <div class="preview-stat-icon" style="background:var(--color-warning-light);color:var(--color-warning);">
                    <i class="fa-solid fa-fire"></i>
                  </div>
                  <div class="preview-stat-val">7</div>
                  <div class="preview-stat-label">Day Streak</div>
                  <div class="preview-stat-trend">🔥 Keep it up!</div>
                </div>
                <div class="preview-stat">
                  <div class="preview-stat-icon" style="background:rgba(139,92,246,0.12);color:#8B5CF6;">
                    <i class="fa-solid fa-bullseye"></i>
                  </div>
                  <div class="preview-stat-val">89%</div>
                  <div class="preview-stat-label">Accuracy Rate</div>
                  <div class="preview-stat-trend">↑ Top 15%</div>
                </div>
              </div>

              <!-- Question table -->
              <div class="preview-table-wrap">
                <div class="preview-table-header">
                  <span class="preview-table-title">Recent Questions</span>
                  <button class="preview-mini-btn secondary">View All</button>
                </div>
                <div class="preview-table-body">
                  <div class="preview-table-row th">
                    <span>Question</span>
                    <span>Difficulty</span>
                    <span>Platform</span>
                    <span>Topic</span>
                    <span>Status</span>
                  </div>
                  <div class="preview-table-row">
                    <span class="q-name">Two Sum</span>
                    <span><span class="mini-badge easy">Easy</span></span>
                    <span>LeetCode</span>
                    <span>Arrays</span>
                    <span><span class="mini-badge solved">Solved</span></span>
                  </div>
                  <div class="preview-table-row">
                    <span class="q-name">Longest Substring</span>
                    <span><span class="mini-badge med">Medium</span></span>
                    <span>LeetCode</span>
                    <span>Sliding Window</span>
                    <span><span class="mini-badge solved">Solved</span></span>
                  </div>
                  <div class="preview-table-row">
                    <span class="q-name">Merge Sort</span>
                    <span><span class="mini-badge med">Medium</span></span>
                    <span>GFG</span>
                    <span>Sorting</span>
                    <span><span class="mini-badge solved">Solved</span></span>
                  </div>
                  <div class="preview-table-row">
                    <span class="q-name">Dijkstra's Algorithm</span>
                    <span><span class="mini-badge hard">Hard</span></span>
                    <span>Codeforces</span>
                    <span>Graphs</span>
                    <span style="font-size:10px;color:var(--color-warning);">In Progress</span>
                  </div>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ══════════════════════════════════════════════════════════
       6. WHY CODETRACK — COMPARISON TABLE
       ══════════════════════════════════════════════════════════ -->
  <section class="comparison-section section" id="comparison" aria-labelledby="comparison-title">
    <div class="container">
      <div class="section-center">
        <div class="section-tag">
          <i class="fa-solid fa-trophy fa-xs"></i>
          Why CodeTrack
        </div>
        <h2 class="section-heading" id="comparison-title">
          Stop Using <span class="gradient-text">Spreadsheets.</span>
        </h2>
        <p class="section-subheading">
          Traditional methods are scattered and slow. CodeTrack gives you a
          structured, intelligent, and beautiful alternative.
        </p>
      </div>

      <div class="comparison-wrap reveal">
        <table class="ct-table" role="grid" aria-label="Feature comparison table">
          <thead>
            <tr>
              <th class="feature-col" scope="col">Feature</th>
              <th scope="col">📓 Notebook</th>
              <th scope="col">📊 Spreadsheet</th>
              <th class="ct-col" scope="col">⚡ CodeTrack</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="feature-col">Organized Dashboard</td>
              <td><span class="check-no">✕</span></td>
              <td><span class="check-no">✕</span></td>
              <td><span class="check-yes">✓</span></td>
            </tr>
            <tr>
              <td class="feature-col">Topic Analytics</td>
              <td><span class="check-no">✕</span></td>
              <td><span class="check-no">✕</span></td>
              <td><span class="check-yes">✓</span></td>
            </tr>
            <tr>
              <td class="feature-col">Smart Search & Filter</td>
              <td><span class="check-no">✕</span></td>
              <td><span class="check-no">✕</span></td>
              <td><span class="check-yes">✓</span></td>
            </tr>
            <tr>
              <td class="feature-col">Progress Tracking</td>
              <td><span class="check-no">✕</span></td>
              <td><span style="color:var(--color-warning);">~</span></td>
              <td><span class="check-yes">✓</span></td>
            </tr>
            <tr>
              <td class="feature-col">Streak & Motivation</td>
              <td><span class="check-no">✕</span></td>
              <td><span class="check-no">✕</span></td>
              <td><span class="check-yes">✓</span></td>
            </tr>
            <tr>
              <td class="feature-col">Dark / Light Theme</td>
              <td><span class="check-no">✕</span></td>
              <td><span class="check-no">✕</span></td>
              <td><span class="check-yes">✓</span></td>
            </tr>
            <tr>
              <td class="feature-col">Mobile Responsive</td>
              <td><span class="check-no">✕</span></td>
              <td><span class="check-no">✕</span></td>
              <td><span class="check-yes">✓</span></td>
            </tr>
            <tr>
              <td class="feature-col">Personal Notes</td>
              <td><span style="color:var(--color-warning);">~</span></td>
              <td><span style="color:var(--color-warning);">~</span></td>
              <td><span class="check-yes">✓</span></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </section>

  <!-- ══════════════════════════════════════════════════════════
       7. STATISTICS / COUNTERS
       ══════════════════════════════════════════════════════════ -->
  <section class="stats-section section" id="stats" aria-labelledby="stats-title">
    <div class="container">
      <h2 class="sr-only" id="stats-title">CodeTrack in Numbers</h2>
      <div class="stats-grid">

        <div class="stat-item-outer">
          <div class="stat-counter" aria-label="10,000+ questions tracked">
            <span class="count-num" data-target="10000" data-suffix="+" data-duration="2200">0</span>
          </div>
          <div class="stat-label">Questions Tracked</div>
        </div>

        <div class="stat-item-outer" style="border-left:1px solid rgba(255,255,255,0.08);">
          <div class="stat-counter" aria-label="250+ topics">
            <span class="count-num" data-target="250" data-suffix="+" data-duration="1800">0</span>
          </div>
          <div class="stat-label">DSA Topics Covered</div>
        </div>

        <div class="stat-item-outer" style="border-left:1px solid rgba(255,255,255,0.08);">
          <div class="stat-counter" aria-label="95% placement readiness">
            <span class="count-num" data-target="95" data-suffix="%" data-duration="1600">0</span>
          </div>
          <div class="stat-label">Placement Readiness</div>
        </div>

        <div class="stat-item-outer" style="border-left:1px solid rgba(255,255,255,0.08);">
          <div class="stat-counter" aria-label="100% free">
            <span class="count-num" data-target="100" data-suffix="%" data-duration="1400">0</span>
          </div>
          <div class="stat-label">Completely Free</div>
        </div>

      </div>
    </div>
  </section>

  <!-- ══════════════════════════════════════════════════════════
       8. TESTIMONIALS
       ══════════════════════════════════════════════════════════ -->
  <section class="testimonials-section section" id="testimonials" aria-labelledby="testimonials-title">
    <div class="container">
      <div class="section-center">
        <div class="section-tag">
          <i class="fa-solid fa-heart fa-xs"></i>
          Testimonials
        </div>
        <h2 class="section-heading" id="testimonials-title">
          Loved by <span class="gradient-text">Developers</span>
        </h2>
        <p class="section-subheading">
          Real students. Real results. See how CodeTrack is helping the next
          generation of developers crack their dream placements.
        </p>
      </div>

      <div class="testimonials-grid">

        <article class="testimonial-card reveal" aria-label="Testimonial from Arjun Sharma">
          <div class="testimonial-stars" aria-label="5 out of 5 stars">
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
          </div>
          <p class="testimonial-text">
            CodeTrack completely changed how I approach DSA preparation. I can
            finally see my weak topics clearly and fix them. Got placed at Amazon
            in 3 months of consistent tracking!
          </p>
          <div class="testimonial-author">
            <div class="testimonial-avatar a1" aria-hidden="true">A</div>
            <div>
              <div class="testimonial-name">Arjun Sharma</div>
              <div class="testimonial-role">SDE at Amazon · IIT Delhi</div>
            </div>
          </div>
        </article>

        <article class="testimonial-card reveal reveal-delay-2" aria-label="Testimonial from Riya Patel">
          <div class="testimonial-stars" aria-label="5 out of 5 stars">
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
          </div>
          <p class="testimonial-text">
            As a self-taught developer, I always struggled to stay organized.
            CodeTrack's dashboard gives me the structure I was missing.
            The dark mode and analytics are absolutely beautiful.
          </p>
          <div class="testimonial-author">
            <div class="testimonial-avatar a2" aria-hidden="true">R</div>
            <div>
              <div class="testimonial-name">Riya Patel</div>
              <div class="testimonial-role">Backend Developer · Google · NIT Surat</div>
            </div>
          </div>
        </article>

        <article class="testimonial-card reveal reveal-delay-4" aria-label="Testimonial from Karan Mehta">
          <div class="testimonial-stars" aria-label="4 out of 5 stars">
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
            <i class="fa-regular fa-star"></i>
          </div>
          <p class="testimonial-text">
            Best free tool for DSA tracking I've ever used. The personal notes
            feature is a lifesaver — I can attach my approach, time/space
            complexity, and revisit everything before interviews.
          </p>
          <div class="testimonial-author">
            <div class="testimonial-avatar a3" aria-hidden="true">K</div>
            <div>
              <div class="testimonial-name">Karan Mehta</div>
              <div class="testimonial-role">CS Final Year · BITS Pilani</div>
            </div>
          </div>
        </article>

      </div>
    </div>
  </section>

  <!-- ══════════════════════════════════════════════════════════
       9. FAQ ACCORDION
       ══════════════════════════════════════════════════════════ -->
  <section class="faq-section section" id="faq" aria-labelledby="faq-title">
    <div class="container">
      <div class="section-center">
        <div class="section-tag">
          <i class="fa-solid fa-circle-question fa-xs"></i>
          FAQ
        </div>
        <h2 class="section-heading" id="faq-title">
          Frequently Asked <span class="gradient-text">Questions</span>
        </h2>
      </div>

      <div class="faq-list" role="list">

        <div class="faq-item open" role="listitem">
          <button class="faq-question"
                  aria-expanded="true"
                  aria-controls="faq-a1"
                  id="faq-q1">
            Is CodeTrack completely free?
            <div class="faq-icon" aria-hidden="true">
              <i class="fa-solid fa-plus"></i>
            </div>
          </button>
          <div class="faq-answer" id="faq-a1" role="region" aria-labelledby="faq-q1">
            <div class="faq-answer-inner">
              Yes! CodeTrack is 100% free with no hidden charges, no premium tiers,
              and no credit card required. All features — analytics, notes, search,
              dark mode — are completely free for everyone.
            </div>
          </div>
        </div>

        <div class="faq-item" role="listitem">
          <button class="faq-question"
                  aria-expanded="false"
                  aria-controls="faq-a2"
                  id="faq-q2">
            Can I track LeetCode problems?
            <div class="faq-icon" aria-hidden="true"><i class="fa-solid fa-plus"></i></div>
          </button>
          <div class="faq-answer" id="faq-a2" role="region" aria-labelledby="faq-q2">
            <div class="faq-answer-inner">
              Absolutely. CodeTrack supports tracking questions from LeetCode,
              GeeksforGeeks, Codeforces, HackerRank, Coding Ninjas, and any
              custom platform you add manually.
            </div>
          </div>
        </div>

        <div class="faq-item" role="listitem">
          <button class="faq-question"
                  aria-expanded="false"
                  aria-controls="faq-a3"
                  id="faq-q3">
            Can I add personal notes and approaches?
            <div class="faq-icon" aria-hidden="true"><i class="fa-solid fa-plus"></i></div>
          </button>
          <div class="faq-answer" id="faq-a3" role="region" aria-labelledby="faq-q3">
            <div class="faq-answer-inner">
              Yes! Each question has a dedicated notes section where you can
              write your approach, time/space complexity, hints, and any other
              observations you want to remember for future reference.
            </div>
          </div>
        </div>

        <div class="faq-item" role="listitem">
          <button class="faq-question"
                  aria-expanded="false"
                  aria-controls="faq-a4"
                  id="faq-q4">
            Does it support dark mode?
            <div class="faq-icon" aria-hidden="true"><i class="fa-solid fa-plus"></i></div>
          </button>
          <div class="faq-answer" id="faq-a4" role="region" aria-labelledby="faq-q4">
            <div class="faq-answer-inner">
              Yes, CodeTrack comes with a beautiful dark mode and clean light mode.
              Your preference is saved automatically and even syncs with your OS
              system preference. Toggle it anytime with the theme button in the navbar.
            </div>
          </div>
        </div>

        <div class="faq-item" role="listitem">
          <button class="faq-question"
                  aria-expanded="false"
                  aria-controls="faq-a5"
                  id="faq-q5">
            Can I export my progress data?
            <div class="faq-icon" aria-hidden="true"><i class="fa-solid fa-plus"></i></div>
          </button>
          <div class="faq-answer" id="faq-a5" role="region" aria-labelledby="faq-q5">
            <div class="faq-answer-inner">
              Export functionality is coming soon! We're building CSV and PDF export
              so you can take your data anywhere. Star the GitHub repo to get
              notified when it's live.
            </div>
          </div>
        </div>

      </div>
    </div>
  </section>

  <!-- ══════════════════════════════════════════════════════════
       10. CALL TO ACTION BANNER
       ══════════════════════════════════════════════════════════ -->
  <section class="cta-section" id="cta" aria-labelledby="cta-title">
    <div class="container">
      <div class="cta-inner reveal">
        <h2 class="cta-title" id="cta-title">
          Ready to Level Up Your<br>
          <span class="gradient-text">Coding Journey?</span>
        </h2>
        <p class="cta-subtitle">
          Join 500+ students already using CodeTrack to organize their DSA prep,
          crush interviews, and land their dream job.
        </p>
        <div class="cta-actions">
          <a href="<%= ctx %>/pages/register.jsp" class="btn btn-primary btn-lg" id="cta-get-started">
            <i class="fa-solid fa-rocket" aria-hidden="true"></i>
            Get Started Free
          </a>
          <a href="#preview" class="btn btn-secondary btn-lg" id="cta-view-demo"
             style="background:rgba(255,255,255,0.08);border-color:rgba(255,255,255,0.15);color:rgba(255,255,255,0.8);">
            <i class="fa-solid fa-play" aria-hidden="true"></i>
            View Demo
          </a>
        </div>
        <p style="font-size:var(--text-xs);color:rgba(255,255,255,0.35);margin-top:var(--space-5);position:relative;z-index:1;">
          No credit card required · 100% free · Open source
        </p>
      </div>
    </div>
  </section>

</main>

<!-- ════════════════════════════════════════════════════════════
     FOOTER
     ════════════════════════════════════════════════════════════ -->
<%@ include file="../components/layout/footer.jsp" %>

<!-- ════════════════════════════════════════════════════════════
     MODALS
     ════════════════════════════════════════════════════════════ -->
<%@ include file="../components/common/modal.jsp" %>

<!-- ════════════════════════════════════════════════════════════
     JAVASCRIPT
     ════════════════════════════════════════════════════════════ -->
<!-- Theme (first — prevents FOWT) -->
<script src="<%= ctx %>/assets/js/theme/theme.js"></script>
<!-- Toast -->
<script src="<%= ctx %>/assets/js/common/toast.js"></script>
<!-- Modal -->
<script src="<%= ctx %>/assets/js/common/modal.js"></script>
<!-- Landing page -->
<script src="<%= ctx %>/assets/js/common/landing.js"></script>

</body>
</html>
