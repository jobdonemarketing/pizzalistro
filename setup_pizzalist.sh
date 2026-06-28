#!/bin/bash

# ============================================================
#  setup_pizzalist.sh – Generates the full Pizzalist.ro project
#  Run: bash setup_pizzalist.sh
# ============================================================

set -e  # stop on error

echo "📁 Creating folder structure..."
mkdir -p css js data img

# ------------------------------------------------------------
#  index.html
# ------------------------------------------------------------
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pizzalist.ro — Pizzerii Verificate Anonim de Localnici</title>
    <meta name="description" content="Cele mai bune pizzerii din orașul tău, verificate anonim de auditori independenți pe criterii reale: igienă, calitate, promptitudine, consistență și facilități. Fără reclame false.">

    <!-- ========== OPEN GRAPH (SOCIAL SHARING) ========== -->
    <meta property="og:title" content="Pizzalist.ro — Pizzerii Verificate Anonim" />
    <meta property="og:description" content="Evaluări reale pe 5 criterii. Fără reclame plătite." />
    <meta property="og:image" content="https://pizzalist.ro/img/og-image.jpg" />
    <meta property="og:url" content="https://pizzalist.ro" />
    <meta property="og:type" content="website" />

    <!-- ========== FAVICON ========== -->
    <link rel="icon" type="image/png" href="/img/favicon.png" />

    <!-- ========== JSON-LD STRUCTURED DATA ========== -->
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "WebSite",
        "name": "Pizzalist.ro",
        "url": "https://pizzalist.ro",
        "description": "Cele mai bune pizzerii verificate anonim din România.",
        "potentialAction": {
            "@type": "SearchAction",
            "target": "https://pizzalist.ro/?search={search_term_string}",
            "query-input": "required name=search_term_string"
        }
    }
    </script>

    <!-- ========== STYLES ========== -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
