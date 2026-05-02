<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>About Us — Urban Drive Solutions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
</head>
<body>

<!-- ── Nav ── -->
<nav class="top-nav">
    <div class="top-nav-inner">
        <a href="${pageContext.request.contextPath}/home" class="nav-brand">Urban Drive Solutions</a>
        <button class="nav-toggle" id="navToggle" aria-label="Open menu">
            <span></span><span></span><span></span>
        </button>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/vehicles">Browse Fleet</a>
            <a href="${pageContext.request.contextPath}/blogs">Blogs</a>
            <a href="${pageContext.request.contextPath}/about" class="active">About Us</a>
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

<main class="page-topnav">

    <!-- Hero -->
    <div class="page-header">
        <div>
            <span class="page-eyebrow">Our Story</span>
            <h1 class="page-title" style="font-size:clamp(2.5rem,7vw,5rem); letter-spacing:-0.04em;">WHO WE ARE.</h1>
            <p class="page-subtitle" style="font-size:1.05rem; max-width:40rem; margin-top:0.75rem;">
                Urban Drive Solutions is Nepal's premium vehicle rental platform — built to make every journey
                seamless, reliable, and memorable.
            </p>
        </div>
    </div>

    <!-- Mission -->
    <div class="card" style="margin-bottom:1.5rem;">
        <div class="card-body" style="display:grid; grid-template-columns:1fr 1fr; gap:3rem; align-items:center;">
            <div>
                <p style="font-size:0.7rem; font-weight:700; letter-spacing:0.12em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.75rem;">Our Mission</p>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.75rem; font-weight:800; letter-spacing:-0.03em; line-height:1.25; margin-bottom:1rem;">
                    Making premium mobility accessible to everyone in Nepal.
                </h2>
                <p style="font-size:0.9rem; color:var(--n-500); line-height:1.75;">
                    We started Urban Drive Solutions with a simple belief — renting a quality vehicle should be as easy
                    as booking a hotel room. No hidden fees, no confusing paperwork, no outdated processes.
                    Just a clean, modern platform that puts you in the driver's seat.
                </p>
            </div>
            <div style="background:#f8f9fa; border-radius:0.75rem; padding:2.5rem; text-align:center;">
                <span class="material-symbols-outlined" style="font-size:5rem; color:var(--n-300);">emoji_transportation</span>
            </div>
        </div>
    </div>

    <!-- Stats -->
    <div class="stats-row" style="margin-bottom:1.5rem;">
        <div class="stats-inner">
            <div class="stat-item">
                <p class="stat-number" id="about-stat-vehicles">0+</p>
                <p class="stat-label">Premium Vehicles</p>
            </div>
            <div class="stat-item">
                <p class="stat-number" id="about-stat-customers">0+</p>
                <p class="stat-label">Happy Customers</p>
            </div>
            <div class="stat-item">
                <p class="stat-number">24/7</p>
                <p class="stat-label">Customer Support</p>
            </div>
            <div class="stat-item">
                <p class="stat-number" id="about-stat-satisfaction">0%</p>
                <p class="stat-label">Satisfaction Rate</p>
            </div>
        </div>
    </div>

    <!-- Values -->
    <div style="margin-bottom:3rem;">
        <p style="font-size:0.7rem; font-weight:700; letter-spacing:0.12em; text-transform:uppercase; color:var(--n-400); margin-bottom:1.25rem;">Our Values</p>
        <div style="display:grid; grid-template-columns:repeat(auto-fill,minmax(260px,1fr)); gap:1.25rem;">

            <div class="card">
                <div class="card-body">
                    <span class="material-symbols-outlined" style="font-size:2rem; margin-bottom:1rem; display:block;">verified</span>
                    <h3 style="font-family:'Space Grotesk',sans-serif; font-weight:700; font-size:1.05rem; margin-bottom:0.5rem;">Transparency</h3>
                    <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65;">
                        No hidden charges. What you see at booking is exactly what you pay. Our pricing and cancellation policy are always clear upfront.
                    </p>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <span class="material-symbols-outlined" style="font-size:2rem; margin-bottom:1rem; display:block;">star</span>
                    <h3 style="font-family:'Space Grotesk',sans-serif; font-weight:700; font-size:1.05rem; margin-bottom:0.5rem;">Quality Fleet</h3>
                    <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65;">
                        Every vehicle in our fleet undergoes regular maintenance inspections. You always get a clean, reliable, road-ready vehicle.
                    </p>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <span class="material-symbols-outlined" style="font-size:2rem; margin-bottom:1rem; display:block;">support_agent</span>
                    <h3 style="font-family:'Space Grotesk',sans-serif; font-weight:700; font-size:1.05rem; margin-bottom:0.5rem;">Customer First</h3>
                    <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65;">
                        Our support team is available around the clock. Whether you need help with a booking or have a question on the road — we're here.
                    </p>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <span class="material-symbols-outlined" style="font-size:2rem; margin-bottom:1rem; display:block;">lock</span>
                    <h3 style="font-family:'Space Grotesk',sans-serif; font-weight:700; font-size:1.05rem; margin-bottom:0.5rem;">Secure Payments</h3>
                    <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65;">
                        We support eSewa, Khalti, Connect IPS, and card payments — all processed securely with full transaction history in your account.
                    </p>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <span class="material-symbols-outlined" style="font-size:2rem; margin-bottom:1rem; display:block;">eco</span>
                    <h3 style="font-family:'Space Grotesk',sans-serif; font-weight:700; font-size:1.05rem; margin-bottom:0.5rem;">Sustainability</h3>
                    <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65;">
                        We are committed to growing our fleet with fuel-efficient and electric vehicles, reducing our carbon footprint one rental at a time.
                    </p>
                </div>
            </div>

        </div>
    </div>

    <!-- Team -->
    <div style="margin-bottom:3rem;">
        <p style="font-size:0.7rem; font-weight:700; letter-spacing:0.12em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.4rem;">The People Behind It</p>
        <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.75rem; font-weight:800; letter-spacing:-0.03em; margin-bottom:1.75rem;">Meet Our Team</h2>

        <div style="display:grid; grid-template-columns:repeat(auto-fill,minmax(260px,1fr)); gap:1.25rem;">

            <!-- Prasus Thapa -->
            <div class="card" style="text-align:center;">
                <div class="card-body" style="padding:2rem 1.5rem;">
                    <div style="width:64px; height:64px; border-radius:50%; background:var(--n-100); display:flex; align-items:center; justify-content:center; margin:0 auto 1rem;">
                        <span class="material-symbols-outlined" style="font-size:1.75rem; color:var(--n-400);">person</span>
                    </div>
                    <h3 style="font-family:'Space Grotesk',sans-serif; font-weight:700; font-size:1rem; margin-bottom:0.2rem;">Prasus Thapa</h3>
                    <p style="font-size:0.75rem; font-weight:600; letter-spacing:0.08em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.75rem;">Founder &amp; CEO</p>
                    <p style="font-size:0.85rem; color:var(--n-500); line-height:1.65;">
                        Prasus leads the company's vision and strategy, driving Urban Drive Solutions from a startup idea into Nepal's most trusted vehicle rental platform.
                    </p>
                </div>
            </div>

            <!-- Roshan Bhandari -->
            <div class="card" style="text-align:center;">
                <div class="card-body" style="padding:2rem 1.5rem;">
                    <div style="width:64px; height:64px; border-radius:50%; background:var(--n-100); display:flex; align-items:center; justify-content:center; margin:0 auto 1rem;">
                        <span class="material-symbols-outlined" style="font-size:1.75rem; color:var(--n-400);">person</span>
                    </div>
                    <h3 style="font-family:'Space Grotesk',sans-serif; font-weight:700; font-size:1rem; margin-bottom:0.2rem;">Roshan Bhandari</h3>
                    <p style="font-size:0.75rem; font-weight:600; letter-spacing:0.08em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.75rem;">Chief Technology Officer</p>
                    <p style="font-size:0.85rem; color:var(--n-500); line-height:1.65;">
                        Roshan architects the platform's core systems, ensuring every booking, payment, and feature runs reliably and securely at scale.
                    </p>
                </div>
            </div>

            <!-- Rahil Kunwar -->
            <div class="card" style="text-align:center;">
                <div class="card-body" style="padding:2rem 1.5rem;">
                    <div style="width:64px; height:64px; border-radius:50%; background:var(--n-100); display:flex; align-items:center; justify-content:center; margin:0 auto 1rem;">
                        <span class="material-symbols-outlined" style="font-size:1.75rem; color:var(--n-400);">person</span>
                    </div>
                    <h3 style="font-family:'Space Grotesk',sans-serif; font-weight:700; font-size:1rem; margin-bottom:0.2rem;">Rahil Kunwar</h3>
                    <p style="font-size:0.75rem; font-weight:600; letter-spacing:0.08em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.75rem;">Head of Operations</p>
                    <p style="font-size:0.85rem; color:var(--n-500); line-height:1.65;">
                        Rahil oversees day-to-day fleet management, vehicle inspections, and logistics — making sure every rental handover is smooth and on time.
                    </p>
                </div>
            </div>

            <!-- Rajesh Adhikari -->
            <div class="card" style="text-align:center;">
                <div class="card-body" style="padding:2rem 1.5rem;">
                    <div style="width:64px; height:64px; border-radius:50%; background:var(--n-100); display:flex; align-items:center; justify-content:center; margin:0 auto 1rem;">
                        <span class="material-symbols-outlined" style="font-size:1.75rem; color:var(--n-400);">person</span>
                    </div>
                    <h3 style="font-family:'Space Grotesk',sans-serif; font-weight:700; font-size:1rem; margin-bottom:0.2rem;">Rajesh Adhikari</h3>
                    <p style="font-size:0.75rem; font-weight:600; letter-spacing:0.08em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.75rem;">Finance Manager</p>
                    <p style="font-size:0.85rem; color:var(--n-500); line-height:1.65;">
                        Rajesh manages financial planning, payment integrations, and pricing strategy — keeping the business profitable while rates remain fair for customers.
                    </p>
                </div>
            </div>

            <!-- Sachin Dev Ale -->
            <div class="card" style="text-align:center;">
                <div class="card-body" style="padding:2rem 1.5rem;">
                    <div style="width:64px; height:64px; border-radius:50%; background:var(--n-100); display:flex; align-items:center; justify-content:center; margin:0 auto 1rem;">
                        <span class="material-symbols-outlined" style="font-size:1.75rem; color:var(--n-400);">person</span>
                    </div>
                    <h3 style="font-family:'Space Grotesk',sans-serif; font-weight:700; font-size:1rem; margin-bottom:0.2rem;">Sachin Dev Ale</h3>
                    <p style="font-size:0.75rem; font-weight:600; letter-spacing:0.08em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.75rem;">Customer Experience Lead</p>
                    <p style="font-size:0.85rem; color:var(--n-500); line-height:1.65;">
                        Sachin champions the customer journey end-to-end — from first inquiry to post-rental feedback — ensuring every interaction reflects Urban Drive's standards.
                    </p>
                </div>
            </div>

        </div>
    </div>

    <!-- CTA -->
    <section class="cta-section" style="margin-bottom:3rem;">
        <div class="cta-box">
            <div>
                <h2 class="cta-title">Ready to start your journey?</h2>
                <p class="cta-desc">Browse our fleet and make your first booking in minutes.</p>
            </div>
            <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-white btn-xl">Browse the Fleet</a>
        </div>
    </section>

    <!-- Footer -->
    <div class="inner-footer">
        <div>
            <p class="footer-brand-name">Urban Drive Solutions</p>
            <p class="footer-copy">&copy;2026 Urban Drive Solutions — Nepal's Premium Fleet</p>
        </div>
        <div class="footer-links">
            <a href="${pageContext.request.contextPath}/vehicles">Browse Fleet</a>
            <a href="${pageContext.request.contextPath}/blogs">Blogs</a>
            <a href="${pageContext.request.contextPath}/policy">Cancellation Policy</a>
        </div>
    </div>

</main>
<script>
(function () {
    var stats = [
        { id: 'about-stat-vehicles',     target: 200,  suffix: '+' },
        { id: 'about-stat-customers',    target: 2500, suffix: '+' },
        { id: 'about-stat-satisfaction', target: 99,   suffix: '%' }
    ];

    function animateStat(el, target, suffix) {
        var duration = 1800;
        var start = null;
        function step(ts) {
            if (!start) start = ts;
            var progress = Math.min((ts - start) / duration, 1);
            var eased = 1 - Math.pow(1 - progress, 2);
            el.textContent = Math.floor(eased * target) + suffix;
            if (progress < 1) requestAnimationFrame(step);
        }
        requestAnimationFrame(step);
    }

    var section = document.querySelector('.stats-row');
    if (!section) return;

    var triggered = false;
    var observer = new IntersectionObserver(function (entries) {
        if (entries[0].isIntersecting && !triggered) {
            triggered = true;
            stats.forEach(function (s) {
                var el = document.getElementById(s.id);
                if (el) animateStat(el, s.target, s.suffix);
            });
        }
    }, { threshold: 0.3 });

    observer.observe(section);
})();
</script>
<script src="${pageContext.request.contextPath}/static/js/nav.js"></script>
</body>
</html>
