/**
 * ============================================================
 * CodeTrack – Landing Page JavaScript
 * Handles:
 *   1. Scroll Reveal (IntersectionObserver)
 *   2. Counter Animation
 *   3. FAQ Accordion
 *   4. Hero floating elements
 *   5. Smooth scroll enhancements
 * ============================================================
 */
(function () {
  'use strict';

  /* ============================================================
     1. SCROLL REVEAL
  ============================================================ */
  function initScrollReveal() {
    if (!('IntersectionObserver' in window)) {
      // Fallback: just show everything
      document.querySelectorAll('.reveal, .reveal-left').forEach(function (el) {
        el.classList.add('visible');
      });
      return;
    }

    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });

    document.querySelectorAll('.reveal, .reveal-left').forEach(function (el) {
      observer.observe(el);
    });
  }

  /* ============================================================
     2. COUNTER ANIMATION
  ============================================================ */
  function initCounters() {
    var counters = document.querySelectorAll('.count-num');
    if (!counters.length) return;

    if (!('IntersectionObserver' in window)) {
      counters.forEach(function (el) { el.textContent = el.dataset.target; });
      return;
    }

    var counterObserver = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          animateCounter(entry.target);
          counterObserver.unobserve(entry.target);
        }
      });
    }, { threshold: 0.5 });

    counters.forEach(function (el) { counterObserver.observe(el); });
  }

  function animateCounter(el) {
    var target   = parseInt(el.dataset.target, 10);
    var duration = parseInt(el.dataset.duration || '2000', 10);
    var suffix   = el.dataset.suffix || '';
    var start    = 0;
    var startTs  = null;

    function easeOut(t) {
      return 1 - Math.pow(1 - t, 3);
    }

    function step(ts) {
      if (!startTs) startTs = ts;
      var progress = Math.min((ts - startTs) / duration, 1);
      var current  = Math.floor(easeOut(progress) * target);
      el.textContent = current.toLocaleString() + suffix;
      if (progress < 1) requestAnimationFrame(step);
      else el.textContent = target.toLocaleString() + suffix;
    }

    requestAnimationFrame(step);
  }

  /* ============================================================
     3. FAQ ACCORDION
  ============================================================ */
  function initFaq() {
    var items = document.querySelectorAll('.faq-item');

    items.forEach(function (item) {
      var btn    = item.querySelector('.faq-question');
      var answer = item.querySelector('.faq-answer');

      if (!btn || !answer) return;

      btn.addEventListener('click', function () {
        var isOpen = item.classList.contains('open');

        // Close all other items
        items.forEach(function (other) {
          if (other !== item && other.classList.contains('open')) {
            other.classList.remove('open');
            other.querySelector('.faq-question').setAttribute('aria-expanded', 'false');
          }
        });

        // Toggle this item
        item.classList.toggle('open', !isOpen);
        btn.setAttribute('aria-expanded', (!isOpen).toString());
      });
    });
  }

  /* ============================================================
     4. STICKY HEADER SCROLL EFFECT
  ============================================================ */
  function initNavbarScroll() {
    var navbar = document.getElementById('main-navbar');
    if (!navbar) return;

    window.addEventListener('scroll', function () {
      navbar.classList.toggle('scrolled', window.scrollY > 10);
    }, { passive: true });
  }

  /* ============================================================
     5. PLATFORM STRIP — double content for infinite scroll
  ============================================================ */
  function initPlatformStrip() {
    var track = document.querySelector('.platforms-track');
    if (!track) return;

    // Duplicate children for seamless loop
    var items = Array.from(track.children);
    items.forEach(function (item) {
      track.appendChild(item.cloneNode(true));
    });
  }

  /* ============================================================
     6. HERO BADGE ANIMATION (staggered entrance)
  ============================================================ */
  function initHeroFloats() {
    var floats = document.querySelectorAll('.hero-float-badge');
    floats.forEach(function (el, i) {
      el.style.opacity = '0';
      el.style.transform = 'translateY(12px)';
      el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
      setTimeout(function () {
        el.style.opacity = '1';
        el.style.transform = '';
      }, 600 + i * 200);
    });
  }

  /* ============================================================
     7. COMPARISON TABLE ROW HIGHLIGHT
  ============================================================ */
  function initComparisonTable() {
    var rows = document.querySelectorAll('.ct-table tbody tr');
    rows.forEach(function (row) {
      row.addEventListener('mouseenter', function () {
        row.style.transition = 'background 0.15s ease';
      });
    });
  }

  /* ============================================================
     8. SMOOTH SCROLL POLYFILL (for browsers without it)
  ============================================================ */
  function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(function (anchor) {
      anchor.addEventListener('click', function (e) {
        var target = document.querySelector(this.getAttribute('href'));
        if (!target) return;
        e.preventDefault();
        var navbar = document.getElementById('main-navbar');
        var offset = navbar ? navbar.offsetHeight + 16 : 80;
        window.scrollTo({
          top: target.getBoundingClientRect().top + window.scrollY - offset,
          behavior: 'smooth'
        });
      });
    });
  }

  /* ============================================================
     INIT — run all after DOM ready
  ============================================================ */
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  function init() {
    initScrollReveal();
    initCounters();
    initFaq();
    initNavbarScroll();
    initPlatformStrip();
    initHeroFloats();
    initComparisonTable();
    initSmoothScroll();
  }

})();