</head>
<body>

    <!-- ========== NAVIGATION ========== -->
    <nav class="nav">
        <a href="/" class="nav-logo">
            <span class="slice"></span> Pizzalist.ro
        </a>
        <a href="#search" class="nav-cta">Caută o Pizzerie</a>
    </nav>

    <!-- ========== HERO ========== -->
    <section class="hero">
        <div class="hero-badge">
            <span class="dot"></span> Verificat Anonim de Auditori Independenți
        </div>
        <h1>
            Descoperă <span class="highlight">cele mai bune</span> pizzerii din orașul tău
        </h1>
        <p class="hero-subtitle">
            Fiecare pizzeria este evaluată anonim, pe criterii reale: igienă, calitate, promptitudine, consistență și facilități. Fără comentarii pozitive plătite. Fără excepții. Auditorii noștri filmează experiența cu camere ascunse, iar videoclipurile localurilor care câștigă medalia <strong>„Pizzalist Approved”</strong> sunt disponibile publicului.
        </p>

        <!-- ========== SEARCH ========== -->
        <div class="search-section" id="search">
            <div class="search-wrapper">
                <input
                    type="text"
                    class="search-input"
                    id="searchInput"
                    placeholder="Introdu codul poștal sau orașul tău..."
                    aria-label="Caută după cod poștal sau oraș"
                    autocomplete="on"
                >
                <button class="search-btn" id="searchBtn" aria-label="Caută">
                    🔍 Găsește Pizzerii
                </button>
                <button class="search-clear" id="clearBtn" aria-label="Golește câmpul" style="display:none;">✕</button>
            </div>
            <p class="search-hint">
                De exemplu: <span>010011</span> (București), <span>400001</span> (Cluj-Napoca), sau scrie direct <span>Brașov</span>
            </p>
            <div class="search-status" id="searchStatus" aria-live="polite"></div>
        </div>

        <!-- ========== RESULTS CONTAINER ========== -->
        <div id="results" class="results-grid" style="display:none;"></div>
        <div id="noResults" class="no-results-msg" style="display:none;">
            <p>😕 Nu am găsit pizzerii în această zonă.</p>
            <p class="no-results-cta">
                <a href="/contact.html">📢 Vino ca auditor și adaugă-le tu!</a>
            </p>
        </div>
    </section>

    <!-- ========== HOW IT WORKS ========== -->
    <section class="section">
        <h2 class="section-title">Cum funcționează Pizzalist</h2>
        <p class="section-subtitle">Transparență totală. Zero recenzii false.</p>
        <div class="steps">
            <div class="step-card">
                <div class="step-num">1</div>
                <h4>Inspectăm Anonim</h4>
                <p>Auditori independenți vizitează pizzeriile ca simpli clienți. Comandă, observă, filmează — fără ca personalul să știe.</p>
            </div>
            <div class="step-card">
                <div class="step-num">2</div>
                <h4>Verificăm pe 5 Criterii</h4>
                <p>Igienă (inclusiv personal), calitate ingrediente, promptitudine, consistență și facilități. Aceleași standarde peste tot.</p>
            </div>
            <div class="step-card">
                <div class="step-num">3</div>
                <h4>Publicăm Rezultatul</h4>
                <p>Doar pizzeriile care trec toate cele 5 criterii primesc sigiliul „Pizzalist Approved”. Videoclipurile devin publice. Fără excepții.</p>
            </div>
        </div>
    </section>

    <!-- ========== CRITERIA ========== -->
    <section class="section">
        <h2 class="section-title">Cele 5 Criterii de Evaluare</h2>
        <p class="section-subtitle">Aceleași standarde stricte pentru fiecare pizzeria din rețea.</p>
        <div class="criteria-grid">
            <div class="criteria-card">
                <div class="criteria-icon">🧼</div>
                <h4>Igienă</h4>
                <p>Curățenie în sală, grup sanitar, bucătărie. Igiena personalului: fără miros de transpirație, haine curate, mâini și unghii îngrijite. Igiena personalului de livrare.</p>
            </div>
            <div class="criteria-card">
                <div class="criteria-icon">🍅</div>
                <h4>Calitate</h4>
                <p>Ingrediente proaspete, gust autentic, aluat ușor de digerat, coacere atentă. Calitatea produselor complementare (cafea, suc proaspăt stors etc.).</p>
            </div>
            <div class="criteria-card">
                <div class="criteria-icon">⏱️</div>
                <h4>Promptitudine</h4>
                <p>Timp rezonabil până la preluarea comenzii, servire rapidă pentru comenzi mici/medii/mari. Timp de livrare pentru comenzi online.</p>
            </div>
            <div class="criteria-card">
                <div class="criteria-icon">🔄</div>
                <h4>Consistență</h4>
                <p>Aceeași calitate la vizite repetate (cel puțin o dată la 3 luni). Fără variații majore între audituri.</p>
            </div>
            <div class="criteria-card">
                <div class="criteria-icon">🏠</div>
                <h4>Facilități</h4>
                <p>Confort, atmosferă, accesibilitate, mirosuri plăcute în interior, aspect general îngrijit.</p>
            </div>
        </div>
    </section>

    <!-- ========== TRUST BANNER ========== -->
    <div class="trust-banner">
        <h3>⚠️ Listarea nu se cumpără. Niciodată.</h3>
        <p>
            Pizzeriile apar pe Pizzalist cu statutul lor real. Doar cele care trec absolut toate cele 5 criterii, în audite repetate, pot primi sigiliul <strong>„Pizzalist Approved”</strong> — acordat automat pe baza datelor, nu a banilor.
        </p>
        <span class="seal-demo">🏅 Pizzalist Approved — Doar pe Merit</span>
    </div>

    <!-- ========== CTA ========== -->
    <div class="cta-section">
        <h3>Ești proprietar de pizzerie?</h3>
        <p>
            Revendică-ți pagina și pregătește-te pentru audit. Transparența rămâne totală — nu poți influența rezultatul.
        </p>
        <a href="/contact.html" class="btn-large">Contactează-ne pentru Audit</a>
    </div>

    <!-- ========== FOOTER ========== -->
    <footer class="footer">
        <p>© 2026 <strong>Pizzalist.ro</strong> — Toate evaluările sunt independente și neverificabile de către pizzerii înainte de publicare.</p>
        <p style="margin-top:0.3rem;"><a href="/about.html">Despre noi</a> · <a href="/privacy.html">Confidențialitate</a> · <a href="/contact.html">Contact</a></p>
    </footer>

    <!-- ========== SCRIPTS ========== -->
    <script src="js/search.js"></script>
</body>
</html>
EOF

# ------------------------------------------------------------
#  css/style.css
# ------------------------------------------------------------
cat > css/style.css << 'EOF'
/* ===== RESET & BASE ===== */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Inter', -apple-system, sans-serif;
    background: #fcfaf7;
    color: #1e1e1e;
    line-height: 1.5;
    padding: 0 1.5rem;
}

a {
    color: #c73b2b;
    text-decoration: none;
}
a:hover {
    text-decoration: underline;
}

img {
    max-width: 100%;
    height: auto;
    display: block;
}

/* ===== NAV ===== */
.nav {
    max-width: 1200px;
    margin: 1.5rem auto 0;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem 1.5rem;
    background: #fff;
    border-radius: 60px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
    position: sticky;
    top: 1rem;
    z-index: 100;
}

