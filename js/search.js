(function() {
    'use strict';

    const searchInput = document.getElementById('searchInput');
    const searchBtn = document.getElementById('searchBtn');
    const clearBtn = document.getElementById('clearBtn');
    const resultsContainer = document.getElementById('results');
    const noResultsContainer = document.getElementById('noResults');
    const searchStatus = document.getElementById('searchStatus');

    let pizzeriiData = null;
    let isSearching = false;
    let currentQuery = '';

    // ===== NORMALIZATION =====
    function normalize(str) {
        return str.trim().toLowerCase()
            .normalize('NFD').replace(/[\u0300-\u036f]/g, '')
            .replace(/[șş]/g, 's').replace(/[țţ]/g, 't')
            .replace(/[ăâ]/g, 'a').replace(/[î]/g, 'i')
            .replace(/\s+/g, ' ');
    }

    // ===== CREATE SLUG FOR URL =====
    function createSlug(city) {
        return normalize(city).replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
    }

    // ===== INJECT JSON-LD SCHEMA =====
    function injectSchema(pizzerii, city) {
        document.querySelectorAll('script[data-pizzalist-schema]').forEach(el => el.remove());

        if (!pizzerii || pizzerii.length === 0) return;

        const itemList = {
            "@context": "https://schema.org",
            "@type": "ItemList",
            "name": `Cele mai bune pizzerii din ${city}`,
            "description": `Listă cu pizzerii verificate anonim în ${city}, evaluate pe 5 criterii: igienă, calitate, promptitudine, consistență și facilități.`,
            "numberOfItems": pizzerii.length,
            "itemListElement": pizzerii.map((p, index) => {
                const scores = [
                    p.score_igiena || 0,
                    p.score_calitate || 0,
                    p.score_promptitudine || 0,
                    p.score_consistenta || 0,
                    p.score_facilitati || 0
                ];
                const avgScore = scores.reduce((a, b) => a + b, 0) / scores.length;
                const ratingValue = (avgScore / 10) * 5;
                const roundedRating = Math.round(ratingValue * 10) / 10;

                return {
                    "@type": "ListItem",
                    "position": index + 1,
                    "item": {
                        "@type": "LocalBusiness",
                        "name": p.name,
                        "address": {
                            "@type": "PostalAddress",
                            "streetAddress": p.address || '',
                            "addressLocality": p.city,
                            "postalCode": p.postal_code || '',
                            "addressCountry": "RO"
                        },
                        "telephone": p.phone || '',
                        "url": p.website && p.website !== '#' ? p.website : `https://pizzalist.ro/?city=${createSlug(p.city)}`,
                        "image": p.image || '',
                        "description": p.description || '',
                        "aggregateRating": {
                            "@type": "AggregateRating",
                            "ratingValue": roundedRating,
                            "reviewCount": 10,
                            "bestRating": "5",
                            "worstRating": "1"
                        },
                        "openingHours": "Mo-Su 11:00-22:00"
                    }
                };
            })
        };

        const script = document.createElement('script');
        script.setAttribute('data-pizzalist-schema', 'true');
        script.type = 'application/ld+json';
        script.textContent = JSON.stringify(itemList);
        document.head.appendChild(script);
    }

    // ===== LOAD DATA =====
    function loadData() {
        searchStatus.innerHTML = '<div class="loading-spinner"><span class="spinner"></span> Încărcăm baza de date...</div>';
        fetch('data/pizzerii.json')
            .then(res => {
                if (!res.ok) throw new Error('HTTP ' + res.status);
                return res.json();
            })
            .then(data => {
                pizzeriiData = data;
                searchStatus.innerHTML = '';
                searchBtn.disabled = false;
                toggleClearBtn();

                const urlParams = new URLSearchParams(window.location.search);
                const cityParam = urlParams.get('city');
                if (cityParam) {
                    searchInput.value = cityParam;
                    setTimeout(performSearch, 300);
                }
            })
            .catch(err => {
                console.error('Failed to load pizzerii data:', err);
                searchStatus.innerHTML = '<p style="color:#c73b2b;">⚠️ Nu am putut încărca lista de pizzerii. Te rugăm să reîncarci pagina.</p>';
                searchBtn.disabled = true;
            });
    }

    // ===== TOGGLE CLEAR BUTTON =====
    function toggleClearBtn() {
        clearBtn.style.display = searchInput.value.length > 0 ? 'block' : 'none';
    }

    // ===== RENDER RESULTS =====
    function renderResults(pizzerii, query) {
        resultsContainer.style.display = 'none';
        noResultsContainer.style.display = 'none';

        document.querySelectorAll('script[data-pizzalist-schema]').forEach(el => el.remove());

        if (!pizzerii || pizzerii.length === 0) {
            noResultsContainer.style.display = 'block';
            return;
        }

        injectSchema(pizzerii, query);

        resultsContainer.style.display = 'grid';
        resultsContainer.innerHTML = pizzerii.map(p => {
            const statusHtml = p.approved
                ? '<span class="status-medallion approved"><span class="star">⭐</span> Aprobat Pizzalist</span>'
                : '<span class="status-medallion pending">⏳ În așteptare</span>';

            const phone = p.phone ? `<a href="tel:${p.phone}" class="phone-link">📞 Sună</a>` : '';
            const maps = p.address ? `<a href="https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(p.address + ', ' + p.city)}" target="_blank" rel="noopener">🗺️ Hartă</a>` : '';
            const website = p.website && p.website !== '#' ? `<a href="${p.website}" target="_blank" rel="noopener">🌐 Site</a>` : '';
            const video = p.video_url && p.video_url !== '#' ? `<a href="${p.video_url}" target="_blank" rel="noopener">🎥 Video</a>` : '';

            const altText = `Pizza ${p.name} în ${p.city}`;

            return `
                <div class="pizzeria-card">
                    <img class="card-image" src="${p.image || 'https://via.placeholder.com/400x200?text=🍕'}" alt="${altText}" loading="lazy">
                    <div class="card-body">
                        <div class="card-header">
                            <span class="card-name">${p.name}</span>
                            ${statusHtml}
                        </div>
                        <div class="card-address">📍 ${p.address}, ${p.city} (${p.postal_code})</div>
                        ${p.description ? `<p class="card-description">${p.description}</p>` : ''}
                        <div class="card-actions">
                            ${phone}
                            ${maps}
                            ${website}
                            ${video}
                        </div>
                    </div>
                </div>
            `;
        }).join('');
    }

    // ===== PERFORM SEARCH (FIXED) =====
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

            filtered.sort((a, b) => {
                if (a.approved && !b.approved) return -1;
                if (!a.approved && b.approved) return 1;
                return a.name.localeCompare(b.name);
            });

            let cityForUrl = rawQuery.trim();
            if (filtered.length > 0) {
                cityForUrl = filtered[0].city;
            }
            const slug = createSlug(cityForUrl);
            const newUrl = window.location.pathname + '?city=' + encodeURIComponent(slug);
            window.history.pushState({ city: cityForUrl }, '', newUrl);

            renderResults(filtered, cityForUrl);

            const count = filtered.length;

            // ✅ SUCCESS MESSAGE – STAYS VISIBLE
            if (count > 0) {
                searchStatus.innerHTML = `<p style="color:#1e9b6f;">✅ Am găsit ${count} pizzerii în această zonă.</p>`;
            }

            searchBtn.textContent = '🔍 Găsește Pizzerii';
            searchBtn.disabled = false;
            isSearching = false;
            currentQuery = rawQuery;
        }, 300);
    }

    // ===== EVENT LISTENERS =====
    searchBtn.addEventListener('click', performSearch);

    searchInput.addEventListener('keydown', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            performSearch();
        }
    });

    searchInput.addEventListener('input', function() {
        toggleClearBtn();
        if (!this.value.trim()) {
            resultsContainer.style.display = 'none';
            noResultsContainer.style.display = 'none';
            searchStatus.innerHTML = '';
            document.querySelectorAll('script[data-pizzalist-schema]').forEach(el => el.remove());
            const cleanUrl = window.location.pathname;
            window.history.pushState({}, '', cleanUrl);
        }
    });

    clearBtn.addEventListener('click', function() {
        searchInput.value = '';
        searchInput.focus();
        toggleClearBtn();
        resultsContainer.style.display = 'none';
        noResultsContainer.style.display = 'none';
        searchStatus.innerHTML = '';
        document.querySelectorAll('script[data-pizzalist-schema]').forEach(el => el.remove());
        const cleanUrl = window.location.pathname;
        window.history.pushState({}, '', cleanUrl);
    });

    document.querySelectorAll('.search-hint span').forEach(span => {
        span.addEventListener('click', function() {
            searchInput.value = this.textContent.trim();
            toggleClearBtn();
            performSearch();
        });
    });

    // ===== HANDLE BROWSER BACK/FORWARD =====
    window.addEventListener('popstate', function(e) {
        const urlParams = new URLSearchParams(window.location.search);
        const cityParam = urlParams.get('city');
        if (cityParam) {
            searchInput.value = cityParam;
            setTimeout(performSearch, 100);
        } else {
            searchInput.value = '';
            resultsContainer.style.display = 'none';
            noResultsContainer.style.display = 'none';
            searchStatus.innerHTML = '';
            document.querySelectorAll('script[data-pizzalist-schema]').forEach(el => el.remove());
        }
    });

    // ===== INIT =====
    loadData();

})();
