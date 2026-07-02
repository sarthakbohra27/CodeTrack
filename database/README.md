# Database Setup — CodeTrack

## Prerequisites
- MySQL 8.0 or higher
- MySQL client or MySQL Workbench

## Quick Setup

```bash
# Step 1: Run the schema (creates DB + all tables)
mysql -u root -p < schema.sql

# Step 2: Load sample data (for development)
mysql -u root -p codetrack < sample_data.sql
```

## Tables Overview

| Table | Description |
|---|---|
| `users` | Registered user accounts with BCrypt-hashed passwords |
| `platforms` | Coding platforms (LeetCode, GFG, Codeforces…) |
| `topics` | DSA topics (Arrays, Trees, DP…) |
| `questions` | User-tracked solved questions |
| `notes` | Per-question user notes |
| `user_settings` | User preferences (theme, daily goal, etc.) |

## Views

| View | Description |
|---|---|
| `vw_user_stats` | Aggregated stats per user for dashboard |

## DB Connection (Java)

Update `src/main/java/com/codetrack/config/DBConfig.java`:

```java
public static final String URL      = "jdbc:mysql://localhost:3306/codetrack?useSSL=false&serverTimezone=UTC";
public static final String USERNAME = "your_db_username";
public static final String PASSWORD = "your_db_password";
```

## ER Diagram

> `../docs/diagrams/er-diagram.png` *(To be added)*

## Test Credentials (Sample Data)

| Username | Email | Password | Role |
|---|---|---|---|
| `sarthak` | sarthak@example.com | `Test@1234` | ADMIN |
| `testuser` | test@example.com | `Test@1234` | USER |
