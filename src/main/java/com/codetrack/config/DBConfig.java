package com.codetrack.config;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * DBConfig.java — Database Connection Configuration
 * ============================================================
 * Centralizes all database connection settings.
 * Update these values to match your local MySQL setup.
 *
 * IMPORTANT: In production, load these from environment
 * variables or a secure properties file — never hardcode
 * credentials in source control.
 * ============================================================
 */
public final class DBConfig {

    // ── JDBC Driver ──────────────────────────────────────────
    public static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    // ── Database URL ─────────────────────────────────────────
    // Parameters:
    //   useSSL=false           → Disable SSL for local dev
    //   serverTimezone=UTC     → Avoid timezone mismatches
    //   allowPublicKeyRetrieval=true → Required for some MySQL 8 setups
    public static final String URL =
        "jdbc:mysql://localhost:3306/codetrack" +
        "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";

    // ── Credentials ──────────────────────────────────────────
    // TODO: Replace with environment variable reads in production
    public static final String USERNAME = "root";
    public static final String PASSWORD = "your_password_here";

    // ── Connection Pool Settings ──────────────────────────────
    public static final int MAX_POOL_SIZE = 10;
    public static final int CONN_TIMEOUT_MS = 5000;

    // Prevent instantiation — this is a constants class
    private DBConfig() {
        throw new UnsupportedOperationException("DBConfig is a constants class.");
    }
}
