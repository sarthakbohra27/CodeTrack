/**
 * CodeTrack - Login Form Logic
 * Handles real-time validation, password toggle, and loading simulation.
 */

document.addEventListener('DOMContentLoaded', () => {
  const loginForm = document.getElementById('loginForm');
  if (!loginForm) return;

  const emailInput = document.getElementById('email');
  const passwordInput = document.getElementById('password');
  const submitBtn = document.getElementById('loginSubmitBtn');
  const passwordToggleBtn = document.getElementById('passwordToggleBtn');

  // --- Regex Patterns ---
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  // --- Password Visibility Toggle ---
  if (passwordToggleBtn && passwordInput) {
    passwordToggleBtn.addEventListener('click', () => {
      const icon = passwordToggleBtn.querySelector('i');
      if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        passwordInput.classList.add('password-visible');
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
      } else {
        passwordInput.type = 'password';
        passwordInput.classList.remove('password-visible');
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
      }
    });
  }

  // --- Validation Functions ---
  const setInvalid = (inputElement, errorTextElement, message) => {
    inputElement.classList.remove('is-valid');
    inputElement.classList.add('is-invalid');
    if (errorTextElement) {
      errorTextElement.textContent = message;
    }
  };

  const setValid = (inputElement) => {
    inputElement.classList.remove('is-invalid');
    inputElement.classList.add('is-valid');
  };

  const clearValidation = (inputElement) => {
    inputElement.classList.remove('is-invalid', 'is-valid');
  };

  const validateEmail = () => {
    const errorText = emailInput.parentElement.querySelector('.login-error-text');
    const val = emailInput.value.trim();
    if (!val) {
      setInvalid(emailInput, errorText, 'Email is required');
      return false;
    } else if (!emailRegex.test(val)) {
      setInvalid(emailInput, errorText, 'Please enter a valid email address');
      return false;
    }
    setValid(emailInput);
    return true;
  };

  const validatePassword = () => {
    const errorText = passwordInput.parentElement.parentElement.querySelector('.login-error-text');
    const val = passwordInput.value;
    if (!val) {
      setInvalid(passwordInput, errorText, 'Password is required');
      return false;
    } else if (val.length < 8) {
      setInvalid(passwordInput, errorText, 'Password must be at least 8 characters');
      return false;
    }
    setValid(passwordInput);
    return true;
  };

  // --- Real-time Validation Events ---
  if (emailInput) {
    emailInput.addEventListener('blur', validateEmail);
    emailInput.addEventListener('input', () => {
      if (emailInput.classList.contains('is-invalid') || emailInput.classList.contains('is-valid')) {
        validateEmail();
      }
    });
  }

  if (passwordInput) {
    passwordInput.addEventListener('blur', validatePassword);
    passwordInput.addEventListener('input', () => {
      if (passwordInput.classList.contains('is-invalid') || passwordInput.classList.contains('is-valid')) {
        validatePassword();
      }
    });
  }

  // --- Form Submission ---
  loginForm.addEventListener('submit', (e) => {
    e.preventDefault();

    // Prevent multiple submissions
    if (submitBtn.disabled) return;

    // Validate all
    const isEmailValid = validateEmail();
    const isPasswordValid = validatePassword();

    if (!isEmailValid || !isPasswordValid) {
      // Focus the first invalid field
      if (!isEmailValid) emailInput.focus();
      else passwordInput.focus();
      return;
    }

    // Enter Loading State
    submitBtn.disabled = true;
    submitBtn.classList.add('is-loading');

    // Simulate API Call for 2 seconds
    setTimeout(() => {
      // Enter Success State
      submitBtn.classList.remove('is-loading');
      submitBtn.classList.add('is-success');
      submitBtn.innerHTML = '<i class="fa-solid fa-check"></i> Welcome Back';

      // Simulate Redirect after short delay
      setTimeout(() => {
        // Reset form completely (as a fallback if no actual redirect)
        submitBtn.disabled = false;
        submitBtn.classList.remove('is-success');
        submitBtn.innerHTML = '<span class="btn-text">Sign In</span><i class="fa-solid fa-spinner spinner"></i>';
        loginForm.reset();
        clearValidation(emailInput);
        clearValidation(passwordInput);
        
        // Show toast using global function if available
        if (window.CodeTrack && typeof window.CodeTrack.showToast === 'function') {
          CodeTrack.showToast('Successfully logged in!', 'success');
        }
      }, 1000);
      
    }, 2000);
  });

  // Auto-focus email field on load
  if (emailInput) {
    // Small timeout ensures it focuses even if DOM injection is slightly delayed
    setTimeout(() => {
      emailInput.focus();
    }, 100);
  }
});
