/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * filters.js — Question Filters & Sorting
 * ============================================================
 * Manages the filter panel on the Questions page.
 * Filters: Platform, Topic, Difficulty.
 * Sorting: Title, Date, Difficulty.
 * Applied via form submission (GET params) or AJAX.
 * ============================================================
 */

'use strict';

window.CodeTrack = window.CodeTrack || {};

CodeTrack.Filters = {

    init() {
        this.bindFilterEvents();
        this.restoreFiltersFromURL();
    },

    bindFilterEvents() {
        const filterForm = document.getElementById('filterForm');
        filterForm?.addEventListener('submit', (e) => {
            e.preventDefault();
            this.applyFilters();
        });

        const clearBtn = document.getElementById('clearFiltersBtn');
        clearBtn?.addEventListener('click', () => this.clearFilters());

        // Auto-apply on change for select elements
        filterForm?.querySelectorAll('select').forEach(select => {
            select.addEventListener('change', () => this.applyFilters());
        });
    },

    applyFilters() {
        const platform   = document.getElementById('filterPlatform')?.value  || '';
        const topic      = document.getElementById('filterTopic')?.value     || '';
        const difficulty = document.getElementById('filterDifficulty')?.value|| '';
        const sort       = document.getElementById('filterSort')?.value      || '';

        const params = new URLSearchParams();
        if (platform)   params.set('platformId',  platform);
        if (topic)      params.set('topicId',     topic);
        if (difficulty) params.set('difficulty',  difficulty);
        if (sort)       params.set('sort',        sort);

        // Navigate with filters in URL
        window.location.href = `/questions?${params.toString()}`;
    },

    clearFilters() {
        document.querySelectorAll('#filterForm select').forEach(s => s.value = '');
        window.location.href = '/questions';
    },

    /**
     * Pre-fills filter controls based on current URL parameters.
     */
    restoreFiltersFromURL() {
        const params = new URLSearchParams(window.location.search);

        const platformSelect   = document.getElementById('filterPlatform');
        const topicSelect      = document.getElementById('filterTopic');
        const difficultySelect = document.getElementById('filterDifficulty');
        const sortSelect       = document.getElementById('filterSort');

        if (platformSelect   && params.get('platformId'))  platformSelect.value   = params.get('platformId');
        if (topicSelect      && params.get('topicId'))     topicSelect.value      = params.get('topicId');
        if (difficultySelect && params.get('difficulty'))  difficultySelect.value = params.get('difficulty');
        if (sortSelect       && params.get('sort'))        sortSelect.value       = params.get('sort');
    },

    /**
     * Returns the count of active filters.
     */
    getActiveFilterCount() {
        const params = new URLSearchParams(window.location.search);
        const filterKeys = ['platformId', 'topicId', 'difficulty'];
        return filterKeys.filter(k => params.has(k) && params.get(k) !== '').length;
    }
};

document.addEventListener('DOMContentLoaded', () => {
    CodeTrack.Filters.init();

    // Show filter badge count
    const count = CodeTrack.Filters.getActiveFilterCount();
    const badge = document.getElementById('filterBadge');
    if (badge && count > 0) {
        badge.textContent  = count;
        badge.style.display = 'inline-flex';
    }
});
