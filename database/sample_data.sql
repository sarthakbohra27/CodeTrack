-- ============================================================
-- CodeTrack – DSA Progress Tracker
-- database/sample_data.sql
-- Seed / Sample Data for Development & Testing
-- ============================================================
-- Run AFTER schema.sql:
--   mysql -u root -p codetrack < database/sample_data.sql
-- ============================================================

USE codetrack;

-- ─────────────────────────────────────────────────────────────
-- Seed: platforms
-- ─────────────────────────────────────────────────────────────
INSERT INTO platforms (name, base_url, icon_class, color_hex) VALUES
('LeetCode',       'https://leetcode.com',               'fa-brands fa-leetcode',   '#FFA116'),
('GeeksforGeeks',  'https://www.geeksforgeeks.org',       'fa-solid fa-leaf',        '#2F8D46'),
('Codeforces',     'https://codeforces.com',              'fa-solid fa-code',        '#3B5998'),
('HackerRank',     'https://www.hackerrank.com',          'fa-brands fa-hackerrank', '#00EA64'),
('InterviewBit',   'https://www.interviewbit.com',        'fa-solid fa-briefcase',   '#1F8EF1'),
('CodeChef',       'https://www.codechef.com',            'fa-solid fa-utensils',    '#5B4638'),
('AtCoder',        'https://atcoder.jp',                  'fa-solid fa-trophy',      '#3590F3'),
('Other',          NULL,                                  'fa-solid fa-globe',       '#6B7280');


-- ─────────────────────────────────────────────────────────────
-- Seed: topics
-- ─────────────────────────────────────────────────────────────
INSERT INTO topics (name, description) VALUES
('Arrays',              'Array-based problems including sorting and searching'),
('Strings',             'String manipulation and pattern matching'),
('Linked Lists',        'Singly and doubly linked list operations'),
('Stacks',              'Stack data structure and applications'),
('Queues',              'Queue and deque based problems'),
('Trees',               'Binary trees, BST, AVL, and N-ary trees'),
('Graphs',              'Graph traversal, shortest paths, and connectivity'),
('Dynamic Programming', 'Memoization and tabulation optimization techniques'),
('Recursion',           'Recursive problem solving and backtracking'),
('Sorting',             'Comparison and non-comparison sorting algorithms'),
('Searching',           'Binary search and its variants'),
('Hashing',             'Hash maps, sets, and collision handling'),
('Greedy',              'Greedy algorithm design and correctness'),
('Bit Manipulation',    'Bitwise operations and tricks'),
('Heap / Priority Queue','Min-heap and max-heap based problems'),
('Tries',               'Prefix tree implementation and word problems'),
('Sliding Window',      'Fixed and variable size window techniques'),
('Two Pointers',        'Dual-pointer traversal strategies'),
('Divide & Conquer',    'Recursive divide-and-conquer paradigm'),
('Math',                'Number theory and mathematical reasoning');


-- ─────────────────────────────────────────────────────────────
-- Seed: users (password_hash is BCrypt of "Test@1234")
-- ─────────────────────────────────────────────────────────────
INSERT INTO users (username, email, password_hash, full_name, role, is_active, email_verified) VALUES
('sarthak',  'sarthak@example.com', '$2a$12$WQc5Y7TjIHlFHm8N3xQhJuuZlR3JkFfnOlwVcpvBJAx8Mq8J0yxJq', 'Sarthak Bohra', 'ADMIN', 1, 1),
('testuser', 'test@example.com',    '$2a$12$WQc5Y7TjIHlFHm8N3xQhJuuZlR3JkFfnOlwVcpvBJAx8Mq8J0yxJq', 'Test User',     'USER',  1, 1);


-- ─────────────────────────────────────────────────────────────
-- Seed: user_settings
-- ─────────────────────────────────────────────────────────────
INSERT INTO user_settings (user_id, theme, daily_goal) VALUES
(1, 'dark',  5),
(2, 'light', 3);


-- ─────────────────────────────────────────────────────────────
-- Seed: questions (for testuser, user_id = 2)
-- ─────────────────────────────────────────────────────────────
INSERT INTO questions
    (user_id, title, platform_id, topic_id, difficulty, question_url, time_complexity, space_complexity, attempts, is_favorite, solved_at)
VALUES
(2, 'Two Sum',                       1, 12, 'Easy',   'https://leetcode.com/problems/two-sum/',                   'O(n)',      'O(n)',    1, 1, CURDATE()),
(2, 'Longest Substring Without Repeating Characters', 1, 2, 'Medium', 'https://leetcode.com/problems/longest-substring-without-repeating-characters/', 'O(n)', 'O(min(n,m))', 2, 0, CURDATE()),
(2, 'Reverse a Linked List',         2, 3,  'Easy',   'https://www.geeksforgeeks.org/reverse-a-linked-list/',     'O(n)',      'O(1)',    1, 0, CURDATE()),
(2, 'Merge Intervals',               1, 1,  'Medium', 'https://leetcode.com/problems/merge-intervals/',           'O(n log n)','O(n)',   1, 1, CURDATE()),
(2, 'Binary Tree Level Order Traversal', 1, 6, 'Medium', 'https://leetcode.com/problems/binary-tree-level-order-traversal/', 'O(n)', 'O(n)', 1, 0, CURDATE()),
(2, 'Coin Change',                   1, 8,  'Medium', 'https://leetcode.com/problems/coin-change/',               'O(n*m)',    'O(n)',    3, 0, CURDATE()),
(2, 'Maximum Subarray',              1, 1,  'Medium', 'https://leetcode.com/problems/maximum-subarray/',          'O(n)',      'O(1)',    1, 1, CURDATE()),
(2, 'Number of Islands',             1, 7,  'Medium', 'https://leetcode.com/problems/number-of-islands/',         'O(n*m)',    'O(n*m)', 2, 0, CURDATE()),
(2, 'Valid Parentheses',             1, 4,  'Easy',   'https://leetcode.com/problems/valid-parentheses/',         'O(n)',      'O(n)',    1, 0, CURDATE()),
(2, 'Kth Largest Element in Array',  1, 15, 'Medium', 'https://leetcode.com/problems/kth-largest-element-in-an-array/', 'O(n log k)', 'O(k)', 1, 0, CURDATE());


-- ─────────────────────────────────────────────────────────────
-- Seed: notes
-- ─────────────────────────────────────────────────────────────
INSERT INTO notes (question_id, user_id, content) VALUES
(1, 2, 'Use a HashMap to store complement values. Single pass O(n) solution. Classic interview question.'),
(4, 2, 'Sort by start time first. Merge overlapping intervals in a single pass.'),
(6, 2, 'Classic DP. dp[i] = min coins to make amount i. Base case dp[0] = 0, rest = infinity.');
