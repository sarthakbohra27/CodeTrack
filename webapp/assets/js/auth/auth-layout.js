/**
 * CodeTrack - Shared Authentication Layout Logic
 * Handles interactive elements on the split-screen auth layout.
 */

document.addEventListener('DOMContentLoaded', () => {
  // Theme Toggle Logic specifically for the Auth Topbar
  const themeToggleBtn = document.getElementById('auth-theme-toggle');
  const themeIcon = document.getElementById('auth-theme-icon');

  if (themeToggleBtn && themeIcon) {
    
    // Sync initial state icon
    const updateIcon = (theme) => {
      if (theme === 'dark') {
        themeIcon.className = 'fa-solid fa-moon';
      } else {
        themeIcon.className = 'fa-solid fa-sun';
      }
    };

    // Initial check
    const currentTheme = document.documentElement.getAttribute('data-theme') || 'dark';
    updateIcon(currentTheme);

    // Click handler
    themeToggleBtn.addEventListener('click', () => {
      let theme = document.documentElement.getAttribute('data-theme');
      let newTheme = theme === 'dark' ? 'light' : 'dark';
      
      // Update DOM
      document.documentElement.setAttribute('data-theme', newTheme);
      localStorage.setItem('codetrack-theme', newTheme);
      
      // Update Icon
      updateIcon(newTheme);
    });

    // Listen to changes from other sources if any
    const observer = new MutationObserver((mutations) => {
      mutations.forEach(mutation => {
        if (mutation.attributeName === 'data-theme') {
          updateIcon(document.documentElement.getAttribute('data-theme'));
        }
      });
    });

    observer.observe(document.documentElement, { attributes: true, attributeFilter: ['data-theme'] });
  }
});
