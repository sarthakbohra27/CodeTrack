<%-- ============================================================
     CodeTrack – Modal Component
     Usage: <%@ include file="../components/modal.jsp" %>
     JS API: CodeTrack.Modal.open(id) / CodeTrack.Modal.close(id)

     To create a modal, use:
       <div class="modal-backdrop hidden" id="my-modal" role="dialog"
            aria-modal="true" aria-labelledby="my-modal-title">
         <div class="modal">...</div>
       </div>

     This file provides:
       • General modal styles (via components.css)
       • Confirm dialog template
       • Logout confirm template
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!-- ══════════════════════════════════════════════════════════
     DELETE CONFIRMATION MODAL (reusable)
     Trigger: CodeTrack.Modal.confirmDelete({ itemName, onConfirm })
     ══════════════════════════════════════════════════════════ -->
<div class="modal-backdrop"
     id="modal-confirm-delete"
     role="dialog"
     aria-modal="true"
     aria-labelledby="modal-confirm-delete-title"
     style="display:none;">

  <div class="modal modal-sm">
    <div class="modal-body" style="text-align:center; padding-top:var(--space-8);">
      <div class="modal-confirm-icon danger" aria-hidden="true">
        <i class="fa-solid fa-trash-can"></i>
      </div>
      <h2 class="h4" id="modal-confirm-delete-title">Delete Item?</h2>
      <p class="body-sm" style="margin-top:var(--space-2);">
        Are you sure you want to delete
        <strong id="modal-confirm-delete-name">this item</strong>?
        This action <strong>cannot be undone</strong>.
      </p>
    </div>
    <div class="modal-footer">
      <button class="btn btn-secondary" onclick="CodeTrack.Modal.close('modal-confirm-delete')">
        Cancel
      </button>
      <button class="btn btn-danger" id="modal-confirm-delete-btn">
        <i class="fa-solid fa-trash-can" aria-hidden="true"></i> Delete
      </button>
    </div>
  </div>
</div>

<!-- ══════════════════════════════════════════════════════════
     LOGOUT CONFIRMATION MODAL
     ══════════════════════════════════════════════════════════ -->
<div class="modal-backdrop"
     id="modal-confirm-logout"
     role="dialog"
     aria-modal="true"
     aria-labelledby="modal-confirm-logout-title"
     style="display:none;">

  <div class="modal modal-sm">
    <div class="modal-body" style="text-align:center; padding-top:var(--space-8);">
      <div class="modal-confirm-icon warning" aria-hidden="true">
        <i class="fa-solid fa-right-from-bracket"></i>
      </div>
      <h2 class="h4" id="modal-confirm-logout-title">Log out?</h2>
      <p class="body-sm" style="margin-top:var(--space-2);">
        You'll need to log in again to access your dashboard.
      </p>
    </div>
    <div class="modal-footer">
      <button class="btn btn-secondary" onclick="CodeTrack.Modal.close('modal-confirm-logout')">
        Stay
      </button>
      <a href="<%= request.getContextPath() %>/logout" class="btn btn-danger">
        <i class="fa-solid fa-right-from-bracket" aria-hidden="true"></i> Log out
      </a>
    </div>
  </div>
</div>

<!-- ══════════════════════════════════════════════════════════
     RESET CONFIRMATION MODAL
     ══════════════════════════════════════════════════════════ -->
<div class="modal-backdrop"
     id="modal-confirm-reset"
     role="dialog"
     aria-modal="true"
     aria-labelledby="modal-confirm-reset-title"
     style="display:none;">

  <div class="modal modal-sm">
    <div class="modal-body" style="text-align:center; padding-top:var(--space-8);">
      <div class="modal-confirm-icon warning" aria-hidden="true">
        <i class="fa-solid fa-rotate-left"></i>
      </div>
      <h2 class="h4" id="modal-confirm-reset-title">Reset Data?</h2>
      <p class="body-sm" style="margin-top:var(--space-2);">
        This will reset all your progress. This action <strong>cannot be undone</strong>.
      </p>
    </div>
    <div class="modal-footer">
      <button class="btn btn-secondary" onclick="CodeTrack.Modal.close('modal-confirm-reset')">
        Cancel
      </button>
      <button class="btn btn-danger" id="modal-confirm-reset-btn">
        <i class="fa-solid fa-rotate-left" aria-hidden="true"></i> Reset
      </button>
    </div>
  </div>
</div>

<!-- ══════════════════════════════════════════════════════════
     GENERIC MODAL TEMPLATE (for dynamic JS modals)
     Pages can clone this template and populate via JS
     ══════════════════════════════════════════════════════════ -->
<template id="modal-template">
  <div class="modal-backdrop" role="dialog" aria-modal="true" style="display:none;">
    <div class="modal">
      <div class="modal-header">
        <div>
          <h2 class="modal-title"></h2>
          <p class="modal-subtitle"></p>
        </div>
        <button class="modal-close" aria-label="Close modal">
          <i class="fa-solid fa-xmark" aria-hidden="true"></i>
        </button>
      </div>
      <div class="modal-body"></div>
      <div class="modal-footer">
        <button class="btn btn-secondary modal-cancel-btn">Cancel</button>
        <button class="btn btn-primary modal-confirm-btn">Confirm</button>
      </div>
    </div>
  </div>
</template>
