/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * validation.js — Client-Side Form Validation
 * ============================================================
 * Provides real-time validation feedback on all forms.
 * NOTE: Server-side validation (Java) is the source of truth.
 *       This is only for UX improvement.
 * ============================================================
 */

'use strict';

window.CodeTrack = window.CodeTrack || {};

CodeTrack.Validation = {

    rules: {
        username:  /^[A-Za-z0-9_.-]{3,50}$/,
        email:     /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/,
        password:  /.{8,}/,
        url:       /^https?:\/\/.+/,
    },

    init() {
        this.setupLoginForm();
        this.setupRegisterForm();
        this.setupPasswordToggle();
    },

    // ── Login Form ────────────────────────────────────────────
    setupLoginForm() {
        const form = document.getElementById('loginForm');
        if (!form) return;

        form.addEventListener('submit', (e) => {
            const usernameOrEmail = document.getElementById('usernameOrEmail')?.value.trim();
            const password        = document.getElementById('password')?.value;

            if (!usernameOrEmail || !password) {
                e.preventDefault();
                CodeTrack.toast('Please fill in all required fields.', 'error');
            }
        });
    },

    // ── Register Form ─────────────────────────────────────────
    setupRegisterForm() {
        const form = document.getElementById('registerForm');
        if (!form) return;

        // Real-time username validation
        const usernameInput = document.getElementById('username');
        usernameInput?.addEventListener('input', CodeTrack.debounce(() => {
            const val   = usernameInput.value.trim();
            const valid = this.rules.username.test(val);
            const hint  = document.getElementById('usernameHint');
            if (hint) {
                hint.style.color = valid ? 'var(--clr-success)' : 'var(--clr-error)';
                hint.textContent = valid ? '✓ Username looks good!' : '3–50 chars, letters/numbers/_ only';
            }
            this.setFieldState(usernameInput, valid || val.length === 0);
        }, 400));

        // Real-time password strength
        const passwordInput = document.getElementById('regPassword');
        passwordInput?.addEventListener('input', () => {
            const val      = passwordInput.value;
            const strength = this.getPasswordStrength(val);
            const bar      = document.getElementById('passwordStrength');
            if (bar) bar.setAttribute('data-strength', strength);
        });

        // Confirm password match
        const confirmInput = document.getElementById('confirmPassword');
        confirmInput?.addEventListener('input', () => {
            const match = confirmInput.value === passwordInput?.value;
            this.setFieldState(confirmInput, match || confirmInput.value.length === 0);
        });

        // Email format
        const emailInput = document.getElementById('email');
        emailInput?.addEventListener('blur', () => {
            const valid = this.rules.email.test(emailInput.value);
            if (emailInput.value) this.setFieldState(emailInput, valid);
        });

        // Submit validation
        form.addEventListener('submit', (e) => {
            const errors = this.validateRegisterForm();
            if (errors.length > 0) {
                e.preventDefault();
                CodeTrack.toast(errors[0], 'error');
            }
        });
    },

    validateRegisterForm() {
        const errors = [];
        const username = document.getElementById('username')?.value.trim();
        const email    = document.getElementById('email')?.value.trim();
        const password = document.getElementById('regPassword')?.value;
        const confirm  = document.getElementById('confirmPassword')?.value;
        const terms    = document.getElementById('agreeTerms')?.checked;

        if (!username || !this.rules.username.test(username)) errors.push('Please enter a valid username.');
        if (!email || !this.rules.email.test(email))           errors.push('Please enter a valid email address.');
        if (!password || !this.rules.password.test(password))  errors.push('Password must be at least 8 characters.');
        if (password !== confirm)                               errors.push('Passwords do not match.');
        if (!terms)                                             errors.push('Please agree to the Terms of Service.');

        return errors;
    },

    // ── Password Strength ─────────────────────────────────────
    getPasswordStrength(password) {
        if (!password) return '';
        let score = 0;
        if (password.length >= 8)  score++;
        if (/[A-Z]/.test(password)) score++;
        if (/[0-9]/.test(password)) score++;
        if (/[^A-Za-z0-9]/.test(password)) score++;
        return ['', 'weak', 'fair', 'good', 'strong'][score] || 'weak';
    },

    // ── Field State (red/green border) ────────────────────────
    setFieldState(input, valid) {
        input.style.borderColor = valid
            ? 'var(--clr-success)'
            : 'var(--clr-error)';
    },

    // ── Password Toggle Visibility ────────────────────────────
    setupPasswordToggle() {
        document.querySelectorAll('.toggle-password').forEach(btn => {
            btn.addEventListener('click', () => {
                const wrapper = btn.closest('.input-wrapper');
                const input   = wrapper?.querySelector('input[type="password"], input[type="text"]');
                const icon    = btn.querySelector('i');
                if (!input || !icon) return;

                const isPassword = input.type === 'password';
                input.type       = isPassword ? 'text' : 'password';
                icon.className   = isPassword ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye';
            });
        });
    }
};

// Auto-init on DOM ready
document.addEventListener('DOMContentLoaded', () => {
    CodeTrack.Validation.init();
});
