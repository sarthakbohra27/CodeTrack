/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * analytics.js — Analytics Page Chart Initialization
 * ============================================================
 * Renders all charts on the analytics page:
 *   - Difficulty Doughnut
 *   - Platform Bar
 *   - Progress Line
 *   - Topic Radar
 * ============================================================
 */

'use strict';

CodeTrack = window.CodeTrack || {};

CodeTrack.Analytics = {

    init() {
        this.renderAllCharts();
    },

    renderAllCharts() {
        // TODO: Replace with real data from hidden data islands set by AnalyticsServlet

        // Difficulty breakdown
        CodeTrack.Charts.renderDifficultyChart('analyticsDifficultyChart', [47, 89, 23]);

        // Platform breakdown
        CodeTrack.Charts.renderPlatformChart(
            'analyticsPlatformChart',
            ['LeetCode', 'GeeksforGeeks', 'Codeforces', 'HackerRank'],
            [85, 63, 11, 0]
        );

        // Progress over last 30 days
        const last30Days = Array.from({length: 30}, (_, i) => {
            const d = new Date(); d.setDate(d.getDate() - (29 - i));
            return d.toLocaleDateString('en-IN', { day: 'numeric', month: 'short' });
        });
        const progressData = Array.from({length: 30}, (_, i) => Math.floor(Math.random() * 4));
        CodeTrack.Charts.renderProgressChart('analyticsProgressChart', last30Days, progressData);

        // Topic radar
        CodeTrack.Charts.renderTopicRadarChart(
            'analyticsTopicChart',
            ['Arrays', 'Trees', 'Graphs', 'DP', 'Strings', 'Sorting', 'Hashing'],
            [18, 14, 8, 12, 22, 10, 9]
        );
    }
};

document.addEventListener('DOMContentLoaded', () => {
    CodeTrack.Analytics.init();
});
