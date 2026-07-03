<%-- ============================================================
     CodeTrack – Footer Component
     Usage: <%@ include file="../components/footer.jsp" %>
     ============================================================ --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% String ctx = request.getContextPath(); %>

<footer class="footer" role="contentinfo">
  <div class="footer-inner">

    <div class="footer-grid">

      <!-- ── Brand Column ────────────────────────────────── -->
      <div class="footer-brand">
        <a href="<%= ctx %>/pages/index.jsp" class="footer-logo" aria-label="CodeTrack Home">
          <div class="footer-logo-icon" aria-hidden="true">
            <i class="fa-solid fa-code"></i>
          </div>
          <span class="footer-logo-name">Code<span>Track</span></span>
        </a>

        <p class="footer-desc">
          A modern SaaS-style DSA progress tracker. Practice smarter — track
          your LeetCode, GeeksforGeeks &amp; Codeforces journey all in one place.
        </p>

        <!-- Social -->
        <nav class="footer-social" aria-label="Social links">
          <a href="https://github.com/sarthakbohra27/CodeTrack"
             class="footer-social-link"
             target="_blank" rel="noopener noreferrer"
             aria-label="GitHub repository">
            <i class="fa-brands fa-github" aria-hidden="true"></i>
          </a>
          <a href="#" class="footer-social-link" aria-label="Twitter">
            <i class="fa-brands fa-x-twitter" aria-hidden="true"></i>
          </a>
          <a href="#" class="footer-social-link" aria-label="LinkedIn">
            <i class="fa-brands fa-linkedin-in" aria-hidden="true"></i>
          </a>
        </nav>
      </div>

      <!-- ── Quick Links ──────────────────────────────────── -->
      <nav aria-label="Quick links">
        <h3 class="footer-col-title">Product</h3>
        <ul class="footer-links" role="list">
          <li><a href="<%= ctx %>/pages/index.jsp#features">Features</a></li>
          <li><a href="<%= ctx %>/pages/index.jsp#about">About</a></li>
          <li><a href="<%= ctx %>/pages/register.jsp">Get Started</a></li>
          <li><a href="<%= ctx %>/pages/login.jsp">Login</a></li>
        </ul>
      </nav>

      <!-- ── Resources ────────────────────────────────────── -->
      <nav aria-label="Resource links">
        <h3 class="footer-col-title">Resources</h3>
        <ul class="footer-links" role="list">
          <li>
            <a href="https://leetcode.com" target="_blank" rel="noopener noreferrer">
              <i class="fa-solid fa-arrow-up-right-from-square fa-xs" aria-hidden="true"></i>
              LeetCode
            </a>
          </li>
          <li>
            <a href="https://geeksforgeeks.org" target="_blank" rel="noopener noreferrer">
              <i class="fa-solid fa-arrow-up-right-from-square fa-xs" aria-hidden="true"></i>
              GeeksforGeeks
            </a>
          </li>
          <li>
            <a href="https://codeforces.com" target="_blank" rel="noopener noreferrer">
              <i class="fa-solid fa-arrow-up-right-from-square fa-xs" aria-hidden="true"></i>
              Codeforces
            </a>
          </li>
          <li>
            <a href="https://github.com/sarthakbohra27/CodeTrack" target="_blank" rel="noopener noreferrer">
              <i class="fa-brands fa-github fa-xs" aria-hidden="true"></i>
              GitHub Repo
            </a>
          </li>
        </ul>
      </nav>

      <!-- ── Legal ────────────────────────────────────────── -->
      <nav aria-label="Legal links">
        <h3 class="footer-col-title">Legal</h3>
        <ul class="footer-links" role="list">
          <li><a href="#">Privacy Policy</a></li>
          <li><a href="#">Terms of Service</a></li>
          <li><a href="<%= ctx %>/pages/index.jsp#contact">Contact Us</a></li>
        </ul>
      </nav>
    </div>

    <!-- ── Bottom Bar ────────────────────────────────────── -->
    <div class="footer-bottom">
      <p class="footer-copyright">
        &copy; <%= java.time.Year.now().getValue() %> CodeTrack by
        <a href="https://github.com/sarthakbohra27" target="_blank" rel="noopener noreferrer">
          Sarthak Bohra
        </a>. All rights reserved.
      </p>

      <nav class="footer-bottom-links" aria-label="Footer legal links">
        <a href="#">Privacy</a>
        <a href="#">Terms</a>
        <a href="<%= ctx %>/pages/index.jsp#contact">Contact</a>
      </nav>
    </div>

  </div>
</footer>
