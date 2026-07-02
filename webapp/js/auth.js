/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * auth.js — Login and Register Page Interactions
 * ============================================================
 * Handles: loading states, social login placeholders,
 * and form animation.
 * ============================================================
 */

'use strict';

document.addEventListener('DOMContentLoaded', () => {

    // ── Submit Button Loading State ───────────────────────────
    const forms = document.querySelectorAll('#loginForm, #registerForm');
    forms.forEach(form => {
        form.addEventListener('submit', () => {
            const btn  = form.querySelector('[type="submit"]');
            const text = btn?.querySelector('.btn-text');
            if (!btn || !text) return;

            btn.disabled    = true;
            text.textContent = 'Please wait…';
            btn.insertAdjacentHTML('beforeend', '<i class="fa-solid fa-spinner fa-spin"></i>');
        });
    });

    // ── Social Login Placeholder Messages ─────────────────────
    document.getElementById('githubLoginBtn')?.addEventListener('click', () => {
        CodeTrack.toast('GitHub OAuth coming soon!', 'info');
    });
    document.getElementById('googleLoginBtn')?.addEventListener('click', () => {
        CodeTrack.toast('Google OAuth coming soon!', 'info');
    });

    // ── Animate form entrance ─────────────────────────────────
    document.querySelector('.auth-form-card')?.classList.add('animate-fade-in-up');
});
