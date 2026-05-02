<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Urban Drive Solutions — Nepal's premium vehicle rental platform. Browse 200+ curated vehicles."/>
    <title>Urban Drive Solutions — Premium Vehicle Rental</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
</head>
<body>

<!-- ── Top Navigation ── -->
<nav class="top-nav">
    <div class="top-nav-inner">
        <a href="${pageContext.request.contextPath}/home" class="nav-brand">Urban Drive Solutions</a>
        <button class="nav-toggle" id="navToggle" aria-label="Open menu">
            <span></span><span></span><span></span>
        </button>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home" class="active">Home</a>
            <a href="${pageContext.request.contextPath}/vehicles">Browse Fleet</a>
            <a href="${pageContext.request.contextPath}/blogs">Blogs</a>
            <a href="${pageContext.request.contextPath}/about">About Us</a>
            <c:if test="${not empty sessionScope.loggedInUser}">
                <a href="${pageContext.request.contextPath}/bookings">My Bookings</a>
                <a href="${pageContext.request.contextPath}/payments">My Payments</a>
                <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
            </c:if>
        </div>

        <div class="nav-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-md">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-md">Sign Up</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<!-- ── Hero ── -->
<main>
    <section class="hero">
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success mb-8">
                <span class="material-symbols-outlined">check_circle</span>${successMessage}
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error mb-8">
                <span class="material-symbols-outlined">error</span>${errorMessage}
            </div>
        </c:if>

        <span class="hero-badge">Premium Vehicle Rental · Nepal</span>
        <h1 class="hero-title">DRIVE<br/>DIFFERENT.</h1>
        <p class="hero-desc">
            Experience Nepal's most curated fleet of premium vehicles. From city commutes to mountain escapes —
            Urban Drive Solutions delivers excellence.
        </p>

        <!-- ── Date Search Widget (guests and customers only) ── -->
        <c:if test="${sessionScope.loggedInUser.role ne 'ADMIN'}">
        <div style="background:#fff; border:1px solid #e5e7eb; border-radius:1rem; padding:1.5rem; margin-top:2rem; max-width:620px; box-shadow:0 2px 12px rgba(0,0,0,0.06);">
            <p style="font-size:0.7rem; font-weight:700; letter-spacing:0.12em; text-transform:uppercase; color:#6b7280; margin-bottom:1rem;">
                Find Your Vehicle
            </p>
            <div style="display:flex; gap:1rem; flex-wrap:wrap; align-items:flex-end;">
                <div style="flex:1; min-width:140px;">
                    <label for="homePickup" style="display:block; font-size:0.75rem; font-weight:600; margin-bottom:0.375rem; color:#111;">Pickup Date</label>
                    <input id="homePickup" type="date" class="form-input" style="color:#111; background:#fff;"/>
                </div>
                <div style="flex:1; min-width:140px;">
                    <label for="homeReturn" style="display:block; font-size:0.75rem; font-weight:600; margin-bottom:0.375rem; color:#111;">Return Date</label>
                    <input id="homeReturn" type="date" class="form-input" style="color:#111; background:#fff;"/>
                </div>
                <button onclick="handleVehicleSearch()" class="btn btn-primary btn-lg" style="white-space:nowrap;">
                    <span class="material-symbols-outlined">search</span>Search Vehicle
                </button>
            </div>
        </div>
        </c:if>

    </section>

    <!-- Stats -->
    <section class="stats-row">
        <div class="stats-inner">
            <div class="stat-item">
                <p class="stat-number" id="stat-vehicles">0+</p>
                <p class="stat-label">Premium Vehicles</p>
            </div>
            <div class="stat-item">
                <p class="stat-number" id="stat-customers">0+</p>
                <p class="stat-label">Happy Customers</p>

            </div>
            <div class="stat-item">
                <p class="stat-number" id="stat-satisfaction">0%</p>
                <p class="stat-label">Satisfaction Rate</p>
            </div>
            <div class="stat-item">
                <p class="stat-number">24/7</p>
                <p class="stat-label">Customer Support</p>
            </div>
        </div>
    </section>

    <!-- Vehicle Fleet -->
    <section style="padding:4rem 0; background:#fff;">
        <div style="max-width:1600px; margin:0 auto; padding:0 4rem;">
            <div style="text-align:center; margin-bottom:2.5rem;">
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:2rem; font-weight:800; letter-spacing:-0.03em;">Our Vehicle Fleet</h2>
                <p style="color:var(--n-500); margin-top:0.5rem; font-size:0.95rem;">Browse our curated selection of premium vehicles ready for your next journey.</p>
            </div>

            <c:choose>
                <c:when test="${not empty featuredVehicles}">
                    <div style="position:relative;">
                        <!-- Scrollable track -->
                        <div id="vehicleSlider"
                             style="display:flex; gap:1.25rem; overflow-x:auto; scroll-behavior:smooth;
                                    scrollbar-width:none; -ms-overflow-style:none; padding:0.5rem 0 1rem;">
                            <c:forEach var="v" items="${featuredVehicles}" end="5">
                                <div class="card" style="overflow:hidden; flex:0 0 360px; min-width:360px;">
                                    <div style="background:var(--n-100); height:140px; display:flex; align-items:center; justify-content:center;">
                                        <span class="material-symbols-outlined" style="font-size:4rem; color:var(--n-300);">directions_car</span>
                                    </div>
                                    <div class="card-body">
                                        <div style="display:flex; justify-content:space-between; align-items:flex-start; gap:0.5rem; margin-bottom:0.5rem;">
                                            <h3 style="font-family:'Space Grotesk',sans-serif; font-weight:700; font-size:1rem;">${v.brand} ${v.model}</h3>
                                            <span style="font-size:0.7rem; font-weight:600; background:var(--n-100); padding:0.2rem 0.6rem; border-radius:99px; white-space:nowrap; flex-shrink:0;">${v.vehicleType}</span>
                                        </div>
                                        <div style="display:flex; gap:1rem; font-size:0.8rem; color:var(--n-500); margin-bottom:1rem;">
                                            <span><span class="material-symbols-outlined" style="font-size:0.9rem; vertical-align:middle;">person</span> ${v.seats} seats</span>
                                            <span><span class="material-symbols-outlined" style="font-size:0.9rem; vertical-align:middle;">palette</span> ${v.color}</span>
                                        </div>
                                        <div style="display:flex; justify-content:space-between; align-items:center;">
                                            <p style="font-weight:800; font-size:1.05rem;">Rs. ${v.pricePerDay}<span style="font-size:0.75rem; font-weight:400; color:var(--n-500);">/day</span></p>
                                            <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-primary btn-sm">Book Now</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Prev arrow -->
                        <button onclick="slideVehicles(-1)" aria-label="Previous"
                                style="position:absolute; left:0; top:45%; transform:translateY(-50%); z-index:2;
                                       width:2.5rem; height:2.5rem; border-radius:50%; border:1px solid var(--n-200);
                                       background:#fff; cursor:pointer; display:flex; align-items:center; justify-content:center;
                                       box-shadow:0 2px 8px rgba(0,0,0,0.1);">
                            <span class="material-symbols-outlined" style="font-size:1.25rem;">chevron_left</span>
                        </button>

                        <!-- Next arrow -->
                        <button onclick="slideVehicles(1)" aria-label="Next"
                                style="position:absolute; right:0; top:45%; transform:translateY(-50%); z-index:2;
                                       width:2.5rem; height:2.5rem; border-radius:50%; border:1px solid var(--n-200);
                                       background:#fff; cursor:pointer; display:flex; align-items:center; justify-content:center;
                                       box-shadow:0 2px 8px rgba(0,0,0,0.1);">
                            <span class="material-symbols-outlined" style="font-size:1.25rem;">chevron_right</span>
                        </button>
                    </div>

                    <!-- Dot indicators -->
                    <div id="sliderDots" style="display:flex; justify-content:center; gap:0.5rem; margin-top:1.25rem;"></div>

                    <div style="text-align:center; margin-top:1.5rem;">
                        <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-outline btn-lg">View All Vehicles</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align:center; padding:3rem; color:var(--n-400);">
                        <span class="material-symbols-outlined" style="font-size:3rem; display:block; margin-bottom:1rem;">directions_car</span>
                        <p>No vehicles available right now. Check back soon.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Reviews -->
    <section style="padding:4rem 0; background:#f8f9fa;">
        <div style="max-width:1200px; margin:0 auto; padding:0 2rem;">
            <div style="text-align:center; margin-bottom:2.5rem;">
                <p style="font-size:0.95rem; color:var(--n-400); margin-bottom:0.25rem;">Read Reviews,</p>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:2rem; font-weight:800; letter-spacing:-0.03em;">book with confidence.</h2>
            </div>
            <div style="display:grid; grid-template-columns:repeat(auto-fill,minmax(280px,1fr)); gap:1.5rem;">

                <div class="card">
                    <div class="card-body">
                        <div style="display:flex; align-items:center; gap:0.75rem; margin-bottom:1rem;">
                            <div style="width:40px; height:40px; border-radius:50%; background:var(--n-100); display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                                <span class="material-symbols-outlined" style="font-size:1.25rem; color:var(--n-400);">person</span>
                            </div>
                            <div>
                                <p style="font-weight:700; font-size:0.9rem;">Aarav Sharma</p>
                                <span style="color:#f59e0b; font-size:0.85rem;">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
                            </div>
                        </div>
                        <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65;">
                            Rented an SUV for a Pokhara trip — the booking process was seamless and the vehicle was spotless. Will definitely use Urban Drive again!
                        </p>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <div style="display:flex; align-items:center; gap:0.75rem; margin-bottom:1rem;">
                            <div style="width:40px; height:40px; border-radius:50%; background:var(--n-100); display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                                <span class="material-symbols-outlined" style="font-size:1.25rem; color:var(--n-400);">person</span>
                            </div>
                            <div>
                                <p style="font-weight:700; font-size:0.9rem;">Sita Poudel</p>
                                <span style="color:#f59e0b; font-size:0.85rem;">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
                            </div>
                        </div>
                        <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65;">
                            Transparent pricing, no hidden fees, and the cancellation policy is fair. Finally a rental platform in Nepal that actually works well.
                        </p>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <div style="display:flex; align-items:center; gap:0.75rem; margin-bottom:1rem;">
                            <div style="width:40px; height:40px; border-radius:50%; background:var(--n-100); display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                                <span class="material-symbols-outlined" style="font-size:1.25rem; color:var(--n-400);">person</span>
                            </div>
                            <div>
                                <p style="font-weight:700; font-size:0.9rem;">Bikram Thapa</p>
                                <span style="color:#f59e0b; font-size:0.85rem;">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
                            </div>
                        </div>
                        <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65;">
                            Booked a sedan for a week-long road trip. Customer support was responsive and the handover was quick. Highly recommended service!
                        </p>
                    </div>
                </div>

            </div>

            <!-- Hidden reviews — fold reveal -->
            <div id="reviewsMoreWrap" class="reviews-more-wrap">
                <div class="reviews-more-grid">

                    <div class="card">
                        <div class="card-body">
                            <div style="display:flex; align-items:center; gap:0.75rem; margin-bottom:1rem;">
                                <div style="width:40px; height:40px; border-radius:50%; background:var(--n-100); display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                                    <span class="material-symbols-outlined" style="font-size:1.25rem; color:var(--n-400);">person</span>
                                </div>
                                <div>
                                    <p style="font-weight:700; font-size:0.9rem;">Priya Karki</p>
                                    <span style="color:#f59e0b; font-size:0.85rem;">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
                                </div>
                            </div>
                            <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65;">
                                First time renting a car in Nepal and it couldn't have been easier. The team was professional and the vehicle was in perfect condition throughout our Chitwan trip.
                            </p>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <div style="display:flex; align-items:center; gap:0.75rem; margin-bottom:1rem;">
                                <div style="width:40px; height:40px; border-radius:50%; background:var(--n-100); display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                                    <span class="material-symbols-outlined" style="font-size:1.25rem; color:var(--n-400);">person</span>
                                </div>
                                <div>
                                    <p style="font-weight:700; font-size:0.9rem;">Rohan Adhikari</p>
                                    <span style="color:#f59e0b; font-size:0.85rem;">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
                                </div>
                            </div>
                            <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65;">
                                Used Urban Drive for a business trip from Kathmandu to Hetauda. On-time pickup, clean interior, and a hassle-free return. Will be my go-to rental service from now on.
                            </p>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <div style="display:flex; align-items:center; gap:0.75rem; margin-bottom:1rem;">
                                <div style="width:40px; height:40px; border-radius:50%; background:var(--n-100); display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                                    <span class="material-symbols-outlined" style="font-size:1.25rem; color:var(--n-400);">person</span>
                                </div>
                                <div>
                                    <p style="font-weight:700; font-size:0.9rem;">Anita Gurung</p>
                                    <span style="color:#f59e0b; font-size:0.85rem;">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
                                </div>
                            </div>
                            <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65;">
                                The cancellation policy saved me when my plans changed last minute. Got a full refund with no drama at all. Genuinely impressed with how fair and transparent everything was.
                            </p>
                        </div>
                    </div>

                </div>
            </div>

            <div style="text-align:center; margin-top:2rem;">
                <button id="reviewToggle" class="btn btn-outline btn-lg">
                    <span class="review-label">Read More Reviews</span>
                    <span class="material-symbols-outlined review-arrow">expand_more</span>
                </button>
            </div>
        </div>
    </section>

    <!-- CTA -->
    <section class="cta-section">
        <div class="cta-box">
            <div>
                <h2 class="cta-title">Ready to hit the road?</h2>
                <p class="cta-desc">Create your account and start booking in minutes.</p>
            </div>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-white btn-xl">Get Started Free</a>
        </div>
    </section>
