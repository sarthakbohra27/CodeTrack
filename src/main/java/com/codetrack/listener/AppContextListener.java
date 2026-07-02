package com.codetrack.listener;

import com.codetrack.util.DBUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * AppContextListener.java — Application Lifecycle Listener
 * ============================================================
 * Fired when the Tomcat web application starts and stops.
 *
 * On startup:
 *   - Validates DB connection
 *   - Logs application version info
 *
 * On shutdown:
 *   - Releases resources (if using a connection pool)
 * ============================================================
 */
@WebListener
public class AppContextListener implements ServletContextListener {

    private static final Logger log = LoggerFactory.getLogger(AppContextListener.class);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        log.info("╔══════════════════════════════════════════╗");
        log.info("║  CodeTrack – DSA Progress Tracker        ║");
        log.info("║  Application Starting...                 ║");
        log.info("╚══════════════════════════════════════════╝");

        // Eagerly validate the DB connection on startup
        try {
            DBUtil.getConnection().close();
            log.info("✅ Database connection verified successfully.");
        } catch (Exception e) {
            log.error("❌ Failed to connect to the database on startup!", e);
            // Application will still start, but DB errors will appear at runtime
        }

        // Store app version in the ServletContext for access in JSPs
        sce.getServletContext().setAttribute("appVersion", "1.0.0-SNAPSHOT");
        sce.getServletContext().setAttribute("appName", "CodeTrack");

        log.info("✅ CodeTrack application initialized successfully.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        log.info("CodeTrack application shutting down. Releasing resources...");
        // TODO: If using a connection pool (e.g., HikariCP), shut it down here.
        log.info("CodeTrack shutdown complete.");
    }
}
