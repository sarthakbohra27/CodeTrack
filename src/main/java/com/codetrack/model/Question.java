package com.codetrack.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * Question.java — Question Model (Entity / POJO)
 * ============================================================
 * Represents a DSA question tracked by a user.
 * Maps to the `questions` table in the database.
 * ============================================================
 */
public class Question {

    // ── Difficulty Enum ───────────────────────────────────────
    public enum Difficulty {
        Easy, Medium, Hard
    }

    // ── Fields ───────────────────────────────────────────────
    private int         id;
    private int         userId;
    private String      title;
    private int         platformId;
    private String      platformName;       // Joined from platforms table
    private Integer     topicId;
    private String      topicName;          // Joined from topics table
    private Difficulty  difficulty;
    private String      questionUrl;
    private String      timeComplexity;
    private String      spaceComplexity;
    private int         attempts;
    private boolean     solved;
    private boolean     favorite;
    private boolean     reviewed;
    private LocalDate   solvedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // ── Constructors ─────────────────────────────────────────

    /** Default no-arg constructor. */
    public Question() {
        this.attempts   = 1;
        this.solved     = true;
        this.difficulty = Difficulty.Medium;
    }

    // ── Getters & Setters ─────────────────────────────────────

    public int getId()                              { return id; }
    public void setId(int id)                       { this.id = id; }

    public int getUserId()                          { return userId; }
    public void setUserId(int userId)               { this.userId = userId; }

    public String getTitle()                        { return title; }
    public void setTitle(String title)              { this.title = title; }

    public int getPlatformId()                      { return platformId; }
    public void setPlatformId(int platformId)       { this.platformId = platformId; }

    public String getPlatformName()                 { return platformName; }
    public void setPlatformName(String name)        { this.platformName = name; }

    public Integer getTopicId()                     { return topicId; }
    public void setTopicId(Integer topicId)         { this.topicId = topicId; }

    public String getTopicName()                    { return topicName; }
    public void setTopicName(String topicName)      { this.topicName = topicName; }

    public Difficulty getDifficulty()               { return difficulty; }
    public void setDifficulty(Difficulty d)         { this.difficulty = d; }
    public void setDifficulty(String d)             { this.difficulty = Difficulty.valueOf(d); }

    public String getQuestionUrl()                  { return questionUrl; }
    public void setQuestionUrl(String url)          { this.questionUrl = url; }

    public String getTimeComplexity()               { return timeComplexity; }
    public void setTimeComplexity(String tc)        { this.timeComplexity = tc; }

    public String getSpaceComplexity()              { return spaceComplexity; }
    public void setSpaceComplexity(String sc)       { this.spaceComplexity = sc; }

    public int getAttempts()                        { return attempts; }
    public void setAttempts(int attempts)           { this.attempts = attempts; }

    public boolean isSolved()                       { return solved; }
    public void setSolved(boolean solved)           { this.solved = solved; }

    public boolean isFavorite()                     { return favorite; }
    public void setFavorite(boolean favorite)       { this.favorite = favorite; }

    public boolean isReviewed()                     { return reviewed; }
    public void setReviewed(boolean reviewed)       { this.reviewed = reviewed; }

    public LocalDate getSolvedAt()                  { return solvedAt; }
    public void setSolvedAt(LocalDate solvedAt)     { this.solvedAt = solvedAt; }

    public LocalDateTime getCreatedAt()             { return createdAt; }
    public void setCreatedAt(LocalDateTime t)       { this.createdAt = t; }

    public LocalDateTime getUpdatedAt()             { return updatedAt; }
    public void setUpdatedAt(LocalDateTime t)       { this.updatedAt = t; }

    // ── Utility ───────────────────────────────────────────────

    /** Returns a CSS badge class corresponding to difficulty level. */
    public String getDifficultyBadgeClass() {
        if (difficulty == null) return "badge-medium";
        return switch (difficulty) {
            case Easy   -> "badge-easy";
            case Medium -> "badge-medium";
            case Hard   -> "badge-hard";
        };
    }

    @Override
    public String toString() {
        return "Question{id=" + id + ", title='" + title + "', difficulty=" + difficulty
               + ", platform='" + platformName + "', topic='" + topicName + "'}";
    }
}
