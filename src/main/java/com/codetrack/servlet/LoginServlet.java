package com.codetrack.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * ============================================================
 * CodeTrack â€“ DSA Progress Tracker
 * LoginServlet.java â€” Handles User Authentication
 * ============================================================
 * URL Pattern  : /login
 * GET  â†’ Displays the login page (login.jsp)
 * POST â†’ Processes login credentials
 *
 * On success: creates session and redirects to /dashboard
 * On failure: returns to login.jsp with error message
 * ============================================================
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    // TODO: Inject UserDAO via DAOFactory when implementing business logic
    // private final UserDAO userDAO = DAOFactory.getUserDAO();

    /**
     * GET /login â€” Forward to login page.
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // If user already has an active session, redirect to dashboard
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        // Forward to login JSP
        req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
    }

    /**
     * POST /login â€” Process login form submission.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // TODO: Implement full login logic:
        //  1. Read username/email and password from request
        //  2. Look up user via UserDAO
        //  3. Verify BCrypt hash
        //  4. Create session and set "loggedInUser" attribute
        //  5. Redirect to dashboard on success

        String usernameOrEmail = req.getParameter("usernameOrEmail");
        String password        = req.getParameter("password");

        // Placeholder â€” redirect back to login with error
        req.setAttribute("error", "Login functionality coming soon.");
        req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
    }
}

