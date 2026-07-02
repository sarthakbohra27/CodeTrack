package com.codetrack.dao.impl;

import com.codetrack.dao.QuestionDAO;
import com.codetrack.model.Question;
import com.codetrack.util.DBUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * QuestionDAOImpl.java — JDBC Implementation of QuestionDAO
 * ============================================================
 * Handles all Question database operations using raw JDBC.
 * Uses LEFT JOINs to fetch platform and topic names in a
 * single query for efficiency.
 * ============================================================
 */
public class QuestionDAOImpl implements QuestionDAO {

    private static final Logger log = LoggerFactory.getLogger(QuestionDAOImpl.class);

    // ── Base SELECT with JOINs ─────────────────────────────────
    private static final String BASE_SELECT =
        "SELECT q.*, p.name AS platform_name, t.name AS topic_name " +
        "FROM questions q " +
        "LEFT JOIN platforms p ON q.platform_id = p.id " +
        "LEFT JOIN topics    t ON q.topic_id    = t.id ";

    // ── SQL Constants ─────────────────────────────────────────
    private static final String SQL_INSERT =
        "INSERT INTO questions (user_id, title, platform_id, topic_id, difficulty, " +
        "question_url, time_complexity, space_complexity, attempts, is_solved, is_favorite, solved_at) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String SQL_FIND_BY_ID =
        BASE_SELECT + "WHERE q.id = ?";

    private static final String SQL_FIND_ALL_BY_USER =
        BASE_SELECT + "WHERE q.user_id = ? ORDER BY q.created_at DESC";

    private static final String SQL_SEARCH =
        BASE_SELECT + "WHERE q.user_id = ? AND MATCH(q.title) AGAINST(? IN BOOLEAN MODE)";

    private static final String SQL_FIND_FAVORITES =
        BASE_SELECT + "WHERE q.user_id = ? AND q.is_favorite = 1 ORDER BY q.created_at DESC";

    private static final String SQL_UPDATE =
        "UPDATE questions SET title=?, platform_id=?, topic_id=?, difficulty=?, question_url=?, " +
        "time_complexity=?, space_complexity=?, attempts=?, is_reviewed=?, solved_at=?, updated_at=NOW() " +
        "WHERE id=? AND user_id=?";

    private static final String SQL_TOGGLE_FAVORITE =
        "UPDATE questions SET is_favorite=? WHERE id=? AND user_id=?";

    private static final String SQL_DELETE =
        "DELETE FROM questions WHERE id=? AND user_id=?";

    private static final String SQL_COUNT_BY_DIFFICULTY =
        "SELECT " +
        "SUM(CASE WHEN difficulty='Easy'   THEN 1 ELSE 0 END) AS easy, " +
        "SUM(CASE WHEN difficulty='Medium' THEN 1 ELSE 0 END) AS medium, " +
        "SUM(CASE WHEN difficulty='Hard'   THEN 1 ELSE 0 END) AS hard " +
        "FROM questions WHERE user_id=? AND is_solved=1";

    private static final String SQL_COUNT_BY_PLATFORM =
        "SELECT p.name, COUNT(q.id) AS cnt FROM questions q " +
        "JOIN platforms p ON q.platform_id = p.id " +
        "WHERE q.user_id=? GROUP BY p.name ORDER BY cnt DESC";

    private static final String SQL_COUNT_BY_TOPIC =
        "SELECT t.name, COUNT(q.id) AS cnt FROM questions q " +
        "JOIN topics t ON q.topic_id = t.id " +
        "WHERE q.user_id=? AND q.topic_id IS NOT NULL GROUP BY t.name ORDER BY cnt DESC";

    // ── Create ─────────────────────────────────────────────────

