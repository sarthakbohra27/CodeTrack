/**
 * ============================================================
 * CodeTrack – Theme Manager (theme.js)
 * ============================================================
 * Handles:
 *   - Dark / Light theme toggle
 *   - LocalStorage persistence
 *   - OS preference detection (prefers-color-scheme)
 *   - Smooth transition on toggle
 *   - DOM icon update (sun / moon)
 *   - Chart.js re-render support hook
 *   - Modular API: CodeTrack.Theme
 * ============================================================
 */

(function () {
  'use strict';

  /* ── Constants ─────────────────────────────────────────── */
  const STORAGE_KEY    = 'codetrack-theme';
  const DARK_THEME     = 'dark';
  const LIGHT_THEME    = 'light';
  const TRANSITION_MS  = 250;

  /* ── Namespace ──────────────────────────────────────────── */
  window.CodeTrack = window.CodeTrack || {};

  /**
   * Detect the user's OS-level color scheme preference.
   * @returns {'dark'|'light'}
   */
  function getOsPreference() {
    return window.matchMedia('(prefers-color-scheme: dark)').matches
      ? DARK_THEME
      : LIGHT_THEME;
  }

  /**
   * Read the saved theme from localStorage.
   * Falls back to OS preference if no value is stored.
   * @returns {'dark'|'light'}
   */
  function getSavedTheme() {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved === DARK_THEME || saved === LIGHT_THEME) return saved;
    return getOsPreference();
  }

  /**
   * Persist the theme choice in localStorage.
   * @param {'dark'|'light'} theme
   */
  function saveTheme(theme) {
    localStorage.setItem(STORAGE_KEY, theme);
  }

  /**
   * Apply a theme to the <html> data-theme attribute.
   * @param {'dark'|'light'} theme
   * @param {boolean} [animate=false] - whether to add transition class
   */
  function applyTheme(theme, animate) {
    const root = document.documentElement;

    if (animate) {
      /* Temporarily suppress all transitions for instant switch,
         then re-enable after the CSS variable values have settled. */
      root.classList.add('theme-transitioning');
    }

    root.setAttribute('data-theme', theme);

    /* Also set on <body> for components that target body */
    if (document.body) {
      document.body.setAttribute('data-theme', theme);
    }

    if (animate) {
      /* Remove the transition blocker after the CSS variables have
         applied and a paint frame has fired. */
      requestAnimationFrame(() => {
        requestAnimationFrame(() => {
          root.classList.remove('theme-transitioning');
        });
      });
    }

    updateToggleIcon(theme);
    notifyThemeChange(theme);
  }

  /**
   * Update all theme-toggle button icons on the page.
   * Supports Font Awesome and inline SVG approaches.
   * @param {'dark'|'light'} theme
   */
  function updateToggleIcon(theme) {
    const toggleBtns = document.querySelectorAll(
      '[data-theme-toggle], #theme-toggle, .theme-toggle'
    );

    toggleBtns.forEach(btn => {
      /* ── Font Awesome icons ──────────────────────────── */
      const moonIcon = btn.querySelector('.fa-moon, .icon-moon');
      const sunIcon  = btn.querySelector('.fa-sun,  .icon-sun');

      if (moonIcon && sunIcon) {
        if (theme === DARK_THEME) {
          moonIcon.style.display = '';
          sunIcon.style.display  = 'none';
        } else {
          moonIcon.style.display = 'none';
          sunIcon.style.display  = '';
        }
        return;
      }

      /* ── Fallback: i element with class swap ─────────── */
      const icon = btn.querySelector('i');
      if (icon) {
        if (theme === DARK_THEME) {
          icon.className = icon.className.replace('fa-sun', 'fa-moon');
        } else {
          icon.className = icon.className.replace('fa-moon', 'fa-sun');
        }
      }

      /* ── aria-label update ────────────────────────────── */
      btn.setAttribute(
        'aria-label',
        theme === DARK_THEME ? 'Switch to light mode' : 'Switch to dark mode'
      );

      /* ── title tooltip update ─────────────────────────── */
      btn.setAttribute(
        'title',
        theme === DARK_THEME ? 'Switch to light mode' : 'Switch to dark mode'
      );
    });
  }

  /**
   * Fire a custom event so other modules (charts, etc.) can react.
   * @param {'dark'|'light'} theme
   */
  function notifyThemeChange(theme) {
    const event = new CustomEvent('codetrack:theme-changed', {
      detail: { theme },
      bubbles: true,
    });
    document.dispatchEvent(event);
  }

  /**
   * Toggle between dark and light themes.
   */
  function toggleTheme() {
    const current = document.documentElement.getAttribute('data-theme')
      || DARK_THEME;
    const next = current === DARK_THEME ? LIGHT_THEME : DARK_THEME;

    saveTheme(next);
    applyTheme(next, true /* animate */);
  }

  /**
   * Explicitly set a theme.
   * @param {'dark'|'light'} theme
   */
  function setTheme(theme) {
    if (theme !== DARK_THEME && theme !== LIGHT_THEME) {
      console.warn('[CodeTrack.Theme] Invalid theme:', theme);
      return;
    }
    saveTheme(theme);
    applyTheme(theme, true);
  }

  /**
   * Get the currently active theme.
   * @returns {'dark'|'light'}
   */
  function getTheme() {
    return document.documentElement.getAttribute('data-theme') || DARK_THEME;
  }

  /**
   * Bind click handlers to all theme-toggle elements.
   * Safe to call multiple times (uses a flag).
   */
  function bindToggleButtons() {
    document.querySelectorAll(
      '[data-theme-toggle], #theme-toggle, .theme-toggle'
    ).forEach(btn => {
      if (btn._themeListenerAttached) return;
      btn._themeListenerAttached = true;
      btn.addEventListener('click', () => toggleTheme());
    });
  }

  /**
   * Listen for OS-level theme changes and auto-apply,
   * only if the user has NOT manually set a preference.
   */
  function watchOsPreference() {
    const mq = window.matchMedia('(prefers-color-scheme: dark)');
    mq.addEventListener('change', (e) => {
      const hasManual = localStorage.getItem(STORAGE_KEY);
      if (!hasManual) {
        applyTheme(e.matches ? DARK_THEME : LIGHT_THEME, true);
      }
    });
  }

  /* ── CSS for smooth theme transition ─────────────────────── */
  function injectTransitionStyles() {
    const style = document.createElement('style');
    style.id = 'codetrack-theme-transitions';
    style.textContent = `
      *, *::before, *::after {
        transition:
          background-color ${TRANSITION_MS}ms ease,
          color ${TRANSITION_MS}ms ease,
          border-color ${TRANSITION_MS}ms ease,
          box-shadow ${TRANSITION_MS}ms ease,
          fill ${TRANSITION_MS}ms ease,
          stroke ${TRANSITION_MS}ms ease;
      }
      .theme-transitioning *,
      .theme-transitioning *::before,
      .theme-transitioning *::after {
        transition: none !important;
      }
    `;
    document.head.appendChild(style);
  }

  /* ============================================================
     INITIALISE
     Runs as soon as theme.js is parsed — before DOMContentLoaded
     to prevent flash of wrong theme (FOWT).
  ============================================================ */
  (function init() {
    const theme = getSavedTheme();

    /* Apply immediately (before DOM paint) */
    document.documentElement.setAttribute('data-theme', theme);

    /* Once DOM is ready, bind buttons & inject transitions */
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', onDomReady);
    } else {
      onDomReady();
    }

    function onDomReady() {
      injectTransitionStyles();
      applyTheme(theme, false);  /* Apply without animation on first load */
      bindToggleButtons();
      watchOsPreference();

      /* Re-bind after any dynamic content insertions (e.g., modals) */
      document.addEventListener('codetrack:dom-updated', bindToggleButtons);
    }
  })();

  /* ── Public API ─────────────────────────────────────────── */
  window.CodeTrack.Theme = {
    toggle   : toggleTheme,
    set      : setTheme,
    get      : getTheme,
    isDark   : () => getTheme() === DARK_THEME,
    isLight  : () => getTheme() === LIGHT_THEME,
    DARK     : DARK_THEME,
    LIGHT    : LIGHT_THEME,
  };

})();
