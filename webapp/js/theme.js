/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * theme.js — Theme Toggle & Persistence
 * ============================================================
 * Manages dark/light theme switching with system preference
 * detection and localStorage persistence.
 * ============================================================
 */

'use strict';

window.CodeTrack = window.CodeTrack || {};

CodeTrack.Theme = {

    STORAGE_KEY: 'codetrack-theme',

    init() {
        const saved   = this.getSaved();
        const active  = saved || this.getSystemPreference();
        this.apply(active);
        this.watchSystemChanges();
    },

    getSaved() {
        return localStorage.getItem(this.STORAGE_KEY);
    },

    getSystemPreference() {
        return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
    },

    apply(theme) {
        document.body.setAttribute('data-theme', theme);
        document.documentElement.setAttribute('data-theme', theme);
        this.updateIcon(theme);
        this.notifyCharts(theme);
    },

    toggle() {
        const current = document.body.getAttribute('data-theme') || 'dark';
        const next    = current === 'dark' ? 'light' : 'dark';
        this.apply(next);
        localStorage.setItem(this.STORAGE_KEY, next);
    },

    updateIcon(theme) {
        const icon = document.getElementById('themeIcon');
        if (!icon) return;
        icon.className = theme === 'dark' ? 'fa-solid fa-sun' : 'fa-solid fa-moon';
    },

    /** Re-apply Chart.js defaults when theme changes. */
    notifyCharts(theme) {
        if (window.CodeTrack?.Charts && typeof Chart !== 'undefined') {
            CodeTrack.Charts.applyGlobalDefaults();
            // Update existing chart instances
            Chart.instances && Object.values(Chart.instances).forEach(c => c.update('none'));
        }
    },

    watchSystemChanges() {
        const mq = window.matchMedia('(prefers-color-scheme: dark)');
        mq.addEventListener('change', (e) => {
            if (!this.getSaved()) {
                this.apply(e.matches ? 'dark' : 'light');
            }
        });
    }
};

document.addEventListener('DOMContentLoaded', () => {
    CodeTrack.Theme.init();
    document.getElementById('themeToggleBtn')
        ?.addEventListener('click', () => CodeTrack.Theme.toggle());
});
