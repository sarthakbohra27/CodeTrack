package com.codetrack.dao;

import com.codetrack.model.User;
import java.util.List;
import java.util.Optional;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * UserDAO.java — User Data Access Object Interface
 * ============================================================
 * Defines the contract for all User-related database operations.
 * Implementations will use JDBC to interact with MySQL.
 *
 * Design Pattern: DAO (Data Access Object)
 *   - Decouples business logic from persistence logic
 *   - Enables easy swapping of data sources (JDBC → ORM, etc.)
 * ============================================================
 */
public interface UserDAO {

    /**
     * Inserts a new user into the database.
     *
     * @param user The user to create (password must already be hashed).
     * @return The generated user ID, or -1 on failure.
     */
    int create(User user);

    /**
     * Retrieves a user by their unique database ID.
     *
     * @param id The user's primary key.
     * @return An Optional containing the user, or empty if not found.
     */
    Optional<User> findById(int id);

    /**
     * Retrieves a user by their username.
     *
     * @param username The unique username.
     * @return An Optional containing the user, or empty if not found.
     */
    Optional<User> findByUsername(String username);

    /**
     * Retrieves a user by their email address.
     *
     * @param email The unique email.
     * @return An Optional containing the user, or empty if not found.
     */
    Optional<User> findByEmail(String email);

    /**
     * Returns all registered users. (Admin use only)
     *
     * @return A list of all users.
     */
    List<User> findAll();

    /**
     * Updates an existing user's profile information.
     *
     * @param user The user object with updated fields.
     * @return true if the update was successful.
     */
    boolean update(User user);

    /**
     * Updates a user's password hash.
     *
     * @param userId      The user's ID.
     * @param newHashedPw The new BCrypt-hashed password.
     * @return true if the update was successful.
     */
    boolean updatePassword(int userId, String newHashedPw);

    /**
     * Soft-deletes a user by setting is_active = 0.
     * Prefer this over hard deletion to preserve data integrity.
     *
     * @param userId The user's ID.
     * @return true if the deactivation was successful.
     */
    boolean deactivate(int userId);

    /**
     * Checks whether a username is already taken.
     *
     * @param username The username to check.
     * @return true if the username already exists.
     */
    boolean existsByUsername(String username);

    /**
     * Checks whether an email is already registered.
     *
     * @param email The email to check.
     * @return true if the email already exists.
     */
    boolean existsByEmail(String email);
}
