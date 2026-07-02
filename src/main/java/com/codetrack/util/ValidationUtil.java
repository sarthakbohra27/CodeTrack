package com.codetrack.util;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * ValidationUtil.java — Input Validation Helpers
 * ============================================================
 * Provides static methods for validating user inputs
 * on the server side (never rely on client-side only).
 * ============================================================
 */
public final class ValidationUtil {

    private static final int USERNAME_MIN = 3;
    private static final int USERNAME_MAX = 50;
    private static final int PASSWORD_MIN = 8;

    private static final String EMAIL_REGEX    = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
    private static final String USERNAME_REGEX = "^[A-Za-z0-9_.-]{3,50}$";

    private ValidationUtil() {}

    /** Returns true if the string is null or blank. */
    public static boolean isBlank(String s) {
        return s == null || s.isBlank();
    }

    /** Returns true if the email format is valid. */
    public static boolean isValidEmail(String email) {
        return !isBlank(email) && email.matches(EMAIL_REGEX);
    }

    /** Returns true if the username follows allowed character rules. */
    public static boolean isValidUsername(String username) {
        return !isBlank(username) && username.matches(USERNAME_REGEX);
    }

    /** Returns true if the password meets minimum length requirements. */
    public static boolean isValidPassword(String password) {
        return !isBlank(password) && password.length() >= PASSWORD_MIN;
    }

    /**
     * Sanitizes a string input by trimming whitespace.
     * Additional XSS sanitization would be added here.
     */
    public static String sanitize(String input) {
        if (input == null) return "";
        return input.trim();
    }

    /** Returns true if the string is a valid positive integer. */
    public static boolean isPositiveInt(String value) {
        try {
            return Integer.parseInt(value) > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