</main>

<!-- ── Footer ── -->
<footer class="site-footer">
    <div class="site-footer-inner">
        <div>
            <p class="footer-brand-name">Urban Drive Solutions</p>
            <p class="footer-copy">&copy;2026 Urban Drive Solutions — Nepal's Premium Fleet</p>
        </div>
        <div class="footer-links">
            <a href="${pageContext.request.contextPath}/policy">Cancellation Policy</a>
            <a href="${pageContext.request.contextPath}/about">About Us</a>
        </div>
    </div>
</footer>

<script>
(function () {
    var pickup = document.getElementById('homePickup');
    var ret    = document.getElementById('homeReturn');
    if (!pickup || !ret) return;

    var today = new Date().toISOString().split('T')[0];
    pickup.min = today;
    ret.min    = today;

    pickup.addEventListener('change', function () {
        if (this.value) {
            var next = new Date(this.value);
            next.setDate(next.getDate() + 1);
            ret.min = next.toISOString().split('T')[0];
            if (ret.value <= this.value) ret.value = '';
        }
    });
})();

function handleVehicleSearch() {
    var pickup  = document.getElementById('homePickup').value;
    var ret     = document.getElementById('homeReturn').value;
    if (!pickup || !ret) {
        alert('Please select both pickup and return dates.');
        return;
    }
    if (ret <= pickup) {
        alert('Return date must be after pickup date.');
        return;
    }
    <c:choose>
        <c:when test="${not empty sessionScope.loggedInUser}">
            window.location.href = '${pageContext.request.contextPath}/vehicles';
        </c:when>
        <c:otherwise>
            window.location.href = '${pageContext.request.contextPath}/login?redirect=vehicles';
        </c:otherwise>
    </c:choose>
}