    @Override
    public int create(Question q) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, q.getUserId());
            ps.setString(2, q.getTitle());
            ps.setInt(3, q.getPlatformId());
            setNullableInt(ps, 4, q.getTopicId());
            ps.setString(5, q.getDifficulty().name());
            ps.setString(6, q.getQuestionUrl());
            ps.setString(7, q.getTimeComplexity());
            ps.setString(8, q.getSpaceComplexity());
            ps.setInt(9, q.getAttempts());
            ps.setBoolean(10, q.isSolved());
            ps.setBoolean(11, q.isFavorite());
            ps.setObject(12, q.getSolvedAt());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        int id = keys.getInt(1);
                        q.setId(id);
                        log.info("Question created with ID: {}", id);
                        return id;
                    }
                }
            }
        } catch (SQLException e) {
            log.error("Error creating question: {}", q.getTitle(), e);
        }
        return -1;
    }

    // ── Read ──────────────────────────────────────────────────

    @Override
    public Optional<Question> findById(int id) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_FIND_BY_ID)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return Optional.of(mapRow(rs));
            }
        } catch (SQLException e) {
            log.error("Error finding question by id: {}", id, e);
        }
        return Optional.empty();
    }

    @Override
    public List<Question> findAllByUser(int userId) {
        return executeList(SQL_FIND_ALL_BY_USER, userId);
    }

    @Override
    public List<Question> searchByTitle(int userId, String keyword) {
        List<Question> results = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SEARCH)) {

            ps.setInt(1, userId);
            ps.setString(2, keyword + "*");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) results.add(mapRow(rs));
            }
        } catch (SQLException e) {
            log.error("Error searching questions for user: {} keyword: {}", userId, keyword, e);
        }
        return results;
    }

    @Override
    public List<Question> findWithFilters(int userId, Integer platformId, Integer topicId, String difficulty) {
        // Build dynamic query
        StringBuilder sql = new StringBuilder(BASE_SELECT);
        sql.append("WHERE q.user_id = ? ");
        List<Object> params = new ArrayList<>();
        params.add(userId);

        if (platformId != null) { sql.append("AND q.platform_id = ? "); params.add(platformId); }
        if (topicId    != null) { sql.append("AND q.topic_id    = ? "); params.add(topicId);    }
        if (difficulty != null && !difficulty.isBlank()) {
            sql.append("AND q.difficulty = ? ");
            params.add(difficulty);
        }
        sql.append("ORDER BY q.created_at DESC");

        List<Question> results = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) results.add(mapRow(rs));
            }
        } catch (SQLException e) {
            log.error("Error filtering questions for user: {}", userId, e);
        }
        return results;
    }

    @Override
    public List<Question> findFavorites(int userId) {
        return executeList(SQL_FIND_FAVORITES, userId);
    }

    // ── Update ────────────────────────────────────────────────

    @Override
    public boolean update(Question q) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)) {

            ps.setString(1, q.getTitle());
            ps.setInt(2, q.getPlatformId());
            setNullableInt(ps, 3, q.getTopicId());
            ps.setString(4, q.getDifficulty().name());
            ps.setString(5, q.getQuestionUrl());
            ps.setString(6, q.getTimeComplexity());
            ps.setString(7, q.getSpaceComplexity());
            ps.setInt(8, q.getAttempts());
            ps.setBoolean(9, q.isReviewed());
            ps.setObject(10, q.getSolvedAt());
            ps.setInt(11, q.getId());
            ps.setInt(12, q.getUserId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            log.error("Error updating question: {}", q.getId(), e);
        }
        return false;
    }

    @Override
    public boolean toggleFavorite(int questionId, int userId, boolean favorite) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_TOGGLE_FAVORITE)) {

            ps.setBoolean(1, favorite);
            ps.setInt(2, questionId);
            ps.setInt(3, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            log.error("Error toggling favorite for question: {}", questionId, e);
        }
        return false;
    }

    // ── Delete ─────────────────────────────────────────────────

    @Override
    public boolean delete(int questionId, int userId) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_DELETE)) {

            ps.setInt(1, questionId);
            ps.setInt(2, userId);
            boolean deleted = ps.executeUpdate() > 0;
            if (deleted) log.info("Question {} deleted by user {}", questionId, userId);
            return deleted;
        } catch (SQLException e) {
            log.error("Error deleting question: {}", questionId, e);
        }
        return false;
    }

    // ── Analytics ─────────────────────────────────────────────

    @Override
    public int[] countByDifficulty(int userId) {
        int[] counts = {0, 0, 0}; // [Easy, Medium, Hard]
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_COUNT_BY_DIFFICULTY)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    counts[0] = rs.getInt("easy");
                    counts[1] = rs.getInt("medium");
                    counts[2] = rs.getInt("hard");
                }
            }
        } catch (SQLException e) {
            log.error("Error counting by difficulty for user: {}", userId, e);
        }
        return counts;
    }

    @Override
    public List<Object[]> countByPlatform(int userId) {
        return executeAggregation(SQL_COUNT_BY_PLATFORM, userId);
    }

    @Override
    public List<Object[]> countByTopic(int userId) {
        return executeAggregation(SQL_COUNT_BY_TOPIC, userId);
    }

    // ── Private Helpers ───────────────────────────────────────

    private List<Question> executeList(String sql, int userId) {
        List<Question> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            log.error("Error executing list query for user: {}", userId, e);
        }
        return list;
    }

    private List<Object[]> executeAggregation(String sql, int userId) {
        List<Object[]> result = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    result.add(new Object[]{ rs.getString(1), rs.getInt(2) });
                }
            }
        } catch (SQLException e) {
            log.error("Error executing aggregation for user: {}", userId, e);
        }
        return result;
    }

    private void setNullableInt(PreparedStatement ps, int index, Integer value) throws SQLException {
        if (value != null) ps.setInt(index, value);
        else ps.setNull(index, Types.INTEGER);
    }

    /**
     * Maps a ResultSet row (with platform/topic joins) to a Question object.
     */
    private Question mapRow(ResultSet rs) throws SQLException {
        Question q = new Question();
        q.setId(rs.getInt("id"));
        q.setUserId(rs.getInt("user_id"));
        q.setTitle(rs.getString("title"));
        q.setPlatformId(rs.getInt("platform_id"));
        q.setPlatformName(rs.getString("platform_name"));
        int topicId = rs.getInt("topic_id");
        if (!rs.wasNull()) q.setTopicId(topicId);
        q.setTopicName(rs.getString("topic_name"));
        q.setDifficulty(rs.getString("difficulty"));
        q.setQuestionUrl(rs.getString("question_url"));
        q.setTimeComplexity(rs.getString("time_complexity"));
        q.setSpaceComplexity(rs.getString("space_complexity"));
        q.setAttempts(rs.getInt("attempts"));
        q.setSolved(rs.getBoolean("is_solved"));
        q.setFavorite(rs.getBoolean("is_favorite"));
        q.setReviewed(rs.getBoolean("is_reviewed"));

        Date solvedAt = rs.getDate("solved_at");
        if (solvedAt != null) q.setSolvedAt(solvedAt.toLocalDate());

        Timestamp created = rs.getTimestamp("created_at");
        if (created != null) q.setCreatedAt(created.toLocalDateTime());

        Timestamp updated = rs.getTimestamp("updated_at");
        if (updated != null) q.setUpdatedAt(updated.toLocalDateTime());

        return q;
    }
}
