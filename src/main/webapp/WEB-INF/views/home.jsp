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

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home" class="active">Home</a>
            <a href="${pageContext.request.contextPath}/vehicles">Browse Fleet</a>
            <a href="${pageContext.request.contextPath}/blogs">Blogs</a>
            <a href="${pageContext.request.contextPath}/about">About Us</a>
            <c:if test="${not empty sessionScope.loggedInUser}">
                <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
            </c:if>
        </div>

        <div class="nav-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-md">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login"    class="btn btn-outline btn-md">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-md">Register</a>
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

        <div class="hero-actions" style="margin-top:1.5rem;">
            <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-primary btn-lg">
                <span class="material-symbols-outlined">directions_car</span>Browse the Fleet
            </a>
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline btn-lg">
                        <span class="material-symbols-outlined">dashboard</span>My Dashboard
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline btn-lg">
                        <span class="material-symbols-outlined">login</span>Sign In
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Stats -->
    <section class="stats-row">
        <div class="stats-inner">
            <div class="stat-item">
                <p class="stat-number">200+</p>
                <p class="stat-label">Premium Vehicles</p>
            </div>
            <div class="stat-item">
                <p class="stat-number">5,000+</p>
                <p class="stat-label">Happy Customers</p>
            </div>
            <div class="stat-item">
                <p class="stat-number">24/7</p>
                <p class="stat-label">Customer Support</p>
            </div>
            <div class="stat-item">
                <p class="stat-number">99%</p>
                <p class="stat-label">Satisfaction Rate</p>
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
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
        </div>
    </div>
</footer>

<script>
(function () {
    var today = new Date().toISOString().split('T')[0];
    document.getElementById('homePickup').min = today;
    document.getElementById('homeReturn').min = today;

    document.getElementById('homePickup').addEventListener('change', function () {
        if (this.value) {
            var next = new Date(this.value);
            next.setDate(next.getDate() + 1);
            document.getElementById('homeReturn').min = next.toISOString().split('T')[0];
            if (document.getElementById('homeReturn').value <= this.value) {
                document.getElementById('homeReturn').value = '';
            }
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
            window.location.href = '${pageContext.request.contextPath}/login';
        </c:otherwise>
    </c:choose>
}
</script>
</body>
</html>
