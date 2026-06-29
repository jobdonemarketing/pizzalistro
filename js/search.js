function performSearch() {
    if (isSearching) return;
    if (!pizzeriiData) {
        searchStatus.innerHTML = '<p style="color:#c73b2b;">⏳ Datele se încarcă. Încearcă din nou în câteva secunde.</p>';
        return;
    }

    const rawQuery = searchInput.value;
    if (!rawQuery.trim()) {
        searchInput.focus();
        searchStatus.innerHTML = '<p style="color:#c73b2b;">Te rugăm să introduci un oraș sau cod poștal.</p>';
        resultsContainer.style.display = 'none';
        noResultsContainer.style.display = 'none';
        document.querySelectorAll('script[data-pizzalist-schema]').forEach(el => el.remove());
        return;
    }

    isSearching = true;
    searchBtn.disabled = true;
    searchBtn.textContent = '⏳ Căutăm...';
    searchStatus.innerHTML = '<div class="loading-spinner"><span class="spinner"></span> Căutăm...</div>';

    setTimeout(() => {
        const query = normalize(rawQuery);

        const filtered = pizzeriiData.filter(p => {
            const cityNorm = normalize(p.city);
            const postalNorm = normalize(p.postal_code);
            return cityNorm.includes(query) || postalNorm.startsWith(query);
        });

        // Sort: Approved first, then alphabetically
        filtered.sort((a, b) => {
            if (a.approved && !b.approved) return -1;
            if (!a.approved && b.approved) return 1;
            return a.name.localeCompare(b.name);
        });

        // Update URL with city param
        let cityForUrl = rawQuery.trim();
        if (filtered.length > 0) {
            cityForUrl = filtered[0].city;
        }
        const slug = createSlug(cityForUrl);
        const newUrl = window.location.pathname + '?city=' + encodeURIComponent(slug);
        window.history.pushState({ city: cityForUrl }, '', newUrl);

        renderResults(filtered, cityForUrl);

        const count = filtered.length;

        // ✅ Show the result message (and keep it visible)
        if (count > 0) {
            searchStatus.innerHTML = `<p style="color:#1e9b6f;">✅ Am găsit ${count} pizzerii în această zonă.</p>`;
        }
        // ❌ DO NOT clear it here

        searchBtn.textContent = '🔍 Găsește Pizzerii';
        searchBtn.disabled = false;
        isSearching = false;
        currentQuery = rawQuery;
    }, 300);
}
