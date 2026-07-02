package com.codetrack.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Set;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * AuthFilter.java — Authentication Guard Filter
 * ============================================================
 * Intercepts all requests to protected URLs and redirects
 * unauthenticated users to the login page.
 *
 * Public URLs (no auth required):
 *   /login, /register, /index.jsp, /css/*, /js/*, /images/*
 *
 * Protected URLs (session required):
 *   /dashboard, /questions, /analytics, /profile, /settings
 * ============================================================
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    /** URLs that do NOT require authentication. */
    private static final Set<String> PUBLIC_PATHS = Set.of(
        "/login",
        "/register",
        "/index.jsp"
    );

    /** Path prefixes for static resources — always public. */
    private static final Set<String> PUBLIC_PREFIXES = Set.of(
        "/css/", "/js/", "/images/", "/assets/", "/favicon"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  httpReq  = (HttpServletRequest)  request;
        HttpServletResponse httpResp = (HttpServletResponse) response;

        String contextPath = httpReq.getContextPath();
        String requestURI  = httpReq.getRequestURI();
        String path        = requestURI.substring(contextPath.length());

        // Allow static resources and public pages
        if (isPublicResource(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Check for active session
        HttpSession session = httpReq.getSession(false);
        boolean isLoggedIn  = (session != null && session.getAttribute("loggedInUser") != null);

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            httpResp.sendRedirect(contextPath + "/login");
        }
    }

    private boolean isPublicResource(String path) {
        if (PUBLIC_PATHS.contains(path) || path.equals("/")) return true;
        for (String prefix : PUBLIC_PREFIXES) {
            if (path.startsWith(prefix)) return true;
        }
        return false;
    }

    @Override public void init(FilterConfig filterConfig) {}
    @Override public void destroy() {}
}
