package com.codetrack.model;

import java.time.LocalDateTime;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * User.java — User Model (Entity / POJO)
 * ============================================================
 * Represents a registered user in the system.
 * Maps to the `users` table in the database.
 *
 * Note: password_hash is stored here only during registration
 * and is never sent to JSP views. Always clear before passing
 * to the view layer for security.
 * ============================================================
 */
public class User {

    // ── Fields ───────────────────────────────────────────────
    private int             id;
    private String          username;
    private String          email;
    private String          passwordHash;   // BCrypt hash — never expose to views
    private String          fullName;
    private String          avatarUrl;
    private String          bio;
    private String          role;           // "USER" | "ADMIN"
    private boolean         active;
    private boolean         emailVerified;
    private LocalDateTime   lastLoginAt;
    private LocalDateTime   createdAt;
    private LocalDateTime   updatedAt;

    // ── Constructors ─────────────────────────────────────────

    /** Default no-arg constructor (required for JDBC mapping). */
    public User() {}

    /** Convenience constructor for registration. */
    public User(String username, String email, String passwordHash, String fullName) {
        this.username     = username;
        this.email        = email;
        this.passwordHash = passwordHash;
        this.fullName     = fullName;
        this.role         = "USER";
        this.active       = true;
    }

    // ── Getters & Setters ─────────────────────────────────────

    public int getId()                          { return id; }
    public void setId(int id)                   { this.id = id; }

    public String getUsername()                 { return username; }
    public void setUsername(String username)    { this.username = username; }

    public String getEmail()                    { return email; }
    public void setEmail(String email)          { this.email = email; }

    public String getPasswordHash()             { return passwordHash; }
    public void setPasswordHash(String h)       { this.passwordHash = h; }

    public String getFullName()                 { return fullName; }
    public void setFullName(String fullName)    { this.fullName = fullName; }

    public String getAvatarUrl()                { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl)  { this.avatarUrl = avatarUrl; }

    public String getBio()                      { return bio; }
    public void setBio(String bio)              { this.bio = bio; }

    public String getRole()                     { return role; }
    public void setRole(String role)            { this.role = role; }

    public boolean isActive()                   { return active; }
    public void setActive(boolean active)       { this.active = active; }

    public boolean isEmailVerified()            { return emailVerified; }
    public void setEmailVerified(boolean v)     { this.emailVerified = v; }

    public LocalDateTime getLastLoginAt()       { return lastLoginAt; }
    public void setLastLoginAt(LocalDateTime t) { this.lastLoginAt = t; }

    public LocalDateTime getCreatedAt()         { return createdAt; }
    public void setCreatedAt(LocalDateTime t)   { this.createdAt = t; }

    public LocalDateTime getUpdatedAt()         { return updatedAt; }
    public void setUpdatedAt(LocalDateTime t)   { this.updatedAt = t; }

    // ── Utility ───────────────────────────────────────────────

    /** Returns display name: fullName if set, otherwise username. */
    public String getDisplayName() {
        return (fullName != null && !fullName.isBlank()) ? fullName : username;
    }

    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(this.role);
    }

    @Override
    public String toString() {
        return "User{id=" + id + ", username='" + username + "', email='" + email + "', role='" + role + "'}";
    }
}
