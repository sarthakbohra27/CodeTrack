/**
 * ============================================================
 * CodeTrack – Modal System
 * API: CodeTrack.Modal.open(id)
 *      CodeTrack.Modal.close(id)
 *      CodeTrack.Modal.confirmDelete({ itemName, onConfirm })
 *      CodeTrack.Modal.create({ title, body, onConfirm, onCancel })
 * ============================================================
 */
(function () {
  'use strict';

  window.CodeTrack = window.CodeTrack || {};

  /* Track open modals for Escape key stack */
  var openStack = [];

  /**
   * Open a modal by its backdrop element ID.
   * @param {string} id
   */
  function openModal(id) {
    var backdrop = document.getElementById(id);
    if (!backdrop) {
      console.warn('[CodeTrack.Modal] Modal not found:', id);
      return;
    }

    backdrop.style.display = 'flex';
    backdrop.classList.remove('closing');
    document.body.style.overflow = 'hidden';

    /* Push to stack */
    if (!openStack.includes(id)) openStack.push(id);

    /* Focus first focusable element */
    var focusable = backdrop.querySelector(
      'button:not([disabled]), [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
    );
    if (focusable) setTimeout(function () { focusable.focus(); }, 50);

    /* Backdrop click closes */
    backdrop.addEventListener('click', function onBackdropClick(e) {
      if (e.target === backdrop) {
        closeModal(id);
        backdrop.removeEventListener('click', onBackdropClick);
      }
    });
  }

  /**
   * Close a modal by its backdrop element ID.
   * @param {string} id
   */
  function closeModal(id) {
    var backdrop = document.getElementById(id);
    if (!backdrop) return;

    backdrop.classList.add('closing');

    setTimeout(function () {
      backdrop.style.display = 'none';
      backdrop.classList.remove('closing');
      /* Restore scroll if no more open modals */
      openStack = openStack.filter(function (oid) { return oid !== id; });
      if (openStack.length === 0) {
        document.body.style.overflow = '';
      }
    }, 200);
  }

  /**
   * Open the delete confirm modal, set item name, and bind onConfirm.
   * @param {Object} opts
   * @param {string}   opts.itemName
   * @param {Function} opts.onConfirm
   */
  function confirmDelete(opts) {
    var nameEl  = document.getElementById('modal-confirm-delete-name');
    var confirmBtn = document.getElementById('modal-confirm-delete-btn');
    if (nameEl)  nameEl.textContent = opts.itemName || 'this item';

    if (confirmBtn && typeof opts.onConfirm === 'function') {
      /* Remove old listener first */
      var newBtn = confirmBtn.cloneNode(true);
      confirmBtn.parentNode.replaceChild(newBtn, confirmBtn);
      newBtn.addEventListener('click', function () {
        opts.onConfirm();
        closeModal('modal-confirm-delete');
      });
    }
    openModal('modal-confirm-delete');
  }

  /**
   * Programmatically create and show a one-off modal.
   * @param {Object} opts
   */
  function createModal(opts) {
    var template = document.getElementById('modal-template');
    if (!template) return;

    var id = 'modal-dynamic-' + Date.now();
    var clone = template.content.cloneNode(true);
    var backdrop = clone.querySelector('[role="dialog"]');
    backdrop.id = id;
    backdrop.style.display = 'none';
    if (opts.size) backdrop.querySelector('.modal').classList.add('modal-' + opts.size);

    backdrop.querySelector('.modal-title').textContent   = opts.title   || '';
    backdrop.querySelector('.modal-subtitle').textContent = opts.subtitle || '';
    backdrop.querySelector('.modal-body').innerHTML = opts.body || '';

    var confirmBtn = backdrop.querySelector('.modal-confirm-btn');
    var cancelBtn  = backdrop.querySelector('.modal-cancel-btn');
    var closeBtn   = backdrop.querySelector('.modal-close');

    if (opts.confirmText) confirmBtn.textContent = opts.confirmText;
    if (opts.cancelText)  cancelBtn.textContent  = opts.cancelText;
    if (opts.confirmClass) {
      confirmBtn.className = 'btn btn-' + opts.confirmClass;
    }

    confirmBtn.addEventListener('click', function () {
      if (typeof opts.onConfirm === 'function') opts.onConfirm();
      closeModal(id);
      setTimeout(function () {
        if (backdrop.parentNode) backdrop.parentNode.removeChild(backdrop);
      }, 300);
    });

    cancelBtn.addEventListener('click', function () {
      if (typeof opts.onCancel === 'function') opts.onCancel();
      closeModal(id);
    });

    closeBtn.addEventListener('click', function () {
      closeModal(id);
    });

    document.body.appendChild(clone);
    openModal(id);
  }

  /* ── Global Escape key handler ──────────────────────────── */
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && openStack.length > 0) {
      closeModal(openStack[openStack.length - 1]);
    }
  });

  /* ── Also bind data-modal-open and data-modal-close attrs ── */
  document.addEventListener('click', function (e) {
    var openTrigger  = e.target.closest('[data-modal-open]');
    var closeTrigger = e.target.closest('[data-modal-close]');

    if (openTrigger)  openModal(openTrigger.dataset.modalOpen);
    if (closeTrigger) closeModal(closeTrigger.dataset.modalClose);
  });

  /* ── Public API ─────────────────────────────────────────── */
  window.CodeTrack.Modal = {
    open          : openModal,
    close         : closeModal,
    confirmDelete : confirmDelete,
    create        : createModal,
  };

})();
