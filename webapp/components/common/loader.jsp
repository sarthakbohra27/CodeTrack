<%-- ============================================================
     CodeTrack – Loader Component
     Usage: <%@ include file="../components/loader.jsp" %>
     Place at top of body. JS auto-hides after load.
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!-- ══════════════════════════════════════════════════════════
     PAGE LOADER (full-screen, removed after window.load)
     ══════════════════════════════════════════════════════════ -->
<div id="page-loader" role="status" aria-label="Loading CodeTrack" aria-live="polite">
  <div class="loader-brand" aria-hidden="true">
    Code<span>Track</span>
  </div>
  <div class="loader-progress" aria-hidden="true">
    <div class="loader-progress-bar"></div>
  </div>
  <span class="sr-only">Loading, please wait…</span>
</div>

<!-- ══════════════════════════════════════════════════════════
     SKELETON CARD TEMPLATE (clone via JS)
     Hidden by default — pages clone this as needed
     ══════════════════════════════════════════════════════════ -->
<template id="skeleton-card-template">
  <div class="skeleton-card" aria-hidden="true">
    <div style="display:flex;align-items:center;gap:var(--space-3);margin-bottom:var(--space-4);">
      <div class="skeleton-circle skeleton" style="width:40px;height:40px;flex-shrink:0;"></div>
      <div style="flex:1;">
        <div class="skeleton-line skeleton h-title w-3-4"></div>
        <div class="skeleton-line skeleton w-1-2" style="margin-bottom:0;"></div>
      </div>
    </div>
    <div class="skeleton-line skeleton w-full"></div>
    <div class="skeleton-line skeleton w-3-4"></div>
    <div class="skeleton-line skeleton w-1-2" style="margin-bottom:0;"></div>
  </div>
</template>

<!-- ══════════════════════════════════════════════════════════
     CONTENT LOADER (inline, for async section refreshes)
     Usage: <div class="content-loader"><div class="spinner spinner-md"></div><span>Loading…</span></div>
     ══════════════════════════════════════════════════════════ -->

<script>
  /* Auto-hide page loader once everything is loaded */
  (function() {
    function hideLoader() {
      var loader = document.getElementById('page-loader');
      if (!loader) return;
      loader.classList.add('hidden');
      setTimeout(function() { loader.style.display = 'none'; }, 400);
    }
    if (document.readyState === 'complete') {
      setTimeout(hideLoader, 300);
    } else {
      window.addEventListener('load', function() {
        setTimeout(hideLoader, 300);
      });
    }
  })();
</script>