.nav-logo {
    font-weight: 800;
    font-size: 1.3rem;
    letter-spacing: -0.5px;
    color: #1e1e1e;
    display: flex;
    align-items: center;
    gap: 0.4rem;
}
.nav-logo .slice {
    display: inline-block;
    width: 20px;
    height: 20px;
    background: #c73b2b;
    border-radius: 50% 50% 50% 0;
    transform: rotate(-45deg);
}
.nav-cta {
    background: #1e1e1e;
    color: #fff;
    padding: 0.5rem 1.4rem;
    border-radius: 40px;
    font-weight: 600;
    font-size: 0.9rem;
    transition: background 0.2s;
}
.nav-cta:hover {
    background: #c73b2b;
    text-decoration: none;
}

/* ===== HERO ===== */
.hero {
    max-width: 1200px;
    margin: 2.5rem auto 0;
    text-align: center;
}

.hero-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    background: #eef3f2;
    padding: 0.4rem 1.2rem;
    border-radius: 40px;
    font-size: 0.8rem;
    font-weight: 600;
    color: #1e4a3b;
    margin-bottom: 1.5rem;
}
.hero-badge .dot {
    width: 8px;
    height: 8px;
    background: #1e9b6f;
    border-radius: 50%;
    display: inline-block;
    animation: pulse 1.8s infinite;
}
@keyframes pulse {
    0%, 100% { opacity: 1; transform: scale(1); }
    50% { opacity: 0.4; transform: scale(0.9); }
}

.hero h1 {
    font-size: clamp(2.2rem, 5vw, 3.8rem);
    font-weight: 900;
    letter-spacing: -1px;
    line-height: 1.1;
    max-width: 800px;
    margin: 0 auto 1rem;
}
.hero .highlight {
    color: #c73b2b;
    position: relative;
}
.hero .highlight::after {
    content: '';
    position: absolute;
    left: 0;
    bottom: 2px;
    width: 100%;
    height: 6px;
    background: #fde3de;
    border-radius: 4px;
    z-index: -1;
}

.hero-subtitle {
    max-width: 720px;
    margin: 0 auto 2.5rem;
    color: #3d3d3d;
    font-size: 1.05rem;
    line-height: 1.6;
}

/* ===== SEARCH ===== */
.search-section {
    max-width: 640px;
    margin: 0 auto 2rem;
}

.search-wrapper {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    background: #fff;
    border-radius: 60px;
    padding: 0.3rem 0.3rem 0.3rem 1.5rem;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.06);
    border: 1px solid #eae4de;
    position: relative;
    transition: border 0.2s, box-shadow 0.2s;
}
.search-wrapper:focus-within {
    border-color: #c73b2b;
    box-shadow: 0 8px 30px rgba(199, 59, 43, 0.08);
}

.search-input {
    flex: 1;
    border: none;
    padding: 0.8rem 0;
    font-size: 1rem;
    background: transparent;
    outline: none;
    font-family: inherit;
}

.search-btn {
    background: #c73b2b;
    color: #fff;
    border: none;
    padding: 0.75rem 1.8rem;
    border-radius: 40px;
    font-weight: 700;
    font-size: 0.95rem;
    cursor: pointer;
    transition: background 0.2s, transform 0.1s;
    white-space: nowrap;
}
.search-btn:hover {
    background: #a82f21;
}
.search-btn:active {
    transform: scale(0.96);
}
.search-btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.search-clear {
    background: none;
    border: none;
    font-size: 1.3rem;
    color: #888;
    cursor: pointer;
    padding: 0 0.5rem;
    display: none;
}
.search-clear:hover {
    color: #1e1e1e;
}

.search-hint {
    font-size: 0.85rem;
    color: #6b6b6b;
    margin-top: 0.7rem;
}
.search-hint span {
    background: #f0ebe6;
    padding: 0.2rem 0.8rem;
    border-radius: 20px;
    font-weight: 600;
    color: #1e1e1e;
    cursor: pointer;
    transition: background 0.2s;
}
.search-hint span:hover {
    background: #dcd3cb;
}

.search-status {
    min-height: 2rem;
    margin-top: 0.5rem;
    font-weight: 500;
}

/* ===== RESULTS GRID ===== */
.results-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 2rem;
    max-width: 1200px;
    margin: 2rem auto 0;
    text-align: left;
}

/* ===== PIZZERIA CARD ===== */
.pizzeria-card {
    background: #fff;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
    transition: transform 0.2s, box-shadow 0.2s;
    border: 1px solid #f0ebe6;
    display: flex;
    flex-direction: column;
}
.pizzeria-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.07);
}

.pizzeria-card .card-image {
    width: 100%;
    height: 180px;
    object-fit: cover;
    background: #eae4de;
}

.pizzeria-card .card-body {
    padding: 1.2rem 1.4rem 1.4rem;
    flex: 1;
    display: flex;
    flex-direction: column;
}

