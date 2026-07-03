/**
 * ============================================================
 * CodeTrack – Toast Notification System
 * API: CodeTrack.Toast.show({ type, title, message, duration })
 *      CodeTrack.Toast.success(msg) | .error(msg) | .warning(msg) | .info(msg)
 * ============================================================
 */
(function () {
  'use strict';

  window.CodeTrack = window.CodeTrack || {};

  var DEFAULT_DURATION = 4500; /* ms */
  var icons = {
    success: 'fa-solid fa-circle-check',
    error:   'fa-solid fa-circle-xmark',
    warning: 'fa-solid fa-triangle-exclamation',
    info:    'fa-solid fa-circle-info'
  };

  /**
   * Show a toast notification.
   * @param {Object} opts
   * @param {'success'|'error'|'warning'|'info'} opts.type
   * @param {string}  opts.title
   * @param {string}  opts.message
   * @param {number}  [opts.duration=4500]  ms, 0 = sticky
   */
  function showToast(opts) {
    var container = document.getElementById('toast-container');
    if (!container) return;

    var type     = opts.type     || 'info';
    var title    = opts.title    || capitalize(type);
    var message  = opts.message  || '';
    var duration = (opts.duration !== undefined) ? opts.duration : DEFAULT_DURATION;

    var toast = document.createElement('div');
    toast.className = 'toast toast-' + type;
    toast.setAttribute('role', 'alert');
    toast.setAttribute('aria-live', 'assertive');
    toast.innerHTML =
      '<div class="toast-accent" aria-hidden="true"></div>' +
      '<div class="toast-icon-wrap" aria-hidden="true">' +
        '<i class="' + (icons[type] || icons.info) + '"></i>' +
      '</div>' +
      '<div class="toast-body">' +
        '<div class="toast-title">' + escHtml(title) + '</div>' +
        (message ? '<div class="toast-message">' + escHtml(message) + '</div>' : '') +
      '</div>' +
      '<button class="toast-close" aria-label="Close notification">' +
        '<i class="fa-solid fa-xmark" aria-hidden="true"></i>' +
      '</button>' +
      (duration > 0
        ? '<div class="toast-progress" style="animation-duration:' + duration + 'ms;"></div>'
        : '');

    container.appendChild(toast);

    /* Close button */
    toast.querySelector('.toast-close').addEventListener('click', function () {
      removeToast(toast);
    });

    /* Auto-remove */
    var timer;
    if (duration > 0) {
      timer = setTimeout(function () { removeToast(toast); }, duration);
    }

    /* Pause on hover */
    toast.addEventListener('mouseenter', function () {
      if (timer) clearTimeout(timer);
      var bar = toast.querySelector('.toast-progress');
      if (bar) bar.style.animationPlayState = 'paused';
    });

    toast.addEventListener('mouseleave', function () {
      var bar = toast.querySelector('.toast-progress');
      if (bar) bar.style.animationPlayState = 'running';
      if (duration > 0) {
        timer = setTimeout(function () { removeToast(toast); }, duration / 2);
      }
    });
  }

  function removeToast(toast) {
    toast.classList.add('removing');
    toast.addEventListener('animationend', function () {
      if (toast.parentNode) toast.parentNode.removeChild(toast);
    }, { once: true });
  }

  function capitalize(s) {
    return s.charAt(0).toUpperCase() + s.slice(1);
  }

  function escHtml(str) {
    return String(str)
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;');
  }

  /* ── Public API ─────────────────────────────────────────── */
  window.CodeTrack.Toast = {
    show:    showToast,
    success: function (msg, title) { showToast({ type: 'success', title: title || 'Success', message: msg }); },
    error:   function (msg, title) { showToast({ type: 'error',   title: title || 'Error',   message: msg }); },
    warning: function (msg, title) { showToast({ type: 'warning', title: title || 'Warning', message: msg }); },
    info:    function (msg, title) { showToast({ type: 'info',    title: title || 'Info',    message: msg }); },
  };

})();
