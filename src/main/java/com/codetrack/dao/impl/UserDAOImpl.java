package com.codetrack.dao.impl;

import com.codetrack.dao.UserDAO;
import com.codetrack.model.User;
import com.codetrack.util.DBUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * UserDAOImpl.java — JDBC Implementation of UserDAO
 * ============================================================
 * Implements all database operations for the User entity
 * using raw JDBC and prepared statements.
 *
 * All methods use try-with-resources to ensure connections
 * and statements are properly closed, preventing resource leaks.
 * ============================================================
 */
public class UserDAOImpl implements UserDAO {

    private static final Logger log = LoggerFactory.getLogger(UserDAOImpl.class);

    // ── SQL Constants ─────────────────────────────────────────
    private static final String SQL_INSERT =
        "INSERT INTO users (username, email, password_hash, full_name, role) VALUES (?, ?, ?, ?, 'USER')";

    private static final String SQL_FIND_BY_ID =
        "SELECT * FROM users WHERE id = ? AND is_active = 1";

    private static final String SQL_FIND_BY_USERNAME =
        "SELECT * FROM users WHERE username = ? AND is_active = 1";

    private static final String SQL_FIND_BY_EMAIL =
        "SELECT * FROM users WHERE email = ? AND is_active = 1";

    private static final String SQL_FIND_ALL =
        "SELECT * FROM users ORDER BY created_at DESC";

    private static final String SQL_UPDATE =
        "UPDATE users SET full_name = ?, bio = ?, avatar_url = ?, updated_at = NOW() WHERE id = ?";

    private static final String SQL_UPDATE_PASSWORD =
        "UPDATE users SET password_hash = ?, updated_at = NOW() WHERE id = ?";

    private static final String SQL_DEACTIVATE =
        "UPDATE users SET is_active = 0, updated_at = NOW() WHERE id = ?";

    private static final String SQL_EXISTS_USERNAME =
        "SELECT COUNT(*) FROM users WHERE username = ?";

    private static final String SQL_EXISTS_EMAIL =
        "SELECT COUNT(*) FROM users WHERE email = ?";

    // ── Create ─────────────────────────────────────────────────

    @Override
    public int create(User user) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPasswordHash());
            ps.setString(4, user.getFullName());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        int generatedId = keys.getInt(1);
                        user.setId(generatedId);
                        log.info("User created with ID: {}", generatedId);
                        return generatedId;
                    }
                }
            }
        } catch (SQLException e) {
            log.error("Error creating user: {}", user.getUsername(), e);
        }
        return -1;
    }

    // ── Read ──────────────────────────────────────────────────

    @Override
    public Optional<User> findById(int id) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_FIND_BY_ID)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return Optional.of(mapRow(rs));
            }
        } catch (SQLException e) {
            log.error("Error finding user by id: {}", id, e);
        }
        return Optional.empty();
    }

    @Override
    public Optional<User> findByUsername(String username) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_FIND_BY_USERNAME)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return Optional.of(mapRow(rs));
            }
        } catch (SQLException e) {
            log.error("Error finding user by username: {}", username, e);
        }
        return Optional.empty();
    }

    @Override
    public Optional<User> findByEmail(String email) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_FIND_BY_EMAIL)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return Optional.of(mapRow(rs));
            }
        } catch (SQLException e) {
            log.error("Error finding user by email: {}", email, e);
        }
        return Optional.empty();
    }

    @Override
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_FIND_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) users.add(mapRow(rs));
        } catch (SQLException e) {
            log.error("Error retrieving all users.", e);
        }
        return users;
    }

    // ── Update ────────────────────────────────────────────────

    @Override
    public boolean update(User user) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getBio());
            ps.setString(3, user.getAvatarUrl());
            ps.setInt(4, user.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            log.error("Error updating user: {}", user.getId(), e);
        }
        return false;
    }

    @Override
    public boolean updatePassword(int userId, String newHashedPw) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE_PASSWORD)) {

            ps.setString(1, newHashedPw);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            log.error("Error updating password for user: {}", userId, e);
        }
        return false;
    }

    // ── Delete / Deactivate ───────────────────────────────────

    @Override
    public boolean deactivate(int userId) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_DEACTIVATE)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            log.error("Error deactivating user: {}", userId, e);
        }
        return false;
    }

    // ── Existence Checks ──────────────────────────────────────

    @Override
    public boolean existsByUsername(String username) {
        return existsCheck(SQL_EXISTS_USERNAME, username);
    }

    @Override
    public boolean existsByEmail(String email) {
        return existsCheck(SQL_EXISTS_EMAIL, email);
    }

    private boolean existsCheck(String sql, String param) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, param);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            log.error("Error in existence check for: {}", param, e);
        }
        return false;
    }

    // ── Row Mapper ─────────────────────────────────────────────

    /**
     * Maps a ResultSet row to a User object.
     * Called internally after every query.
     */
    private User mapRow(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setFullName(rs.getString("full_name"));
        user.setAvatarUrl(rs.getString("avatar_url"));
        user.setBio(rs.getString("bio"));
        user.setRole(rs.getString("role"));
        user.setActive(rs.getBoolean("is_active"));
        user.setEmailVerified(rs.getBoolean("email_verified"));

        Timestamp lastLogin = rs.getTimestamp("last_login_at");
        if (lastLogin != null) user.setLastLoginAt(lastLogin.toLocalDateTime());

        Timestamp created = rs.getTimestamp("created_at");
        if (created != null) user.setCreatedAt(created.toLocalDateTime());

        Timestamp updated = rs.getTimestamp("updated_at");
        if (updated != null) user.setUpdatedAt(updated.toLocalDateTime());

        return user;
    }
}