.pizzeria-card .card-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 0.5rem;
    margin-bottom: 0.3rem;
}
.pizzeria-card .card-name {
    font-size: 1.2rem;
    font-weight: 700;
    color: #1e1e1e;
}
.pizzeria-card .approved-badge {
    background: #1e9b6f;
    color: #fff;
    font-size: 0.6rem;
    font-weight: 700;
    padding: 0.2rem 0.6rem;
    border-radius: 30px;
    white-space: nowrap;
    letter-spacing: 0.3px;
    text-transform: uppercase;
}

.pizzeria-card .card-address {
    font-size: 0.9rem;
    color: #5a5a5a;
    margin: 0.2rem 0 0.6rem;
}

.pizzeria-card .card-scores {
    display: flex;
    flex-wrap: wrap;
    gap: 0.4rem 0.8rem;
    margin: 0.5rem 0 0.8rem;
    font-size: 0.8rem;
}
.pizzeria-card .score-item {
    display: flex;
    align-items: center;
    gap: 0.3rem;
}
.pizzeria-card .score-bar {
    width: 50px;
    height: 4px;
    background: #eae4de;
    border-radius: 4px;
    overflow: hidden;
}
.pizzeria-card .score-bar .fill {
    height: 100%;
    background: #c73b2b;
    border-radius: 4px;
}
.pizzeria-card .score-item .label {
    color: #5a5a5a;
    font-weight: 500;
}
.pizzeria-card .score-item .value {
    font-weight: 700;
    min-width: 1.2rem;
}

.pizzeria-card .card-actions {
    margin-top: auto;
    display: flex;
    gap: 0.6rem;
    flex-wrap: wrap;
}
.pizzeria-card .card-actions a {
    padding: 0.4rem 1rem;
    border-radius: 30px;
    font-size: 0.8rem;
    font-weight: 600;
    transition: background 0.2s, color 0.2s;
    background: #f5f0eb;
    color: #1e1e1e;
}
.pizzeria-card .card-actions a:hover {
    background: #c73b2b;
    color: #fff;
    text-decoration: none;
}
.pizzeria-card .card-actions .phone-link {
    background: #eef3f2;
    color: #1e4a3b;
}
.pizzeria-card .card-actions .phone-link:hover {
    background: #1e4a3b;
    color: #fff;
}

/* ===== NO RESULTS ===== */
.no-results-msg {
    max-width: 600px;
    margin: 2rem auto;
    padding: 2.5rem 2rem;
    background: #fff;
    border-radius: 24px;
    text-align: center;
    border: 2px dashed #eae4de;
}
.no-results-msg p {
    font-size: 1.2rem;
    color: #3d3d3d;
}
.no-results-cta {
    margin-top: 1rem;
}
.no-results-cta a {
    display: inline-block;
    background: #1e1e1e;
    color: #fff;
    padding: 0.7rem 2rem;
    border-radius: 40px;
    font-weight: 600;
}
.no-results-cta a:hover {
    background: #c73b2b;
    text-decoration: none;
}

/* ===== LOADING SPINNER (inline) ===== */
.loading-spinner {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 0.6rem;
    padding: 2rem 0;
    color: #5a5a5a;
    font-weight: 500;
}
.loading-spinner .spinner {
    width: 24px;
    height: 24px;
    border: 3px solid #eae4de;
    border-top-color: #c73b2b;
    border-radius: 50%;
    animation: spin 0.8s linear infinite;
}
@keyframes spin {
    to { transform: rotate(360deg); }
}

/* ===== SECTIONS (How it works, Criteria) ===== */
.section {
    max-width: 1200px;
    margin: 4rem auto;
    text-align: center;
}
.section-title {
    font-size: clamp(1.8rem, 3vw, 2.6rem);
    font-weight: 800;
    letter-spacing: -0.5px;
}
.section-subtitle {
    color: #5a5a5a;
    font-size: 1.1rem;
    margin-top: 0.2rem;
}

.steps {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 2rem;
    margin-top: 2.5rem;
    text-align: left;
}
.step-card {
    background: #fff;
    padding: 1.8rem 1.5rem;
    border-radius: 20px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
    border: 1px solid #f0ebe6;
}
.step-num {
    font-size: 2.2rem;
    font-weight: 900;
    color: #c73b2b;
    opacity: 0.3;
    margin-bottom: 0.3rem;
}
.step-card h4 {
    font-size: 1.1rem;
    font-weight: 700;
}
.step-card p {
    color: #5a5a5a;
    font-size: 0.95rem;
}

.criteria-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 1.5rem;
    margin-top: 2.5rem;
    text-align: left;
}
.criteria-card {
    background: #fff;
    padding: 1.5rem;
    border-radius: 16px;
    border: 1px solid #f0ebe6;
}
.criteria-icon {
    font-size: 2rem;
    margin-bottom: 0.3rem;
}
.criteria-card h4 {
    font-weight: 700;
}
.criteria-card p {
    font-size: 0.9rem;
    color: #5a5a5a;
}

