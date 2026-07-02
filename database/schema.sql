-- ============================================================
-- CodeTrack – DSA Progress Tracker
-- database/schema.sql
-- Full Database Schema Definition
-- ============================================================
-- Run: mysql -u root -p < database/schema.sql
-- ============================================================

-- Create and select the database
CREATE DATABASE IF NOT EXISTS codetrack
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE codetrack;

-- ─────────────────────────────────────────────────────────────
-- Table: platforms
-- Stores coding platforms (LeetCode, GeeksforGeeks, Codeforces)
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS platforms (
    id          INT             NOT NULL AUTO_INCREMENT,
    name        VARCHAR(100)    NOT NULL UNIQUE,
    base_url    VARCHAR(255)    DEFAULT NULL,
    icon_class  VARCHAR(100)    DEFAULT NULL,   -- Font Awesome icon class
    color_hex   VARCHAR(10)     DEFAULT NULL,   -- Brand color
    is_active   TINYINT(1)      NOT NULL DEFAULT 1,
    created_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ─────────────────────────────────────────────────────────────
-- Table: topics
-- DSA topics (Arrays, Trees, Graphs, DP, etc.)
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS topics (
    id          INT             NOT NULL AUTO_INCREMENT,
    name        VARCHAR(100)    NOT NULL UNIQUE,
    description TEXT            DEFAULT NULL,
    icon_class  VARCHAR(100)    DEFAULT NULL,
    is_active   TINYINT(1)      NOT NULL DEFAULT 1,
    created_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ─────────────────────────────────────────────────────────────
-- Table: users
-- Registered user accounts
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
    id              INT             NOT NULL AUTO_INCREMENT,
    username        VARCHAR(50)     NOT NULL UNIQUE,
    email           VARCHAR(150)    NOT NULL UNIQUE,
    password_hash   VARCHAR(255)    NOT NULL,           -- BCrypt hashed
    full_name       VARCHAR(150)    DEFAULT NULL,
    avatar_url      VARCHAR(255)    DEFAULT NULL,
    bio             TEXT            DEFAULT NULL,
    role            ENUM('USER','ADMIN') NOT NULL DEFAULT 'USER',
    is_active       TINYINT(1)      NOT NULL DEFAULT 1,
    email_verified  TINYINT(1)      NOT NULL DEFAULT 0,
    last_login_at   TIMESTAMP       DEFAULT NULL,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    INDEX idx_users_email    (email),
    INDEX idx_users_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ─────────────────────────────────────────────────────────────
-- Table: questions
-- Solved DSA questions tracked by users
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS questions (
    id              INT             NOT NULL AUTO_INCREMENT,
    user_id         INT             NOT NULL,
    title           VARCHAR(300)    NOT NULL,
    platform_id     INT             NOT NULL,
    topic_id        INT             DEFAULT NULL,
    difficulty      ENUM('Easy','Medium','Hard') NOT NULL DEFAULT 'Medium',
    question_url    VARCHAR(500)    DEFAULT NULL,
    time_complexity VARCHAR(50)     DEFAULT NULL,   -- e.g. O(n log n)
    space_complexity VARCHAR(50)    DEFAULT NULL,   -- e.g. O(n)
    attempts        INT             NOT NULL DEFAULT 1,
    is_solved       TINYINT(1)      NOT NULL DEFAULT 1,
    is_favorite     TINYINT(1)      NOT NULL DEFAULT 0,
    is_reviewed     TINYINT(1)      NOT NULL DEFAULT 0,
    solved_at       DATE            DEFAULT NULL,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (user_id)    REFERENCES users(id)     ON DELETE CASCADE,
    FOREIGN KEY (platform_id) REFERENCES platforms(id) ON DELETE RESTRICT,
    FOREIGN KEY (topic_id)   REFERENCES topics(id)    ON DELETE SET NULL,

    INDEX idx_questions_user        (user_id),
    INDEX idx_questions_platform    (platform_id),
    INDEX idx_questions_topic       (topic_id),
    INDEX idx_questions_difficulty  (difficulty),
    INDEX idx_questions_is_favorite (is_favorite),
    FULLTEXT INDEX ft_questions_title (title)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ─────────────────────────────────────────────────────────────
-- Table: notes
-- User-written notes for each question
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS notes (
    id          INT             NOT NULL AUTO_INCREMENT,
    question_id INT             NOT NULL,
    user_id     INT             NOT NULL,
    content     TEXT            NOT NULL,
    created_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id)     REFERENCES users(id)     ON DELETE CASCADE,

    INDEX idx_notes_question (question_id),
    INDEX idx_notes_user     (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ─────────────────────────────────────────────────────────────
-- Table: user_settings
-- Per-user application preferences
-- ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS user_settings (
    id              INT             NOT NULL AUTO_INCREMENT,
    user_id         INT             NOT NULL UNIQUE,
    theme           ENUM('light','dark','system') NOT NULL DEFAULT 'system',
    default_platform_id INT        DEFAULT NULL,
    daily_goal      INT             NOT NULL DEFAULT 5,  -- questions/day
    email_reminders TINYINT(1)      NOT NULL DEFAULT 0,
    public_profile  TINYINT(1)      NOT NULL DEFAULT 0,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ─────────────────────────────────────────────────────────────
-- View: vw_user_stats
-- Aggregated stats per user for dashboard display
-- ─────────────────────────────────────────────────────────────
CREATE OR REPLACE VIEW vw_user_stats AS
SELECT
    u.id                                                        AS user_id,
    u.username,
    COUNT(q.id)                                                 AS total_solved,
    SUM(CASE WHEN q.difficulty = 'Easy'   THEN 1 ELSE 0 END)   AS easy_count,
    SUM(CASE WHEN q.difficulty = 'Medium' THEN 1 ELSE 0 END)   AS medium_count,
    SUM(CASE WHEN q.difficulty = 'Hard'   THEN 1 ELSE 0 END)   AS hard_count,
    SUM(CASE WHEN q.is_favorite = 1       THEN 1 ELSE 0 END)   AS favorites_count,
    COUNT(DISTINCT q.topic_id)                                  AS topics_covered,
    COUNT(DISTINCT q.platform_id)                               AS platforms_used
FROM users u
LEFT JOIN questions q ON u.id = q.user_id AND q.is_solved = 1
GROUP BY u.id, u.username;
