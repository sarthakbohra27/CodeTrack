/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * dashboard.js — Dashboard Page Logic
 * ============================================================
 * Handles: stat card counters, chart initialization with
 * data from hidden JSON data islands injected by the servlet.
 * ============================================================
 */

'use strict';

window.CodeTrack = window.CodeTrack || {};

CodeTrack.Dashboard = {

    charts: {},

    init() {
        this.animateCounters();
        this.initCharts();
    },

    /**
     * Animates stat card numbers from 0 to their target value.
     */
    animateCounters() {
        const cards = document.querySelectorAll('.stat-card-value');
        cards.forEach(el => {
            const target = parseInt(el.textContent) || 0;
            if (isNaN(target) || target === 0) return;
            this.countUp(el, 0, target, 800);
        });
    },

    countUp(el, start, end, duration) {
        const startTime = performance.now();
        const update = (currentTime) => {
            const elapsed  = currentTime - startTime;
            const progress = Math.min(elapsed / duration, 1);
            const eased    = 1 - Math.pow(1 - progress, 3); // ease-out cubic
            el.textContent = Math.floor(start + (end - start) * eased);
            if (progress < 1) requestAnimationFrame(update);
        };
        requestAnimationFrame(update);
    },

    /**
     * Reads data from hidden JSON containers injected by the servlet
     * and renders charts.
     *
     * TODO: Replace dummy data with real data from server:
     *   <div id="dashboardData" class="hidden"
     *        data-difficulty='<%= jsonDifficulty %>'
     *        data-platforms='<%= jsonPlatforms %>'>
     *   </div>
     */
    initCharts() {
        // ── Read data islands ─────────────────────────────────
        const dataEl   = document.getElementById('dashboardData');
        const diffData = dataEl?.dataset.difficulty;
        const platData = dataEl?.dataset.platforms;

        // ── Difficulty Doughnut ───────────────────────────────
        const difficulty = diffData ? JSON.parse(diffData) : [47, 89, 23];
        this.charts.difficulty = CodeTrack.Charts.renderDifficultyChart('difficultyChart', difficulty);

        // ── Platform Bar ──────────────────────────────────────
        let platLabels = ['LeetCode', 'GeeksforGeeks', 'Codeforces'];
        let platCounts = [85, 63, 11];
        if (platData) {
            const parsed = JSON.parse(platData);
            platLabels   = parsed.map(p => p[0]);
            platCounts   = parsed.map(p => p[1]);
        }
        this.charts.platform = CodeTrack.Charts.renderPlatformChart('platformChart', platLabels, platCounts);
    }
};

document.addEventListener('DOMContentLoaded', () => {
    CodeTrack.Dashboard.init();
});
