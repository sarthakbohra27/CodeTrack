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
 * CodeTrack – DSA Progress Tracker
 * DashboardServlet.java — Main Dashboard Controller
 * ============================================================
 * URL Pattern : /dashboard
 * Protected   : Yes — redirects to /login if not authenticated
 *
 * Loads and passes to dashboard.jsp:
 *   - Total questions count
 *   - Easy / Medium / Hard breakdown
 *   - Recent questions (last 5)
 *   - Favorite questions count
 *   - Topics covered count
 * ============================================================
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    /**
     * GET /dashboard — Load dashboard data and forward to view.
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Security: verify user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // TODO: Load dashboard data from DAOs:
        //  int userId = ((User) session.getAttribute("loggedInUser")).getId();
        //  int[] difficultyCounts = questionDAO.countByDifficulty(userId);
        //  List<Question> recentQuestions = questionDAO.findAllByUser(userId).stream().limit(5).toList();
        //  req.setAttribute("difficultyCounts", difficultyCounts);
        //  req.setAttribute("recentQuestions", recentQuestions);

        req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
    }
}