/* ===== TRUST BANNER ===== */
.trust-banner {
    max-width: 900px;
    margin: 3rem auto;
    background: #1e1e1e;
    color: #fcfaf7;
    padding: 2.5rem 2rem;
    border-radius: 28px;
    text-align: center;
}
.trust-banner h3 {
    font-size: 1.6rem;
    font-weight: 800;
}
.trust-banner p {
    max-width: 600px;
    margin: 0.5rem auto 1.2rem;
    color: #cbcbcb;
}
.seal-demo {
    display: inline-block;
    background: #c73b2b;
    color: #fff;
    padding: 0.4rem 1.6rem;
    border-radius: 40px;
    font-weight: 700;
    font-size: 0.9rem;
}

/* ===== CTA SECTION ===== */
.cta-section {
    max-width: 700px;
    margin: 4rem auto 2rem;
    text-align: center;
    padding: 2.5rem 2rem;
    background: #f5f0eb;
    border-radius: 28px;
}
.cta-section h3 {
    font-size: 1.6rem;
    font-weight: 800;
}
.cta-section p {
    color: #3d3d3d;
    margin: 0.3rem 0 1.5rem;
}
.btn-large {
    display: inline-block;
    background: #c73b2b;
    color: #fff;
    padding: 0.8rem 2.8rem;
    border-radius: 60px;
    font-weight: 700;
    font-size: 1.05rem;
    transition: background 0.2s;
}
.btn-large:hover {
    background: #a82f21;
    text-decoration: none;
}

/* ===== FOOTER ===== */
.footer {
    max-width: 1200px;
    margin: 3rem auto 1.5rem;
    padding-top: 2rem;
    border-top: 1px solid #eae4de;
    text-align: center;
    font-size: 0.9rem;
    color: #5a5a5a;
}
.footer a {
    color: #1e1e1e;
    font-weight: 500;
}
.footer a:hover {
    color: #c73b2b;
}

