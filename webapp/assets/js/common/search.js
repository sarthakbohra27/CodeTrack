/**
 * ============================================================
 * CodeTrack – Search Component JS
 * Handles: clear button, form submit, keyboard shortcuts
 * ============================================================
 */
(function () {
  'use strict';

  document.addEventListener('DOMContentLoaded', function () {
    var input     = document.getElementById('search-input');
    var clearBtn  = document.getElementById('search-clear-btn');
    var form      = document.getElementById('search-form');
    var component = form ? form.closest('.search-component') : null;

    if (!input) return;

    /* ── Show/hide clear button ─────────────────────────── */
    function syncClearBtn() {
      if (!clearBtn) return;
      var hasValue = input.value.trim().length > 0;
      clearBtn.style.display = hasValue ? 'flex' : '';
      if (component) component.classList.toggle('has-value', hasValue);
    }

    input.addEventListener('input',  syncClearBtn);
    input.addEventListener('change', syncClearBtn);
    syncClearBtn();

    /* ── Clear button click ─────────────────────────────── */
    if (clearBtn) {
      clearBtn.addEventListener('click', function () {
        input.value = '';
        syncClearBtn();
        input.focus();
        /* Submit form to reset results */
        if (form) form.submit();
      });
    }

    /* ── Keyboard shortcut: / or Ctrl+K focuses search ─── */
    document.addEventListener('keydown', function (e) {
      var tag = (document.activeElement || {}).tagName || '';
      var inInput = ['INPUT','TEXTAREA','SELECT'].includes(tag);

      if (!inInput && (e.key === '/' || (e.ctrlKey && e.key === 'k'))) {
        e.preventDefault();
        input.focus();
        input.select();
      }

      if (e.key === 'Escape' && document.activeElement === input) {
        input.blur();
      }
    });

  });
})();

/* ── CodeTrack.Filter namespace ──────────────────────────── */
(function () {
  'use strict';
  window.CodeTrack = window.CodeTrack || {};

  /**
   * Apply a filter by redirecting to baseUrl with query params.
   * Called from filter checkbox onchange handlers.
   */
  window.CodeTrack.Filter = {
    apply: function (checkbox, baseUrl) {
      var section = document.getElementById('filter-section');
      if (!section) return;

      /* Collect all checked filters within the filter section */
      var params = new URLSearchParams(window.location.search);

      /* Remove old values for this filter name */
      params.delete(checkbox.name);

      /* Add checked values */
      var all = section.querySelectorAll('input[name="' + checkbox.name + '"]:checked');
      all.forEach(function (cb) {
        params.append(checkbox.name, cb.value);
      });

      /* Keep search param */
      var q = params.get('q');
      var newUrl = baseUrl + (params.toString() ? '?' + params.toString() : '');
      window.location.href = newUrl;
    },

    reset: function (baseUrl) {
      window.location.href = baseUrl;
    }
  };

  /* ── Filter panel toggles ───────────────────────────────── */
  document.addEventListener('DOMContentLoaded', function () {
    var triggers = document.querySelectorAll('.filter-trigger');

    triggers.forEach(function (btn) {
      var panelId = btn.getAttribute('aria-controls');
      if (!panelId) return;
      var panel = document.getElementById(panelId);
      if (!panel) return;

      btn.addEventListener('click', function (e) {
        e.stopPropagation();
        /* Close other panels */
        triggers.forEach(function (other) {
          if (other !== btn) {
            var otherId = other.getAttribute('aria-controls');
            var otherPanel = document.getElementById(otherId);
            if (otherPanel) otherPanel.style.display = 'none';
            other.setAttribute('aria-expanded', 'false');
          }
        });
        var isOpen = panel.style.display !== 'none' && panel.style.display !== '';
        panel.style.display = isOpen ? 'none' : 'block';
        btn.setAttribute('aria-expanded', (!isOpen).toString());
      });
    });

    /* Close all panels on outside click */
    document.addEventListener('click', function () {
      triggers.forEach(function (btn) {
        var panelId = btn.getAttribute('aria-controls');
        var panel = document.getElementById(panelId);
        if (panel) panel.style.display = 'none';
        btn.setAttribute('aria-expanded', 'false');
      });
    });

    /* Escape closes panels */
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') {
        triggers.forEach(function (btn) {
          var panelId = btn.getAttribute('aria-controls');
          var panel = document.getElementById(panelId);
          if (panel) panel.style.display = 'none';
          btn.setAttribute('aria-expanded', 'false');
        });
      }
    });
  });
})();
