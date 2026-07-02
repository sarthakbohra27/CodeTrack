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
 * QuestionServlet.java â€” Question CRUD Controller
 * ============================================================
 * URL Pattern  : /questions
 * Protected    : Yes â€” requires active session
 *
 * GET  /questions          â†’ List all questions (with filters)
 * GET  /questions?id=X     â†’ View single question
 * POST /questions/add      â†’ Add new question
 * POST /questions/edit     â†’ Update question
 * POST /questions/delete   â†’ Delete question
 * POST /questions/favorite â†’ Toggle favorite status
 * ============================================================
 */
@WebServlet(name = "QuestionServlet", urlPatterns = {"/questions", "/questions/*"})
public class QuestionServlet extends HttpServlet {

    /**
     * GET /questions â€” Display questions list with optional filters.
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Read optional filter parameters
        String platformId  = req.getParameter("platformId");
        String topicId     = req.getParameter("topicId");
        String difficulty  = req.getParameter("difficulty");
        String search      = req.getParameter("q");

        // TODO: Call questionDAO.findWithFilters() or questionDAO.searchByTitle()
        //       and set results as request attribute before forwarding

        req.getRequestDispatcher("/pages/questions.jsp").forward(req, resp);
    }

    /**
     * POST /questions â€” Handle sub-actions via a hidden "action" field.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "add"      -> handleAdd(req, resp);
            case "edit"     -> handleEdit(req, resp);
            case "delete"   -> handleDelete(req, resp);
            case "favorite" -> handleFavorite(req, resp);
            default         -> resp.sendRedirect(req.getContextPath() + "/questions");
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO: Parse form fields, create Question object, call questionDAO.create()
        resp.sendRedirect(req.getContextPath() + "/questions");
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO: Parse form fields, call questionDAO.update()
        resp.sendRedirect(req.getContextPath() + "/questions");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO: Read questionId, verify ownership, call questionDAO.delete()
        resp.sendRedirect(req.getContextPath() + "/questions");
    }

    private void handleFavorite(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        // TODO: Toggle favorite flag, return JSON response for AJAX
        resp.setContentType("application/json");
        resp.getWriter().write("{\"status\": \"ok\"}");
    }
}