/* ===== RESPONSIVE ===== */
@media (max-width: 640px) {
    body { padding: 0 1rem; }
    .nav { flex-wrap: wrap; gap: 0.5rem; justify-content: center; }
    .search-wrapper { flex-wrap: wrap; background: transparent; padding: 0; border: none; box-shadow: none; }
    .search-input { background: #fff; padding: 0.8rem 1.2rem; border-radius: 40px; border: 1px solid #eae4de; width: 100%; }
    .search-btn { width: 100%; justify-content: center; padding: 0.9rem; }
    .search-clear { position: absolute; right: 1rem; top: 50%; transform: translateY(-50%); display: none; }
    .search-wrapper:focus-within .search-clear { display: block; }
    .results-grid { grid-template-columns: 1fr; gap: 1.2rem; }
    .pizzeria-card .card-scores { flex-direction: column; gap: 0.2rem; }
    .hero h1 { font-size: 2rem; }
    .trust-banner { padding: 1.8rem 1.2rem; }
}
EOF

# ------------------------------------------------------------
#  js/search.js
# ------------------------------------------------------------
cat > js/search.js << 'EOF'
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

    // ===== NORMALIZATION =====
    function normalize(str) {
        return str.trim().toLowerCase()
            .normalize('NFD').replace(/[\u0300-\u036f]/g, '')
            .replace(/[șş]/g, 's').replace(/[țţ]/g, 't')
            .replace(/[ăâ]/g, 'a').replace(/[î]/g, 'i')
            .replace(/\s+/g, ' ');
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
            })
            .catch(err => {
                console.error('Failed to load pizzerii data:', err);
                searchStatus.innerHTML = '<p style="color:#c73b2b;">⚠️ Nu am putut încărca lista de pizzerii. Te rugăm să reîncarci pagina.</p>';
                searchBtn.disabled = true;
            });
    }

    // ===== TOGGLE CLEAR BUTTON =====
    function toggleClearBtn() {
        if (searchInput.value.length > 0) {
            clearBtn.style.display = 'block';
        } else {
            clearBtn.style.display = 'none';
        }
    }

    // ===== RENDER RESULTS =====
    function renderResults(pizzerii) {
        resultsContainer.style.display = 'none';
        noResultsContainer.style.display = 'none';

        if (!pizzerii || pizzerii.length === 0) {
            noResultsContainer.style.display = 'block';
            return;
        }

        resultsContainer.style.display = 'grid';
        resultsContainer.innerHTML = pizzerii.map(p => {
            const approvedHtml = p.approved
                ? '<span class="approved-badge">🏅 Approved</span>'
                : '';

            const scores = [
                { label: 'Igienă', key: 'score_igiena' },
                { label: 'Calitate', key: 'score_calitate' },
                { label: 'Prompt.', key: 'score_promptitudine' },
                { label: 'Consist.', key: 'score_consistenta' },
                { label: 'Facil.', key: 'score_facilitati' }
            ];

            const scoreHtml = scores.map(s => {
                const val = p[s.key] || 0;
                const pct = (val / 10) * 100;
                return `
                    <div class="score-item">
                        <span class="label">${s.label}</span>
                        <span class="value">${val}</span>
                        <div class="score-bar"><div class="fill" style="width:${pct}%;"></div></div>
                    </div>
                `;
            }).join('');

            const phone = p.phone ? `<a href="tel:${p.phone}" class="phone-link">📞 Sună</a>` : '';
            const maps = p.address ? `<a href="https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(p.address + ', ' + p.city)}" target="_blank" rel="noopener">🗺️ Hartă</a>` : '';
            const website = p.website ? `<a href="${p.website}" target="_blank" rel="noopener">🌐 Site</a>` : '';
            const video = p.video_url && p.video_url !== '#' ? `<a href="${p.video_url}" target="_blank" rel="noopener">🎥 Video</a>` : '';

            return `
                <div class="pizzeria-card">
                    <img class="card-image" src="${p.image || 'https://via.placeholder.com/400x200?text=🍕'}" alt="${p.name}" loading="lazy">
                    <div class="card-body">
                        <div class="card-header">
                            <span class="card-name">${p.name}</span>
                            ${approvedHtml}
                        </div>
                        <div class="card-address">📍 ${p.address}, ${p.city} (${p.postal_code})</div>
                        ${p.description ? `<p style="font-size:0.9rem;color:#5a5a5a;margin:0.2rem 0 0.4rem;">${p.description}</p>` : ''}
                        <div class="card-scores">${scoreHtml}</div>
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

    // ===== PERFORM SEARCH =====
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
                const sumA = (a.score_igiena || 0) + (a.score_calitate || 0) + (a.score_promptitudine || 0) + (a.score_consistenta || 0) + (a.score_facilitati || 0);
                const sumB = (b.score_igiena || 0) + (b.score_calitate || 0) + (b.score_promptitudine || 0) + (b.score_consistenta || 0) + (b.score_facilitati || 0);
                return sumB - sumA;
            });

            renderResults(filtered);

            const count = filtered.length;
            if (count > 0) {
                searchStatus.innerHTML = `<p style="color:#1e9b6f;">✅ Am găsit ${count} pizzerie${count > 1 ? 'ii' : ''} în această zonă.</p>`;
            } else {
                searchStatus.innerHTML = '';
            }

            searchBtn.textContent = '🔍 Găsește Pizzerii';
            searchBtn.disabled = false;
            isSearching = false;
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
        }
    });

    clearBtn.addEventListener('click', function() {
        searchInput.value = '';
        searchInput.focus();
        toggleClearBtn();
        resultsContainer.style.display = 'none';
        noResultsContainer.style.display = 'none';
        searchStatus.innerHTML = '';
    });

    document.querySelectorAll('.search-hint span').forEach(span => {
        span.addEventListener('click', function() {
            searchInput.value = this.textContent.trim();
            toggleClearBtn();
            performSearch();
        });
    });

    loadData();

})();
EOF

# ------------------------------------------------------------
#  data/pizzerii.json
# ------------------------------------------------------------
cat > data/pizzerii.json << 'EOF'
[
    {
        "id": "1",
        "name": "Pizzeria La Mamma",
        "city": "București",
        "postal_code": "010011",
        "address": "Strada Academiei 12",
        "phone": "+40721234567",
        "website": "https://lamamma.ro",
        "image": "https://via.placeholder.com/400x200/FFD1B3/1e1e1e?text=🍕+La+Mamma",
        "score_igiena": 9,
        "score_calitate": 9,
        "score_promptitudine": 8,
        "score_consistenta": 9,
        "score_facilitati": 8,
        "approved": true,
        "video_url": "#",
        "description": "Pizza napoletană autentică, făcută cu făină italiană și mozzarella de bivoliță."
    },
    {
        "id": "2",
        "name": "Pizza & Co.",
        "city": "Cluj-Napoca",
        "postal_code": "400001",
        "address": "Bulevardul Eroilor 21",
        "phone": "+40731234567",
        "website": "https://pizzaco.ro",
        "image": "https://via.placeholder.com/400x200/F7DC6F/1e1e1e?text=🍕+Pizza+%26+Co.",
        "score_igiena": 8,
        "score_calitate": 9,
        "score_promptitudine": 9,
        "score_consistenta": 8,
        "score_facilitati": 7,
        "approved": true,
        "video_url": "#",
        "description": "Atmosferă modernă, ingrediente locale și livrare ultra-rapidă."
    },
    {
        "id": "3",
        "name": "Vesuvio",
        "city": "Timișoara",
        "postal_code": "300001",
        "address": "Piața Victoriei 5",
        "phone": "+40741234567",
        "website": "https://vesuvio.ro",
        "image": "https://via.placeholder.com/400x200/F1948A/1e1e1e?text=🍕+Vesuvio",
        "score_igiena": 7,
        "score_calitate": 8,
        "score_promptitudine": 7,
        "score_consistenta": 8,
        "score_facilitati": 8,
        "approved": false,
        "video_url": "#",
        "description": "Pizza în stil roman, aluat crocant și blat subțire."
    },
    {
        "id": "4",
        "name": "Casa Pizzei",
        "city": "Iași",
        "postal_code": "700001",
        "address": "Strada Lăpușneanu 3",
        "phone": "+40751234567",
        "website": "https://casapizzei.ro",
        "image": "https://via.placeholder.com/400x200/85C1E9/1e1e1e?text=🍕+Casa+Pizzei",
        "score_igiena": 9,
        "score_calitate": 8,
        "score_promptitudine": 8,
        "score_consistenta": 9,
        "score_facilitati": 9,
        "approved": true,
        "video_url": "#",
        "description": "Restaurant de familie cu peste 20 de ani de tradiție în Iași."
    },
    {
        "id": "5",
        "name": "Pizzeria Central",
        "city": "Brașov",
        "postal_code": "500001",
        "address": "Strada Republicii 42",
        "phone": "+40761234567",
        "website": "https://centralpizza.ro",
        "image": "https://via.placeholder.com/400x200/ABEBC6/1e1e1e?text=🍕+Central",
        "score_igiena": 8,
        "score_calitate": 7,
        "score_promptitudine": 9,
        "score_consistenta": 7,
        "score_facilitati": 8,
        "approved": false,
        "video_url": "#",
        "description": "Locație centrală, ideală pentru o pauză rapidă sau o cină în oraș."
    },
    {
        "id": "6",
        "name": "Napoli Original",
        "city": "București",
        "postal_code": "010011",
        "address": "Calea Victoriei 88",
        "phone": "+40771234567",
        "website": "https://napoli.ro",
        "image": "https://via.placeholder.com/400x200/F5B041/1e1e1e?text=🍕+Napoli",
        "score_igiena": 10,
        "score_calitate": 10,
        "score_promptitudine": 9,
        "score_consistenta": 10,
        "score_facilitati": 9,
        "approved": true,
        "video_url": "#",
        "description": "Cel mai bun scor la igienă și calitate. Pizzeria care a stabilit standardul în București."
    },
    {
        "id": "7",
        "name": "Pizza D'Oro",
        "city": "Cluj-Napoca",
        "postal_code": "400001",
        "address": "Strada Mihail Kogălniceanu 18",
        "phone": "+40781234567",
        "website": "https://pizzadoro.ro",
        "image": "https://via.placeholder.com/400x200/D7BDE2/1e1e1e?text=🍕+D%27Oro",
        "score_igiena": 8,
        "score_calitate": 9,
        "score_promptitudine": 8,
        "score_consistenta": 8,
        "score_facilitati": 7,
        "approved": true,
        "video_url": "#",
        "description": "Pizza cu blat dospit 48 de ore și toppinguri premium."
    },
    {
        "id": "8",
        "name": "Forno Vecchio",
        "city": "Brașov",
        "postal_code": "500002",
        "address": "Strada Șirului 7",
        "phone": "+40791234567",
        "website": "https://fornovecchio.ro",
        "image": "https://via.placeholder.com/400x200/EDBB99/1e1e1e?text=🍕+Forno",
        "score_igiena": 9,
        "score_calitate": 9,
        "score_promptitudine": 7,
        "score_consistenta": 9,
        "score_facilitati": 8,
        "approved": true,
        "video_url": "#",
        "description": "Cuptor pe lemne și rețete secrete transmise din generație în generație."
    }
]
EOF

# ------------------------------------------------------------
#  about.html
# ------------------------------------------------------------
cat > about.html << 'EOF'
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Despre noi — Pizzalist.ro</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="/img/favicon.png">
</head>
<body>
    <nav class="nav" style="margin-top:1.5rem;">
        <a href="/" class="nav-logo"><span class="slice"></span> Pizzalist.ro</a>
        <a href="/#search" class="nav-cta">Caută o Pizzerie</a>
    </nav>
    <div style="max-width:800px;margin:4rem auto;padding:0 1.5rem;">
        <h1 style="font-size:2.5rem;font-weight:900;">Despre Pizzalist.ro</h1>
        <p style="font-size:1.2rem;color:#3d3d3d;margin-top:1rem;">
            Pizzalist.ro s-a născut din frustrarea față de recenziile false și reclamele mascate. 
            Credem că o pizza bună se recunoaște prin <strong>igienă, calitate, promptitudine, consistență și facilități</strong> — nu prin bugete de marketing.
        </p>
        <p style="font-size:1.2rem;color:#3d3d3d;margin-top:1rem;">
            Toate evaluările sunt realizate anonim de auditori independenți care filmează cu camere ascunse. 
            Rezultatele sunt publicate fără cenzură, iar sigiliul <strong>„Pizzalist Approved”</strong> se acordă exclusiv pe bază de punctaj.
        </p>
        <p style="font-size:1.2rem;color:#3d3d3d;margin-top:1rem;">
            Vrei să devii auditor sau să ne propui o pizzerie? <a href="/contact.html">Contactează-ne</a>.
        </p>
        <p style="margin-top:2rem;"><a href="/" style="font-weight:600;color:#c73b2b;">← Înapoi la pagina principală</a></p>
    </div>
    <footer class="footer"><p>© 2026 Pizzalist.ro</p></footer>
</body>
</html>
EOF

# ------------------------------------------------------------
#  contact.html
# ------------------------------------------------------------
cat > contact.html << 'EOF'
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact — Pizzalist.ro</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="/img/favicon.png">
</head>
<body>
    <nav class="nav" style="margin-top:1.5rem;">
        <a href="/" class="nav-logo"><span class="slice"></span> Pizzalist.ro</a>
        <a href="/#search" class="nav-cta">Caută o Pizzerie</a>
    </nav>
    <div style="max-width:800px;margin:4rem auto;padding:0 1.5rem;">
        <h1 style="font-size:2.5rem;font-weight:900;">📬 Contact</h1>
        <p style="font-size:1.2rem;color:#3d3d3d;margin-top:1rem;">
            Pentru sugestii, propuneri de audit sau întrebări generale, scrie-ne la:
        </p>
        <p style="font-size:1.5rem;font-weight:600;margin:1.5rem 0;">
            <a href="mailto:hello@pizzalist.ro">hello@pizzalist.ro</a>
        </p>
        <p style="color:#5a5a5a;">Răspundem în maxim 24 de ore.</p>
        <p style="margin-top:2rem;"><a href="/" style="font-weight:600;color:#c73b2b;">← Înapoi la pagina principală</a></p>
    </div>
    <footer class="footer"><p>© 2026 Pizzalist.ro</p></footer>
</body>
</html>
EOF

# ------------------------------------------------------------
#  privacy.html
# ------------------------------------------------------------
cat > privacy.html << 'EOF'
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confidențialitate — Pizzalist.ro</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="/img/favicon.png">
</head>
<body>
    <nav class="nav" style="margin-top:1.5rem;">
        <a href="/" class="nav-logo"><span class="slice"></span> Pizzalist.ro</a>
        <a href="/#search" class="nav-cta">Caută o Pizzerie</a>
    </nav>
    <div style="max-width:800px;margin:4rem auto;padding:0 1.5rem;">
        <h1 style="font-size:2.5rem;font-weight:900;">🔒 Politica de Confidențialitate</h1>
        <p style="color:#3d3d3d;margin-top:1rem;font-size:1.05rem;">
            <strong>Pizzalist.ro</strong> respectă dreptul la confidențialitate al utilizatorilor săi. 
            Acest site <strong>nu colectează date personale</strong> prin formulare sau cookie-uri de urmărire.
        </p>
        <ul style="margin:1.5rem 0;list-style:disc;padding-left:1.5rem;color:#3d3d3d;font-size:1.05rem;">
            <li>Nu stocăm adrese IP.</li>
            <li>Nu folosim Google Analytics sau trackere terțe.</li>
            <li>Nu trimitem e-mailuri nesolicitate.</li>
            <li>Datele de contact (e-mail) sunt folosite exclusiv pentru a răspunde la mesajele primite.</li>
        </ul>
        <p style="color:#5a5a5a;font-size:0.95rem;">
            Pentru orice întrebare legată de confidențialitate, scrie-ne la <a href="mailto:hello@pizzalist.ro">hello@pizzalist.ro</a>.
        </p>
        <p style="margin-top:2rem;"><a href="/" style="font-weight:600;color:#c73b2b;">← Înapoi la pagina principală</a></p>
    </div>
    <footer class="footer"><p>© 2026 Pizzalist.ro</p></footer>
</body>
</html>
EOF

# ------------------------------------------------------------
echo "✅ All files created successfully!"
echo ""
echo "📂 Project structure:"
ls -la | grep -E "\.html$|^css|^js|^data|^img" || true
echo ""
echo "🚀 Next steps:"
echo "  1. Add your favicon.png and og-image.jpg inside the 'img/' folder."
echo "  2. Run: zip -r pizzalist.zip . (to create the archive)"
echo "  3. Push everything to a GitHub repository."
echo "  4. Enable GitHub Pages in Settings → Pages."
echo ""
echo "🍕 Pizzalist.ro is ready for deployment!"