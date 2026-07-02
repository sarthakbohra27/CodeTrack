package com.codetrack.model;

import java.time.LocalDateTime;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * Note.java — Note Model (Entity / POJO)
 * ============================================================
 * Represents a user-written note attached to a question.
 * Maps to the `notes` table in the database.
 * ============================================================
 */
public class Note {

    private int           id;
    private int           questionId;
    private int           userId;
    private String        content;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Note() {}

    public Note(int questionId, int userId, String content) {
        this.questionId = questionId;
        this.userId     = userId;
        this.content    = content;
    }

    // ── Getters & Setters ─────────────────────────────────────

    public int getId()                          { return id; }
    public void setId(int id)                   { this.id = id; }

    public int getQuestionId()                  { return questionId; }
    public void setQuestionId(int questionId)   { this.questionId = questionId; }

    public int getUserId()                      { return userId; }
    public void setUserId(int userId)           { this.userId = userId; }

    public String getContent()                  { return content; }
    public void setContent(String content)      { this.content = content; }

    public LocalDateTime getCreatedAt()         { return createdAt; }
    public void setCreatedAt(LocalDateTime t)   { this.createdAt = t; }

    public LocalDateTime getUpdatedAt()         { return updatedAt; }
    public void setUpdatedAt(LocalDateTime t)   { this.updatedAt = t; }

    @Override
    public String toString() {
        return "Note{id=" + id + ", questionId=" + questionId + ", userId=" + userId + "}";
    }
}
