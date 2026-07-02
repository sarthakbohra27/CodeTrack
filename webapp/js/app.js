/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * app.js — Application Entry Point & Global Utilities
 * ============================================================
 * Runs on every page. Initializes:
 *   - Theme (dark/light) from localStorage
 *   - Sidebar toggle behavior
 *   - User dropdown menu
 *   - Page loader
 *   - Global tooltips
 *   - CSRF token setup
 * ============================================================
 */

'use strict';

// ── App Namespace ─────────────────────────────────────────────
window.CodeTrack = window.CodeTrack || {};

// ── DOM Ready ─────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
    CodeTrack.App.init();
});

// ── App Module ────────────────────────────────────────────────
CodeTrack.App = {

    init() {
        this.initTheme();
        this.initSidebar();
        this.initUserMenu();
        this.initPageLoader();
        this.initTooltips();
        this.bindGlobalEvents();
        console.info('%cCodeTrack v1.0.0 initialized ✅', 'color: #7C3AED; font-weight: bold;');
    },

    // ── Theme ─────────────────────────────────────────────────
    initTheme() {
        const saved = localStorage.getItem('codetrack-theme') || 'dark';
        document.documentElement.setAttribute('data-theme', saved);
        document.body.setAttribute('data-theme', saved);
        this.updateThemeIcon(saved);
    },

    toggleTheme() {
        const current = document.body.getAttribute('data-theme') || 'dark';
        const next    = current === 'dark' ? 'light' : 'dark';
        document.body.setAttribute('data-theme', next);
        document.documentElement.setAttribute('data-theme', next);
        localStorage.setItem('codetrack-theme', next);
        this.updateThemeIcon(next);
    },

    updateThemeIcon(theme) {
        const icon = document.getElementById('themeIcon');
        if (icon) {
            icon.className = theme === 'dark' ? 'fa-solid fa-sun' : 'fa-solid fa-moon';
        }
    },

    // ── Sidebar ───────────────────────────────────────────────
    initSidebar() {
        const sidebar       = document.getElementById('appSidebar');
        const toggleBtn     = document.getElementById('sidebarToggleBtn');
        const collapseBtn   = document.getElementById('sidebarCollapseBtn');
        const mainContent   = document.getElementById('mainContent');

        if (!sidebar) return;

        // Mobile toggle (hamburger)
        toggleBtn?.addEventListener('click', () => {
            sidebar.classList.toggle('open');
        });

        // Collapse to icon-only on desktop
        collapseBtn?.addEventListener('click', () => {
            const collapsed = sidebar.classList.toggle('collapsed');
            if (mainContent) {
                mainContent.style.marginLeft = collapsed
                    ? 'var(--sidebar-collapsed-width)'
                    : 'var(--sidebar-width)';
            }
            localStorage.setItem('codetrack-sidebar-collapsed', collapsed);
        });

        // Restore collapse state
        const wasCollapsed = localStorage.getItem('codetrack-sidebar-collapsed') === 'true';
        if (wasCollapsed && window.innerWidth > 1024) {
            sidebar.classList.add('collapsed');
            if (mainContent) mainContent.style.marginLeft = 'var(--sidebar-collapsed-width)';
        }

        // Close sidebar on outside click (mobile)
        document.addEventListener('click', (e) => {
            if (window.innerWidth <= 1024 &&
                sidebar.classList.contains('open') &&
                !sidebar.contains(e.target) &&
                !toggleBtn?.contains(e.target)) {
                sidebar.classList.remove('open');
            }
        });
    },

    // ── User Dropdown ─────────────────────────────────────────
    initUserMenu() {
        const menu      = document.getElementById('userMenu');
        const avatarBtn = document.getElementById('userAvatarBtn');
        if (!menu || !avatarBtn) return;

        avatarBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            const isOpen = menu.classList.toggle('open');
            avatarBtn.setAttribute('aria-expanded', isOpen);
        });

        // Close on outside click
        document.addEventListener('click', () => menu.classList.remove('open'));
    },

    // ── Page Loader ───────────────────────────────────────────
    initPageLoader() {
        const loader = document.getElementById('pageLoader');
        if (loader) {
            window.addEventListener('load', () => {
                setTimeout(() => loader.classList.add('hidden'), 300);
            });
        }
    },

    // ── Tooltips ──────────────────────────────────────────────
    initTooltips() {
        // Simple title-based tooltips
        document.querySelectorAll('[data-tooltip]').forEach(el => {
            el.title = el.getAttribute('data-tooltip');
        });
    },

    // ── Theme Toggle Button ───────────────────────────────────
    bindGlobalEvents() {
        const themeBtn = document.getElementById('themeToggleBtn');
        themeBtn?.addEventListener('click', () => this.toggleTheme());
    }
};

// ── Toast Utility ─────────────────────────────────────────────
CodeTrack.toast = function(message, type = 'info', duration = 3000) {
    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    toast.innerHTML = `
        <i class="fa-solid ${type === 'success' ? 'fa-circle-check' : type === 'error' ? 'fa-circle-exclamation' : 'fa-circle-info'}"></i>
        <span>${message}</span>
    `;
    toast.style.cssText = `
        display: flex; align-items: center; gap: 12px;
        color: var(--text-primary); font-size: 0.875rem;
    `;
    document.body.appendChild(toast);
    setTimeout(() => { toast.style.opacity = '0'; setTimeout(() => toast.remove(), 300); }, duration);
};

// ── Format Date Utility ───────────────────────────────────────
CodeTrack.formatDate = function(dateStr) {
    if (!dateStr) return '–';
    const d = new Date(dateStr);
    return d.toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' });
};

// ── Debounce Utility ──────────────────────────────────────────
CodeTrack.debounce = function(fn, delay = 300) {
    let timer;
    return (...args) => {
        clearTimeout(timer);
        timer = setTimeout(() => fn(...args), delay);
    };
};
