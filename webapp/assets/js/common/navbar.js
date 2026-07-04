/**
 * ============================================================
 * CodeTrack – Navbar JS
 * Handles: hamburger toggle, scroll shadow, smooth scroll,
 *          active link highlighting by scroll position
 * ============================================================
 */
(function () {
  'use strict';

  document.addEventListener('DOMContentLoaded', function () {

    var navbar     = document.getElementById('main-navbar');
    var hamburger  = document.getElementById('navbar-hamburger');
    var mobileMenu = document.getElementById('navbar-mobile-menu');

    /* ── Hamburger toggle ───────────────────────────────── */
    if (hamburger && mobileMenu) {
      hamburger.addEventListener('click', function () {
        var isOpen = mobileMenu.classList.toggle('open');
        hamburger.classList.toggle('open', isOpen);
        hamburger.setAttribute('aria-expanded', isOpen.toString());
        document.body.style.overflow = isOpen ? 'hidden' : '';
      });

      /* Close on mobile link click */
      mobileMenu.querySelectorAll('.navbar-mobile-link').forEach(function (link) {
        link.addEventListener('click', closeMenu);
      });

      /* Close on outside click */
      document.addEventListener('click', function (e) {
        if (!navbar.contains(e.target) && !mobileMenu.contains(e.target)) {
          closeMenu();
        }
      });

      /* Close on Escape */
      document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') closeMenu();
      });
    }

    function closeMenu() {
      if (!hamburger || !mobileMenu) return;
      mobileMenu.classList.remove('open');
      hamburger.classList.remove('open');
      hamburger.setAttribute('aria-expanded', 'false');
      document.body.style.overflow = '';
    }

    /* ── Scroll shadow ──────────────────────────────────── */
    if (navbar) {
      window.addEventListener('scroll', function () {
        navbar.classList.toggle('scrolled', window.scrollY > 10);
      }, { passive: true });
    }

    /* ── Smooth scroll for anchor links ─────────────────── */
    document.querySelectorAll('a[href*="#"]').forEach(function (anchor) {
      anchor.addEventListener('click', function (e) {
        var href = this.getAttribute('href');
        /* Only smooth-scroll same-page anchors */
        if (!href || href === '#') return;
        var hashIndex = href.indexOf('#');
        if (hashIndex === -1) return;
        var hash    = href.substring(hashIndex);
        var samePage = href.startsWith('#') ||
                       href.startsWith(window.location.pathname + '#');
        if (!samePage) return;

        var target = document.querySelector(hash);
        if (target) {
          e.preventDefault();
          closeMenu();
          var offset = (navbar ? navbar.offsetHeight : 64) + 16;
          window.scrollTo({
            top: target.getBoundingClientRect().top + window.scrollY - offset,
            behavior: 'smooth'
          });
        }
      });
    });

    /* ── Active link by scroll position (landing page) ─── */
    var sections = ['hero', 'features', 'about', 'contact'];
    if (sections.some(function(id) { return document.getElementById(id); })) {
      window.addEventListener('scroll', highlightActiveNav, { passive: true });
      highlightActiveNav();
    }

    function highlightActiveNav() {
      var offset  = (navbar ? navbar.offsetHeight : 64) + 40;
      var scrollY = window.scrollY;
      var active  = sections[0];

      sections.forEach(function (id) {
        var el = document.getElementById(id);
        if (el && el.getBoundingClientRect().top + scrollY - offset <= scrollY) {
          active = id;
        }
      });

      document.querySelectorAll('.navbar-nav-link').forEach(function (link) {
        var href = link.getAttribute('href') || '';
        var isActive = href.includes('#' + active);
        link.classList.toggle('active', isActive);
        link.setAttribute('aria-current', isActive ? 'page' : 'false');
      });
    }

  });
})();
