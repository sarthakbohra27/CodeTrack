package com.codetrack.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * ============================================================
 * CodeTrack â€“ DSA Progress Tracker
 * RegisterServlet.java â€” Handles User Registration
 * ============================================================
 * URL Pattern  : /register
 * GET  â†’ Displays the registration page (register.jsp)
 * POST â†’ Processes registration form
 *
 * Validation (TODO):
 *   - Username uniqueness check
 *   - Email uniqueness check
 *   - Password strength validation
 *   - BCrypt password hashing before storage
 * ============================================================
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    /**
     * GET /register â€” Forward to registration page.
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
    }

    /**
     * POST /register â€” Process registration form submission.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // TODO: Implement full registration logic:
        //  1. Validate all input fields (server-side)
        //  2. Check username and email uniqueness via UserDAO
        //  3. Hash password with BCrypt
        //  4. Create User object and call UserDAO.create()
        //  5. Create default UserSettings row
        //  6. Redirect to login with success message

        String username  = req.getParameter("username");
        String email     = req.getParameter("email");
        String password  = req.getParameter("password");
        String fullName  = req.getParameter("fullName");

        // Placeholder response
        req.setAttribute("error", "Registration functionality coming soon.");
        req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
    }
}

