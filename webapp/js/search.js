/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * search.js — Live Search Functionality
 * ============================================================
 * Provides real-time search with debouncing.
 * Sends AJAX GET requests to /questions?q=<term>
 * and updates the table without a page reload.
 *
 * Also handles the global navbar search input.
 * ============================================================
 */

'use strict';

window.CodeTrack = window.CodeTrack || {};

CodeTrack.Search = {

    debounceTimer: null,
    DEBOUNCE_DELAY: 350, // ms

    init() {
        this.setupGlobalSearch();
        this.setupPageSearch();
    },

    // ── Global Navbar Search ──────────────────────────────────
    setupGlobalSearch() {
        const input    = document.getElementById('globalSearchInput');
        const dropdown = document.getElementById('searchDropdown');
        if (!input || !dropdown) return;

        input.addEventListener('input', CodeTrack.debounce(() => {
            const query = input.value.trim();
            if (query.length < 2) {
                dropdown.innerHTML = '';
                dropdown.style.display = 'none';
                return;
            }
            this.fetchSuggestions(query, dropdown);
        }, this.DEBOUNCE_DELAY));

        // Hide on outside click
        document.addEventListener('click', (e) => {
            if (!input.contains(e.target)) dropdown.style.display = 'none';
        });
    },

    fetchSuggestions(query, dropdown) {
        // TODO: Replace with real API call
        // fetch(`/questions?q=${encodeURIComponent(query)}&format=json`)
        //   .then(r => r.json())
        //   .then(data => this.renderSuggestions(data, dropdown));

        // Placeholder response
        dropdown.innerHTML = `<div class="search-placeholder">Search for "<strong>${query}</strong>"</div>`;
        dropdown.style.display = 'block';
    },

    renderSuggestions(results, dropdown) {
        if (!results.length) {
            dropdown.innerHTML = '<div class="search-no-results">No results found</div>';
            dropdown.style.display = 'block';
            return;
        }
        dropdown.innerHTML = results.map(q => `
            <a href="/questions?id=${q.id}" class="search-result-item">
                <span class="sr-title">${q.title}</span>
                <span class="badge badge-${q.difficulty.toLowerCase()}">${q.difficulty}</span>
            </a>
        `).join('');
        dropdown.style.display = 'block';
    },

    // ── Page-level Question Search ────────────────────────────
    setupPageSearch() {
        const input = document.getElementById('questionSearchInput');
        if (!input) return;

        input.addEventListener('input', CodeTrack.debounce((e) => {
            const query = e.target.value.trim().toLowerCase();
            this.filterTableRows(query);
        }, this.DEBOUNCE_DELAY));
    },

    filterTableRows(query) {
        const rows = document.querySelectorAll('#questionsTable tbody tr');
        let visibleCount = 0;

        rows.forEach(row => {
            const title = row.querySelector('.question-title')?.textContent?.toLowerCase() || '';
            const match = !query || title.includes(query);
            row.style.display = match ? '' : 'none';
            if (match) visibleCount++;
        });

        // Show empty state if nothing matches
        const emptyState = document.getElementById('noResultsRow');
        if (emptyState) emptyState.style.display = visibleCount === 0 ? '' : 'none';
    }
};

document.addEventListener('DOMContentLoaded', () => {
    CodeTrack.Search.init();
});
