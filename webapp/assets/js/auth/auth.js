/**
 * CodeTrack - Authentication Page Logic
 */

document.addEventListener('DOMContentLoaded', () => {
  // Password Visibility Toggle
  const toggleButtons = document.querySelectorAll('.password-toggle');
  
  toggleButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const input = btn.previousElementSibling;
      const icon = btn.querySelector('i');
      
      if (input && input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
      } else if (input) {
        input.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
      }
    });
  });

  // Basic Form Validation (Simulation for Frontend Phase)
  const authForms = document.querySelectorAll('.auth-form');
  
  authForms.forEach(form => {
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      
      const submitBtn = form.querySelector('.auth-submit');
      const originalText = submitBtn.innerHTML;
      
      // Simulate loading state
      submitBtn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Processing...';
      submitBtn.disabled = true;
      
      // Simulate network request
      setTimeout(() => {
        submitBtn.innerHTML = originalText;
        submitBtn.disabled = false;
        
        // Show success toast (using global CodeTrack namespace from toast.js)
        if (window.CodeTrack && typeof window.CodeTrack.showToast === 'function') {
          CodeTrack.showToast('Login simulated successfully!', 'success');
          
          // Redirect to dashboard after brief delay
          setTimeout(() => {
            const ctx = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1));
            window.location.href = ctx + '/pages/dashboard/dashboard.jsp';
          }, 1000);
        }
      }, 1500);
    });
  });
});
