/**
 * ============================================================
 * CodeTrack – Pagination JS
 * Handles: keyboard navigation, AJAX-ready page change hook
 * API: CodeTrack.Pagination.onChange(fn) — called with page #
 * ============================================================
 */
(function () {
  'use strict';

  window.CodeTrack = window.CodeTrack || {};

  var changeCallback = null;

  document.addEventListener('DOMContentLoaded', function () {
    var pagination = document.querySelector('.pagination');
    if (!pagination) return;

    /* ── Keyboard navigation ────────────────────────────── */
    pagination.addEventListener('keydown', function (e) {
      var items  = Array.from(pagination.querySelectorAll('.page-item:not(.disabled) .page-link'));
      var active = document.activeElement;
      var idx    = items.indexOf(active);

      if (e.key === 'ArrowRight' && idx < items.length - 1) {
        e.preventDefault();
        items[idx + 1].focus();
      } else if (e.key === 'ArrowLeft' && idx > 0) {
        e.preventDefault();
        items[idx - 1].focus();
      }
    });

    /* ── Page link click → fire callback if set ─────────── */
    pagination.addEventListener('click', function (e) {
      var link = e.target.closest('.page-link');
      if (!link || link.closest('.page-item.disabled')) return;
      if (typeof changeCallback === 'function') {
        var href = link.getAttribute('href');
        var match = href && href.match(/[?&]page=(\d+)/);
        if (match) {
          changeCallback(parseInt(match[1], 10));
        }
      }
    });
  });

  /* ── Public API ─────────────────────────────────────────── */
  window.CodeTrack.Pagination = {
    onChange: function (fn) { changeCallback = fn; }
  };

})();