// Count-up animation triggered when the stats section scrolls into view
(function () {
    function countUp(el, target, duration, suffix) {
        var start = 0;
        var startTime = null;
        function step(timestamp) {
            if (!startTime) startTime = timestamp;
            var progress = Math.min((timestamp - startTime) / duration, 1);
            var eased = 1 - Math.pow(1 - progress, 2);
            var value = Math.floor(eased * target);
            el.textContent = value.toLocaleString() + suffix;
            if (progress < 1) requestAnimationFrame(step);
        }
        requestAnimationFrame(step);
    }

    var stats = [
        { id: 'stat-vehicles',     target: 200,  suffix: '+' },
        { id: 'stat-customers',    target: 2500, suffix: '+' },
{ id: 'stat-satisfaction', target: 99,   suffix: '%' }
    ];

    var observed = false;
    var section = document.querySelector('.stats-row');
    if (!section) return;

    var observer = new IntersectionObserver(function (entries) {
        if (observed || !entries[0].isIntersecting) return;
        observed = true;
        stats.forEach(function (s) {
            var el = document.getElementById(s.id);
            if (el) countUp(el, s.target, 4000, s.suffix);
        });
    }, { threshold: 0.3 });

    observer.observe(section);
})();

// Vehicle slider
(function () {
    var style = document.createElement('style');
    style.textContent = '#vehicleSlider::-webkit-scrollbar{display:none}';
    document.head.appendChild(style);

    var slider   = document.getElementById('vehicleSlider');
    var dotsWrap = document.getElementById('sliderDots');
    if (!slider || !dotsWrap) return;

    var cards = slider.querySelectorAll(':scope > div');
    var total = cards.length;
    if (total === 0) return;

    for (var i = 0; i < total; i++) {
        var dot = document.createElement('span');
        dot.style.cssText = 'display:inline-block;width:8px;height:8px;border-radius:50%;background:#d1d5db;transition:background 0.2s,transform 0.2s;cursor:pointer;';
        dot.dataset.idx = i;
        dot.addEventListener('click', function () {
            var card = cards[parseInt(this.dataset.idx)];
            if (card) slider.scrollTo({ left: card.offsetLeft, behavior: 'smooth' });
        });
        dotsWrap.appendChild(dot);
    }

    function updateDots() {
        var mid = slider.scrollLeft + slider.clientWidth / 2;
        var closest = 0, minDist = Infinity;
        cards.forEach(function (c, i) {
            var dist = Math.abs((c.offsetLeft + c.offsetWidth / 2) - mid);
            if (dist < minDist) { minDist = dist; closest = i; }
        });
        dotsWrap.querySelectorAll('span').forEach(function (d, i) {
            d.style.background = i === closest ? '#111' : '#d1d5db';
            d.style.transform  = i === closest ? 'scale(1.3)' : 'scale(1)';
        });
    }

    slider.addEventListener('scroll', updateDots);
    updateDots();
})();

function slideVehicles(dir) {
    var slider = document.getElementById('vehicleSlider');
    if (!slider) return;
    var card = slider.querySelector(':scope > div');
    if (!card) return;
    slider.scrollBy({ left: dir * (card.offsetWidth + 20), behavior: 'smooth' });
}

// Reviews fold reveal
(function () {
    var btn  = document.getElementById('reviewToggle');
    var wrap = document.getElementById('reviewsMoreWrap');
    if (!btn || !wrap) return;
    btn.addEventListener('click', function () {
        var isOpen = wrap.classList.toggle('open');
        btn.classList.toggle('open', isOpen);
        btn.querySelector('.review-label').textContent = isOpen ? 'Show Less' : 'Read More Reviews';
        if (isOpen) {
            wrap.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }
    });
})();
</script>
<script src="${pageContext.request.contextPath}/static/js/nav.js"></script>
</body>
</html>
