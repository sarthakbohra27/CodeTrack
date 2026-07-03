/**
 * ============================================================
 * CodeTrack – Sidebar JS
 * Handles: collapse toggle, mobile drawer, overlay,
 *          state persistence in localStorage
 * ============================================================
 */
(function () {
  'use strict';

  var STORAGE_KEY = 'codetrack-sidebar-collapsed';

  document.addEventListener('DOMContentLoaded', function () {

    var sidebar      = document.getElementById('app-sidebar');
    var collapseBtn  = document.getElementById('sidebar-collapse-btn');
    var overlay      = document.getElementById('sidebar-overlay');
    var hamburger    = document.getElementById('navbar-hamburger');
    var appContent   = document.querySelector('.app-content');

    if (!sidebar) return;

    /* ── Restore collapse state ─────────────────────────── */
    var isCollapsed = localStorage.getItem(STORAGE_KEY) === 'true';
    if (isCollapsed && window.innerWidth > 768) {
      applyCollapsed(true, false);
    }

    /* ── Desktop collapse button ────────────────────────── */
    if (collapseBtn) {
      collapseBtn.addEventListener('click', function () {
        var nowCollapsed = !sidebar.classList.contains('collapsed');
        applyCollapsed(nowCollapsed, true);
        localStorage.setItem(STORAGE_KEY, nowCollapsed.toString());
      });
    }

    /* ── Mobile: hamburger opens sidebar ────────────────── */
    if (hamburger) {
      hamburger.addEventListener('click', function () {
        if (window.innerWidth <= 768) {
          openMobileSidebar();
        }
      });
    }

    /* ── Overlay click closes mobile sidebar ────────────── */
    if (overlay) {
      overlay.addEventListener('click', closeMobileSidebar);
    }

    /* ── Escape closes mobile sidebar ───────────────────── */
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') closeMobileSidebar();
    });

    /* ── Window resize: fix state ───────────────────────── */
    window.addEventListener('resize', function () {
      if (window.innerWidth > 768) {
        closeMobileSidebar(false);
        var savedCollapsed = localStorage.getItem(STORAGE_KEY) === 'true';
        applyCollapsed(savedCollapsed, false);
      }
    }, { passive: true });

    /* ── Logout button → confirm modal ──────────────────── */
    var logoutBtn = document.getElementById('sidebar-logout-btn');
    if (logoutBtn) {
      logoutBtn.addEventListener('click', function (e) {
        if (window.CodeTrack && CodeTrack.Modal) {
          e.preventDefault();
          CodeTrack.Modal.open('modal-confirm-logout');
        }
      });
    }

    /* ──────────────────────────────────────────────────────
       Helpers
    ────────────────────────────────────────────────────── */
    function applyCollapsed(collapsed, animate) {
      if (!animate) {
        sidebar.style.transition = 'none';
        if (appContent) appContent.style.transition = 'none';
      }

      sidebar.classList.toggle('collapsed', collapsed);
      if (appContent) {
        appContent.classList.toggle('sidebar-collapsed', collapsed);
      }
      if (collapseBtn) {
        collapseBtn.setAttribute('aria-label', collapsed ? 'Expand sidebar' : 'Collapse sidebar');
        collapseBtn.setAttribute('title',      collapsed ? 'Expand sidebar' : 'Collapse sidebar');
      }

      if (!animate) {
        requestAnimationFrame(function () {
          sidebar.style.transition = '';
          if (appContent) appContent.style.transition = '';
        });
      }
    }

    function openMobileSidebar() {
      sidebar.classList.add('mobile-open');
      if (overlay) {
        overlay.classList.add('active');
        overlay.removeAttribute('aria-hidden');
      }
      document.body.style.overflow = 'hidden';
      sidebar.setAttribute('aria-hidden', 'false');
    }

    function closeMobileSidebar(restore) {
      sidebar.classList.remove('mobile-open');
      if (overlay) {
        overlay.classList.remove('active');
        overlay.setAttribute('aria-hidden', 'true');
      }
      document.body.style.overflow = '';
      sidebar.setAttribute('aria-hidden', 'true');
    }

  });
})();
