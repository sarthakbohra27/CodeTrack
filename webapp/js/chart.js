/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * chart.js — Chart.js Configuration & Rendering
 * ============================================================
 * Defines reusable Chart.js chart renderers for the Analytics
 * and Dashboard pages.
 *
 * Uses Chart.js 4.x loaded via CDN.
 * All charts adapt to the current theme (dark/light).
 * ============================================================
 */

'use strict';

window.CodeTrack = window.CodeTrack || {};

// ── Chart Module ──────────────────────────────────────────────
CodeTrack.Charts = {

    /**
     * Returns the current theme-aware Chart.js default colors.
     */
    getThemeColors() {
        const isDark = document.body.getAttribute('data-theme') !== 'light';
        return {
            text:      isDark ? 'rgba(220,220,235,0.85)' : 'rgba(20,20,40,0.8)',
            grid:      isDark ? 'rgba(255,255,255,0.06)'  : 'rgba(0,0,0,0.06)',
            border:    isDark ? 'rgba(255,255,255,0.10)'  : 'rgba(0,0,0,0.08)',
            easy:      '#22c55e',
            medium:    '#f59e0b',
            hard:      '#ef4444',
            primary:   '#7C3AED',
            secondary: '#06b6d4',
        };
    },

    /**
     * Common defaults applied to all charts.
     */
    applyGlobalDefaults() {
        const clr = this.getThemeColors();
        Chart.defaults.font.family    = "'Poppins', sans-serif";
        Chart.defaults.font.size      = 12;
        Chart.defaults.color          = clr.text;
        Chart.defaults.borderColor    = clr.border;
        Chart.defaults.plugins.legend.labels.color = clr.text;
        Chart.defaults.plugins.tooltip.backgroundColor = 'rgba(15,15,30,0.92)';
        Chart.defaults.plugins.tooltip.titleColor      = '#fff';
        Chart.defaults.plugins.tooltip.bodyColor       = 'rgba(200,200,215,0.9)';
        Chart.defaults.plugins.tooltip.padding         = 12;
        Chart.defaults.plugins.tooltip.cornerRadius    = 8;
    },

    /**
     * Renders the Difficulty Doughnut Chart on the dashboard.
     *
     * @param {string} canvasId - The canvas element ID.
     * @param {number[]} data   - [easyCount, mediumCount, hardCount]
     */
    renderDifficultyChart(canvasId, data = [0, 0, 0]) {
        const canvas = document.getElementById(canvasId);
        if (!canvas) return null;

        this.applyGlobalDefaults();
        const clr = this.getThemeColors();

        return new Chart(canvas, {
            type: 'doughnut',
            data: {
                labels: ['Easy', 'Medium', 'Hard'],
                datasets: [{
                    data:            data,
                    backgroundColor: [
                        `${clr.easy}CC`,
                        `${clr.medium}CC`,
                        `${clr.hard}CC`,
                    ],
                    borderColor:     [clr.easy, clr.medium, clr.hard],
                    borderWidth:     2,
                    hoverOffset:     8,
                }]
            },
            options: {
                responsive:       true,
                maintainAspectRatio: false,
                cutout:           '70%',
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding:    16,
                            boxWidth:   12,
                            boxHeight:  12,
                            borderRadius: 6,
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: (ctx) => ` ${ctx.label}: ${ctx.parsed} problems`
                        }
                    }
                },
                animation: { animateScale: true, animateRotate: true, duration: 800 }
            }
        });
    },

    /**
     * Renders the Platform Bar Chart on the dashboard.
     *
     * @param {string}   canvasId - The canvas element ID.
     * @param {string[]} labels   - Platform names.
     * @param {number[]} data     - Question counts per platform.
     */
    renderPlatformChart(canvasId, labels = [], data = []) {
        const canvas = document.getElementById(canvasId);
        if (!canvas) return null;

        this.applyGlobalDefaults();
        const clr = this.getThemeColors();

        return new Chart(canvas, {
            type: 'bar',
            data: {
                labels,
                datasets: [{
                    label:           'Questions',
                    data,
                    backgroundColor: `${clr.primary}99`,
                    borderColor:     clr.primary,
                    borderWidth:     2,
                    borderRadius:    6,
                    borderSkipped:   false,
                }]
            },
            options: {
                responsive:          true,
                maintainAspectRatio: false,
                scales: {
                    x: {
                        grid:   { color: clr.grid, drawBorder: false },
                        ticks:  { color: clr.text }
                    },
                    y: {
                        beginAtZero: true,
                        grid:        { color: clr.grid, drawBorder: false },
                        ticks:       { color: clr.text, stepSize: 1 }
                    }
                },
                plugins: {
                    legend: { display: false }
                },
                animation: { duration: 700 }
            }
        });
    },

    /**
     * Renders a Line Chart for questions solved over time.
     *
     * @param {string}   canvasId - Canvas element ID.
     * @param {string[]} labels   - Date labels.
     * @param {number[]} data     - Cumulative counts.
     */
    renderProgressChart(canvasId, labels = [], data = []) {
        const canvas = document.getElementById(canvasId);
        if (!canvas) return null;

        this.applyGlobalDefaults();
        const clr = this.getThemeColors();

        return new Chart(canvas, {
            type: 'line',
            data: {
                labels,
                datasets: [{
                    label:           'Problems Solved',
                    data,
                    borderColor:     clr.primary,
                    backgroundColor: `${clr.primary}18`,
                    borderWidth:     2.5,
                    fill:            true,
                    tension:         0.4,
                    pointBackgroundColor: clr.primary,
                    pointRadius:         4,
                    pointHoverRadius:    6,
                }]
            },
            options: {
                responsive:          true,
                maintainAspectRatio: false,
                scales: {
                    x: { grid: { color: clr.grid }, ticks: { color: clr.text } },
                    y: { beginAtZero: true, grid: { color: clr.grid }, ticks: { color: clr.text } }
                },
                plugins: { legend: { display: false } },
                animation: { duration: 800 }
            }
        });
    },

    /**
     * Renders a Radar/Spider chart for topic coverage.
     *
     * @param {string}   canvasId - Canvas ID.
     * @param {string[]} labels   - Topic names.
     * @param {number[]} data     - Problem counts per topic.
     */
    renderTopicRadarChart(canvasId, labels = [], data = []) {
        const canvas = document.getElementById(canvasId);
        if (!canvas) return null;

        this.applyGlobalDefaults();
        const clr = this.getThemeColors();

        return new Chart(canvas, {
            type: 'radar',
            data: {
                labels,
                datasets: [{
                    label:           'Problems',
                    data,
                    borderColor:     clr.secondary,
                    backgroundColor: `${clr.secondary}25`,
                    borderWidth:     2,
                    pointBackgroundColor: clr.secondary,
                }]
            },
            options: {
                responsive:          true,
                maintainAspectRatio: false,
                scales: {
                    r: {
                        beginAtZero:      true,
                        ticks:            { color: clr.text, backdropColor: 'transparent', stepSize: 2 },
                        grid:             { color: clr.grid },
                        angleLines:       { color: clr.grid },
                        pointLabels:      { color: clr.text, font: { size: 11 } }
                    }
                },
                plugins: { legend: { display: false } }
            }
        });
    }
};
