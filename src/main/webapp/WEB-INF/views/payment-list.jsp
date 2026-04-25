<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <c:choose>
        <c:when test="${isAdmin}"><title>All Payments — Urban Drive Solutions</title></c:when>
        <c:otherwise><title>My Payments — Urban Drive Solutions</title></c:otherwise>
    </c:choose>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
</head>
<body>

<c:choose>
<%-- ═══ ADMIN SIDEBAR ═══ --%>
<c:when test="${isAdmin}">
<aside class="sidebar">
    <div class="sidebar-brand">
        <a href="${pageContext.request.contextPath}/home">
            <span class="sidebar-brand-name">Admin Console</span>
            <span class="sidebar-brand-sub">Fleet Management</span>
        </a>
    </div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/home"            class="sidebar-link"><span class="material-symbols-outlined">home</span><span>Home</span></a>
        <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link"><span class="material-symbols-outlined">dashboard</span><span>Overview</span></a>
        <a href="${pageContext.request.contextPath}/vehicles"        class="sidebar-link"><span class="material-symbols-outlined">directions_car</span><span>Fleet</span></a>
        <a href="${pageContext.request.contextPath}/bookings"        class="sidebar-link"><span class="material-symbols-outlined">calendar_today</span><span>Bookings</span></a>
        <a href="${pageContext.request.contextPath}/payments"        class="sidebar-link active"><span class="material-symbols-outlined">payments</span><span>Revenue</span></a>
    </nav>
    <div class="sidebar-bottom">
        <div class="sidebar-divider"></div>
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link"><span class="material-symbols-outlined">logout</span><span>Logout</span></a>
    </div>
</aside>
<main class="page-sidebar">
</c:when>

<%-- ═══ USER TOP NAV ═══ --%>
<c:otherwise>
<nav class="top-nav">
    <div class="top-nav-inner">
        <a href="${pageContext.request.contextPath}/home" class="nav-brand">Urban Drive Solutions</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/vehicles">Browse Fleet</a>
            <a href="${pageContext.request.contextPath}/blogs">Blogs</a>
            <a href="${pageContext.request.contextPath}/about">About Us</a>
            <a href="${pageContext.request.contextPath}/bookings">My Bookings</a>
            <a href="${pageContext.request.contextPath}/payments" class="active">My Payments</a>
            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
        </div>
        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-md">Logout</a>
        </div>
    </div>
</nav>
<main class="page-topnav">
</c:otherwise>
</c:choose>

    <!-- Page Header -->
    <div class="page-header">
        <div>
            <span class="page-eyebrow">
                <c:choose><c:when test="${isAdmin}">Revenue Analytics</c:when><c:otherwise>Transaction History</c:otherwise></c:choose>
            </span>
            <h1 class="page-title">
                <c:choose><c:when test="${isAdmin}">All Payments</c:when><c:otherwise>My Payments</c:otherwise></c:choose>
            </h1>
        </div>
    </div>

    <!-- Messages -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success"><span class="material-symbols-outlined">check_circle</span>${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error"><span class="material-symbols-outlined">error</span>${errorMessage}</div>
    </c:if>

    <!-- Empty State -->
    <c:if test="${empty payments}">
        <div class="empty-state">
            <span class="material-symbols-outlined empty-icon">receipt_long</span>
            <p class="empty-title">No payments found</p>
            <c:if test="${not isAdmin}">
                <a href="${pageContext.request.contextPath}/bookings" class="btn btn-primary btn-md">My Bookings</a>
            </c:if>
        </div>
    </c:if>

    <!-- Payments Table -->
    <c:if test="${not empty payments}">
        <div class="table-wrapper">
            <div class="table-scroll">
                <table>
                    <thead>
                        <tr>
                            <th>Payment ID</th>
                            <th>Booking ID</th>
                            <c:if test="${isAdmin}"><th>Customer</th></c:if>
                            <th>Vehicle</th>
                            <th>Amount</th>
                            <th>Method</th>
                            <th>Status</th>
                            <th>Txn Code</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="payment" items="${payments}">
                            <tr>
                                <td class="td-id">#${payment.paymentId}</td>
                                <td class="td-id">#${payment.bookingId}</td>
                                <c:if test="${isAdmin}"><td class="td-bold">${payment.customerName}</td></c:if>
                                <td class="td-bold">${payment.vehicleName}</td>
                                <td class="td-bold">Rs. ${payment.amount}</td>
                                <td class="td-muted">${empty payment.paymentMethod ? '—' : payment.paymentMethod}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${payment.paymentStatus == 'PAID'}">
                                            <span class="badge badge-confirmed">Paid</span>
                                        </c:when>
                                        <c:when test="${payment.paymentStatus == 'PENDING'}">
                                            <span class="badge badge-pending">Pending</span>
                                        </c:when>
                                        <c:when test="${payment.paymentStatus == 'REFUNDED'}">
                                            <span class="badge badge-completed">Refunded</span>
                                        </c:when>
                                        <c:when test="${payment.paymentStatus == 'PARTIALLY_REFUNDED'}">
                                            <span class="badge badge-pending" style="background:#f59e0b20;color:#b45309;border-color:#f59e0b;">Partial Refund</span>
                                        </c:when>
                                        <c:when test="${payment.paymentStatus == 'NON_REFUNDABLE'}">
                                            <span class="badge badge-cancelled">Non-Refundable</span>
                                        </c:when>
                                        <c:when test="${payment.paymentStatus == 'FAILED'}">
                                            <span class="badge badge-cancelled">Failed</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-completed">${payment.paymentStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="td-mono">${empty payment.transactionCode ? '—' : payment.transactionCode}</td>
                                <td class="td-muted">${payment.paymentDate}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>

    <!-- Footer -->
    <div class="inner-footer">
        <div>
            <p class="footer-brand-name">Urban Drive Solutions</p>
            <p class="footer-copy">&copy;2026 Urban Drive Solutions</p>
        </div>
        <div class="footer-links">
            <c:choose>
                <c:when test="${isAdmin}">
                    <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/home">Home</a>
                    <a href="${pageContext.request.contextPath}/bookings">My Bookings</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</main>
</body>
</html>
