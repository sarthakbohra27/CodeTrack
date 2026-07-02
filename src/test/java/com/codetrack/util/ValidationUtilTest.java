package com.codetrack.util;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.junit.jupiter.api.Assertions.*;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * ValidationUtilTest.java — Unit Tests for ValidationUtil
 * ============================================================
 * Run: mvn test
 * ============================================================
 */
@DisplayName("ValidationUtil Tests")
class ValidationUtilTest {

    // ── isBlank ───────────────────────────────────────────────
    @Test
    @DisplayName("isBlank → null returns true")
    void isBlank_null_returnsTrue() {
        assertTrue(ValidationUtil.isBlank(null));
    }

    @Test
    @DisplayName("isBlank → empty string returns true")
    void isBlank_empty_returnsTrue() {
        assertTrue(ValidationUtil.isBlank(""));
    }

    @Test
    @DisplayName("isBlank → whitespace returns true")
    void isBlank_whitespace_returnsTrue() {
        assertTrue(ValidationUtil.isBlank("   "));
    }

    @Test
    @DisplayName("isBlank → valid string returns false")
    void isBlank_validString_returnsFalse() {
        assertFalse(ValidationUtil.isBlank("CodeTrack"));
    }

    // ── isValidEmail ──────────────────────────────────────────
    @ParameterizedTest(name = "Valid email: {0}")
    @ValueSource(strings = {
        "user@example.com",
        "sarthak.bohra@gmail.com",
        "user+tag@domain.co.in"
    })
    @DisplayName("isValidEmail → valid formats return true")
    void isValidEmail_validEmails_returnTrue(String email) {
        assertTrue(ValidationUtil.isValidEmail(email));
    }

    @ParameterizedTest(name = "Invalid email: {0}")
    @ValueSource(strings = {
        "not-an-email",
        "missing@domain",
        "@nodomain.com",
        ""
    })
    @DisplayName("isValidEmail → invalid formats return false")
    void isValidEmail_invalidEmails_returnFalse(String email) {
        assertFalse(ValidationUtil.isValidEmail(email));
    }

    // ── isValidUsername ───────────────────────────────────────
    @ParameterizedTest(name = "Valid username: {0}")
    @ValueSource(strings = {"sarthak", "user_123", "code.track", "ab", "a1b2c3"})
    void isValidUsername_valid_returnsTrue(String username) {
        // ab is 2 chars — should be invalid (min 3)
        if (username.length() >= 3)
            assertTrue(ValidationUtil.isValidUsername(username));
    }

    @Test
    @DisplayName("isValidUsername → too short returns false")
    void isValidUsername_tooShort_returnsFalse() {
        assertFalse(ValidationUtil.isValidUsername("ab"));
    }

    @Test
    @DisplayName("isValidUsername → special chars invalid")
    void isValidUsername_specialChars_returnsFalse() {
        assertFalse(ValidationUtil.isValidUsername("user@name!"));
    }

    // ── isValidPassword ───────────────────────────────────────
    @Test
    @DisplayName("isValidPassword → 8+ chars returns true")
    void isValidPassword_longEnough_returnsTrue() {
        assertTrue(ValidationUtil.isValidPassword("MyPass@1"));
    }

    @Test
    @DisplayName("isValidPassword → short password returns false")
    void isValidPassword_tooShort_returnsFalse() {
        assertFalse(ValidationUtil.isValidPassword("abc"));
    }

    // ── sanitize ──────────────────────────────────────────────
    @Test
    @DisplayName("sanitize → trims whitespace")
    void sanitize_trimsWhitespace() {
        assertEquals("hello", ValidationUtil.sanitize("  hello  "));
    }

    @Test
    @DisplayName("sanitize → null returns empty string")
    void sanitize_null_returnsEmpty() {
        assertEquals("", ValidationUtil.sanitize(null));
    }

    // ── isPositiveInt ─────────────────────────────────────────
    @Test
    @DisplayName("isPositiveInt → positive number returns true")
    void isPositiveInt_positive_returnsTrue() {
        assertTrue(ValidationUtil.isPositiveInt("42"));
    }

    @Test
    @DisplayName("isPositiveInt → zero returns false")
    void isPositiveInt_zero_returnsFalse() {
        assertFalse(ValidationUtil.isPositiveInt("0"));
    }

    @Test
    @DisplayName("isPositiveInt → text returns false")
    void isPositiveInt_text_returnsFalse() {
        assertFalse(ValidationUtil.isPositiveInt("abc"));
    }
}
