<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Admin Console — Urban Drive Solutions fleet management and analytics."/>
    <title>Admin Console — Urban Drive Solutions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
</head>
<body>

<!-- ── Admin Sidebar ── -->
<aside class="sidebar">
    <div class="sidebar-brand">
        <a href="${pageContext.request.contextPath}/home">
            <span class="sidebar-brand-name">Admin Console</span>
            <span class="sidebar-brand-sub">Fleet Management</span>
        </a>
    </div>

    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/home" class="sidebar-link">
            <span class="material-symbols-outlined">home</span><span>Home</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link active">
            <span class="material-symbols-outlined">dashboard</span><span>Overview</span>
        </a>
        <a href="${pageContext.request.contextPath}/vehicles" class="sidebar-link">
            <span class="material-symbols-outlined">directions_car</span><span>Fleet</span>
        </a>
        <a href="${pageContext.request.contextPath}/bookings" class="sidebar-link">
            <span class="material-symbols-outlined">calendar_today</span><span>Bookings</span>
        </a>
        <a href="${pageContext.request.contextPath}/payments" class="sidebar-link">
            <span class="material-symbols-outlined">payments</span><span>Revenue</span>
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
    <div style="display:flex; justify-content:space-between; align-items:flex-end; margin-bottom:4rem;">
        <div>
            <h1 class="page-title">Overview</h1>
            <p class="page-subtitle" style="text-transform:uppercase; letter-spacing:0.08em; font-size:0.75rem;">
                Global Fleet Analytics &amp; Performance
            </p>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="admin-logout-btn">Logout</a>
    </div>

    <!-- Success Message -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">
            <span class="material-symbols-outlined">check_circle</span>${successMessage}
        </div>
    </c:if>

    <!-- Metrics -->
    <section class="metrics-grid">
        <div class="metric-card">
            <div class="metric-top">
                <span class="metric-label-text">Total Revenue</span>
                <span class="material-symbols-outlined metric-icon">payments</span>
            </div>
            <div>
                <p class="metric-value">Rs. ${analytics.totalRevenue}</p>
                <p class="metric-sub m-success">All time revenue</p>
            </div>
        </div>
        <div class="metric-card">
            <div class="metric-top">
                <span class="metric-label-text">Fleet Size</span>
                <span class="material-symbols-outlined metric-icon">directions_car</span>
            </div>
            <div>
                <p class="metric-value">${analytics.totalVehicles}</p>
                <p class="metric-sub">${analytics.availableVehicles} available now</p>
            </div>
        </div>
        <div class="metric-card">
            <div class="metric-top">
                <span class="metric-label-text">Total Bookings</span>
                <span class="material-symbols-outlined metric-icon">calendar_today</span>
            </div>
            <div>
                <p class="metric-value">${analytics.totalBookings}</p>
                <p class="metric-sub">${analytics.totalConfirmedBookings} confirmed</p>
            </div>
        </div>
        <div class="metric-card">
            <div class="metric-top">
                <span class="metric-label-text">Payments</span>
                <span class="material-symbols-outlined metric-icon">receipt_long</span>
            </div>
            <div>
                <p class="metric-value">${analytics.totalPaidPayments}</p>
                <p class="metric-sub m-warn">${analytics.totalPendingPayments} pending</p>
            </div>
        </div>
    </section>

    <!-- Revenue by Method -->
    <section style="margin-bottom:4rem;">
        <div class="section-header">
            <h2 class="section-title">Revenue by Payment Method</h2>
            <a href="${pageContext.request.contextPath}/payments" class="section-link">View All Payments</a>
        </div>
        <div class="revenue-grid">
            <div class="rev-card">
                <p class="rev-label">Card</p>
                <p class="rev-value">Rs. ${analytics.cardRevenue}</p>
            </div>
            <div class="rev-card">
                <p class="rev-label">eSewa</p>
                <p class="rev-value">Rs. ${analytics.esewaRevenue}</p>
            </div>
            <div class="rev-card">
                <p class="rev-label">Khalti</p>
                <p class="rev-value">Rs. ${analytics.khaltiRevenue}</p>
            </div>
            <div class="rev-card">
                <p class="rev-label">connectIPS</p>
                <p class="rev-value">Rs. ${analytics.connectIpsRevenue}</p>
            </div>
        </div>
    </section>

    <!-- Quick Links -->
    <div class="ql-grid">
        <a href="${pageContext.request.contextPath}/vehicles" class="ql-card">
            <span class="material-symbols-outlined">directions_car</span>
            <div>
                <p class="ql-card-title">Manage Fleet</p>
                <p class="ql-card-desc">Add, edit, remove vehicles</p>
            </div>
        </a>
        <a href="${pageContext.request.contextPath}/bookings" class="ql-card">
            <span class="material-symbols-outlined">calendar_today</span>
            <div>
                <p class="ql-card-title">All Bookings</p>
                <p class="ql-card-desc">View and manage bookings</p>
            </div>
        </a>
        <a href="${pageContext.request.contextPath}/payments" class="ql-card">
            <span class="material-symbols-outlined">payments</span>
            <div>
                <p class="ql-card-title">All Payments</p>
                <p class="ql-card-desc">Revenue &amp; transactions</p>
            </div>
        </a>
    </div>

    <!-- Footer -->
    <div class="inner-footer">
        <div>
            <p class="footer-brand-name">Urban Drive Solutions</p>
            <p class="footer-copy">&copy;2026 Urban Drive Solutions — Internal Admin Portal</p>
        </div>
        <div class="footer-links">
            <a href="${pageContext.request.contextPath}/bookings">Manage Bookings</a>
            <a href="${pageContext.request.contextPath}/vehicles">Manage Fleet</a>
        </div>
    </div>

</main>
</body>
</html>
