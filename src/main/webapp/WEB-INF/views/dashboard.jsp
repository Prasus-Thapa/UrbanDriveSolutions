<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="My Dashboard — Urban Drive Solutions customer portal."/>
    <title>My Dashboard — Urban Drive Solutions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
</head>
<body>

<!-- ── Sidebar ── -->
<aside class="sidebar">
    <div class="sidebar-brand">
        <a href="${pageContext.request.contextPath}/home">
            <span class="sidebar-brand-name">Urban Drive</span>
            <span class="sidebar-brand-sub">Customer Portal</span>
        </a>
    </div>

    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/home" class="sidebar-link">
            <span class="material-symbols-outlined">home</span><span>Home</span>
        </a>
        <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link active">
            <span class="material-symbols-outlined">dashboard</span><span>My Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/vehicles" class="sidebar-link">
            <span class="material-symbols-outlined">directions_car</span><span>Browse Fleet</span>
        </a>
        <a href="${pageContext.request.contextPath}/bookings" class="sidebar-link">
            <span class="material-symbols-outlined">calendar_today</span><span>My Bookings</span>
        </a>
        <a href="${pageContext.request.contextPath}/payments" class="sidebar-link">
            <span class="material-symbols-outlined">payments</span><span>My Payments</span>
        </a>
    </nav>

    <div class="sidebar-bottom">
        <div class="sidebar-divider"></div>
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link">
            <span class="material-symbols-outlined">logout</span><span>Logout</span>
        </a>
    </div>
</aside>

<!-- ── Main ── -->
<main class="page-sidebar">

    <!-- Header -->
    <div class="dash-header">
        <div>
            <span class="page-eyebrow">Customer Portal</span>
            <h1 class="page-title">My Profile</h1>
            <p class="page-subtitle">Welcome back, ${sessionScope.loggedInUser.fullName}</p>
        </div>
        <div class="dash-avatar">
            <span class="material-symbols-outlined" style="color:var(--n-500);">person</span>
        </div>
    </div>

    <!-- Success Message -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">
            <span class="material-symbols-outlined">check_circle</span>${successMessage}
        </div>
    </c:if>

    <!-- Profile Cards -->
    <div class="profile-grid">
        <div class="card">
            <div class="card-body">
                <p class="profile-section-title">Personal Information</p>
                <div class="profile-field">
                    <p class="profile-field-label">Full Name</p>
                    <p class="profile-field-value">${sessionScope.loggedInUser.fullName}</p>
                </div>
                <div class="profile-field">
                    <p class="profile-field-label">Email Address</p>
                    <p class="profile-field-value-sm">${sessionScope.loggedInUser.email}</p>
                </div>
                <div class="profile-field">
                    <p class="profile-field-label">Phone Number</p>
                    <p class="profile-field-value-sm">${sessionScope.loggedInUser.phone}</p>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <p class="profile-section-title">Account Details</p>
                <div class="profile-field">
                    <p class="profile-field-label">License Number</p>
                    <p class="profile-field-mono">${sessionScope.loggedInUser.licenseNumber}</p>
                </div>
                <div class="profile-field">
                    <p class="profile-field-label">Account Role</p>
                    <span class="badge badge-role">${sessionScope.loggedInUser.role}</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <section>
        <h2 class="quick-actions-title">Quick Actions</h2>
        <div class="quick-actions-grid">
            <a href="${pageContext.request.contextPath}/vehicles" class="qa-card dark">
                <span class="material-symbols-outlined">directions_car</span>
                <p class="qa-label">Browse Fleet</p>
            </a>
            <a href="${pageContext.request.contextPath}/bookings" class="qa-card">
                <span class="material-symbols-outlined">calendar_today</span>
                <p class="qa-label">My Bookings</p>
            </a>
            <a href="${pageContext.request.contextPath}/payments" class="qa-card">
                <span class="material-symbols-outlined">payments</span>
                <p class="qa-label">My Payments</p>
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="qa-card">
                <span class="material-symbols-outlined">logout</span>
                <p class="qa-label">Sign Out</p>
            </a>
        </div>
    </section>

    <!-- Footer -->
    <div class="inner-footer">
        <div>
            <p class="footer-brand-name">Urban Drive Solutions</p>
            <p class="footer-copy">&copy;2026 Urban Drive Solutions</p>
        </div>
        <div class="footer-links">
            <a href="${pageContext.request.contextPath}/home">← Back to Home</a>
        </div>
    </div>

</main>
</body>
</html>
