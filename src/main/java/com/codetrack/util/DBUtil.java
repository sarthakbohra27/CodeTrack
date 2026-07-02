package com.codetrack.util;

import com.codetrack.config.DBConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * DBUtil.java — JDBC Connection Utility
 * ============================================================
 * Provides static helper methods for obtaining and releasing
 * database connections.
 *
 * Future Enhancement:
 *   Replace with a connection pool (HikariCP or c3p0)
 *   for better performance under load.
 * ============================================================
 */
public final class DBUtil {

    private static final Logger log = LoggerFactory.getLogger(DBUtil.class);

    // Static initializer: load the JDBC driver once
    static {
        try {
            Class.forName(DBConfig.DRIVER);
            log.info("MySQL JDBC Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            log.error("Failed to load MySQL JDBC Driver.", e);
            throw new ExceptionInInitializerError(e);
        }
    }

    // Prevent instantiation
    private DBUtil() {
        throw new UnsupportedOperationException("DBUtil is a utility class.");
    }

    /**
     * Opens and returns a new database connection.
     *
     * @return A valid {@link Connection} to the codetrack database.
     * @throws SQLException if the connection cannot be established.
     */
    public static Connection getConnection() throws SQLException {
        log.debug("Acquiring DB connection from: {}", DBConfig.URL);
        return DriverManager.getConnection(
            DBConfig.URL,
            DBConfig.USERNAME,
            DBConfig.PASSWORD
        );
    }

    /**
     * Safely closes a database connection.
     * Null-safe — does nothing if {@code conn} is null.
     *
     * @param conn The connection to close.
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                log.debug("DB connection closed.");
            } catch (SQLException e) {
                log.warn("Error while closing DB connection.", e);
            }
        }
    }
}
