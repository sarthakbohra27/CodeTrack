package com.codetrack.dao;

import com.codetrack.model.Question;
import java.util.List;
import java.util.Optional;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * QuestionDAO.java — Question Data Access Object Interface
 * ============================================================
 * Defines the contract for all Question-related database
 * operations including CRUD, search, filtering, and analytics.
 * ============================================================
 */
public interface QuestionDAO {

    /**
     * Inserts a new question record for a user.
     *
     * @param question The question to save.
     * @return The generated question ID, or -1 on failure.
     */
    int create(Question question);

    /**
     * Retrieves a question by its ID.
     * Joins platform and topic for a fully populated object.
     *
     * @param id The question's primary key.
     * @return An Optional containing the question, or empty if not found.
     */
    Optional<Question> findById(int id);

    /**
     * Retrieves all questions for a specific user (with joins).
     *
     * @param userId The user's ID.
     * @return A list of questions, ordered by created_at DESC.
     */
    List<Question> findAllByUser(int userId);

    /**
     * Searches questions by title keyword for a given user.
     * Uses MySQL FULLTEXT search.
     *
     * @param userId  The user's ID.
     * @param keyword The search term.
     * @return Matching questions.
     */
    List<Question> searchByTitle(int userId, String keyword);

    /**
     * Filters questions for a user by platform, topic, and/or difficulty.
     * All parameters are optional (pass null to skip that filter).
     *
     * @param userId     The user's ID.
     * @param platformId Filter by platform (nullable).
     * @param topicId    Filter by topic (nullable).
     * @param difficulty Filter by difficulty string (nullable).
     * @return Filtered list of questions.
     */
    List<Question> findWithFilters(int userId, Integer platformId, Integer topicId, String difficulty);

    /**
     * Retrieves all favorite questions for a user.
     *
     * @param userId The user's ID.
     * @return A list of favorited questions.
     */
    List<Question> findFavorites(int userId);

    /**
     * Updates an existing question's details.
     *
     * @param question The question object with updated values.
     * @return true if the update affected a row.
     */
    boolean update(Question question);

    /**
     * Toggles the favorite status of a question.
     *
     * @param questionId The question's ID.
     * @param userId     The owner's user ID (for security check).
     * @param favorite   The new favorite status.
     * @return true if the update was successful.
     */
    boolean toggleFavorite(int questionId, int userId, boolean favorite);

    /**
     * Deletes a question by its ID.
     * Verifies ownership using userId before deleting.
     *
     * @param questionId The question to delete.
     * @param userId     The owner's user ID.
     * @return true if deletion was successful.
     */
    boolean delete(int questionId, int userId);

    /**
     * Counts questions by difficulty for a given user.
     * Returns an array: [easyCount, mediumCount, hardCount].
     *
     * @param userId The user's ID.
     * @return int[3] with counts for Easy, Medium, Hard.
     */
    int[] countByDifficulty(int userId);

    /**
     * Counts questions grouped by platform for a given user.
     *
     * @param userId The user's ID.
     * @return A list of Object[] arrays: {platformName, count}.
     */
    List<Object[]> countByPlatform(int userId);

    /**
     * Counts questions grouped by topic for a given user.
     *
     * @param userId The user's ID.
     * @return A list of Object[] arrays: {topicName, count}.
     */
    List<Object[]> countByTopic(int userId);
}
