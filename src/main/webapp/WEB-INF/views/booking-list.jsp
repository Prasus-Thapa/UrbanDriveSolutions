<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <c:choose>
        <c:when test="${isAdmin}">
            <title>All Bookings — Urban Drive Solutions</title>
        </c:when>
        <c:otherwise>
            <title>My Bookings — Urban Drive Solutions</title>
        </c:otherwise>
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
        <a href="${pageContext.request.contextPath}/bookings"        class="sidebar-link active"><span class="material-symbols-outlined">calendar_today</span><span>Bookings</span></a>
        <a href="${pageContext.request.contextPath}/payments"        class="sidebar-link"><span class="material-symbols-outlined">payments</span><span>Revenue</span></a>
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
            <a href="${pageContext.request.contextPath}/bookings" class="active">My Bookings</a>
            <a href="${pageContext.request.contextPath}/payments">My Payments</a>
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
                <c:choose><c:when test="${isAdmin}">Fleet Management</c:when><c:otherwise>Customer Portal</c:otherwise></c:choose>
            </span>
            <h1 class="page-title">
                <c:choose><c:when test="${isAdmin}">All Bookings</c:when><c:otherwise>My Bookings</c:otherwise></c:choose>
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
    <c:if test="${empty bookings}">
        <div class="empty-state">
            <span class="material-symbols-outlined empty-icon">event_busy</span>
            <p class="empty-title">No bookings found</p>
            <c:if test="${not isAdmin}">
                <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-primary btn-md">Browse Vehicles</a>
            </c:if>
        </div>
    </c:if>

    <!-- Bookings Table -->
    <c:if test="${not empty bookings}">
        <div class="table-wrapper">
            <div class="table-scroll">
                <table>
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <c:if test="${isAdmin}"><th>Customer</th></c:if>
                            <th>Vehicle</th>
                            <th>Reg. No.</th>
                            <th>Pickup</th>
                            <th>Return</th>
                            <th>Amount</th>
                            <th>Cancel Fee</th>
                            <th>Status</th>
                            <c:if test="${not isAdmin}"><th class="t-right">Action</th></c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${bookings}">
                            <tr>
                                <td class="td-id">#${booking.bookingId}</td>
                                <c:if test="${isAdmin}"><td class="td-bold">${booking.customerName}</td></c:if>
                                <td class="td-bold">${booking.vehicleName}</td>
                                <td class="td-mono">${booking.registrationNumber}</td>
                                <td class="td-muted">${booking.pickupDate}</td>
                                <td class="td-muted">${booking.returnDate}</td>
                                <td class="td-bold">Rs. ${booking.totalAmount}</td>
                                <td class="td-bold">
                                    <c:choose>
                                        <c:when test="${booking.bookingStatus == 'CANCELLED' and booking.cancellationFee != null}">
                                            <span style="color:#dc2626;">Rs. ${booking.cancellationFee}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color:var(--n-400);">—</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${booking.bookingStatus == 'CONFIRMED'}"><span class="badge badge-confirmed">Confirmed</span></c:when>
                                        <c:when test="${booking.bookingStatus == 'PENDING'}"><span class="badge badge-pending">Pending</span></c:when>
                                        <c:when test="${booking.bookingStatus == 'COMPLETED'}"><span class="badge badge-completed">Completed</span></c:when>
                                        <c:when test="${booking.bookingStatus == 'CANCELLED'}"><span class="badge badge-cancelled">Cancelled</span></c:when>
                                        <c:otherwise><span class="badge badge-completed">${booking.bookingStatus}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <c:if test="${not isAdmin}">
                                    <td class="t-right">
                                        <c:choose>
                                            <%-- PENDING: offer Pay Now + Cancel --%>
                                            <c:when test="${booking.bookingStatus == 'PENDING'}">
                                                <div style="display:flex;gap:0.4rem;justify-content:flex-end;flex-wrap:wrap;">
                                                    <a href="${pageContext.request.contextPath}/payments/pay?bookingId=${booking.bookingId}"
                                                       class="btn btn-primary btn-sm">
                                                        <span class="material-symbols-outlined" style="font-size:14px;">payments</span>Pay Now
                                                    </a>
                                                    <form action="${pageContext.request.contextPath}/bookings/cancel"
                                                          method="post" style="display:inline;"
                                                          onsubmit="return confirm('Cancel booking #${booking.bookingId}?\nNo payment has been collected, so no fee applies.');">
                                                        <input type="hidden" name="bookingId" value="${booking.bookingId}"/>
                                                        <button type="submit" class="btn btn-danger btn-sm">
                                                            <span class="material-symbols-outlined" style="font-size:14px;">cancel</span>Cancel
                                                        </button>
                                                    </form>
                                                </div>
                                            </c:when>
                                            <%-- CONFIRMED: offer Cancel with fee warning --%>
                                            <c:when test="${booking.bookingStatus == 'CONFIRMED'}">
                                                <form action="${pageContext.request.contextPath}/bookings/cancel"
                                                      method="post" style="display:inline;"
                                                      onsubmit="return confirm('Cancel confirmed booking #${booking.bookingId}?\nA cancellation fee will apply based on how soon the pickup date is.');">
                                                    <input type="hidden" name="bookingId" value="${booking.bookingId}"/>
                                                    <button type="submit" class="btn btn-danger btn-sm">
                                                        <span class="material-symbols-outlined" style="font-size:14px;">cancel</span>Cancel
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:when test="${booking.bookingStatus == 'CANCELLED'}">
                                                <span style="font-size:0.75rem;color:var(--n-400);font-weight:500;">Cancelled</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="font-size:0.75rem;color:var(--n-400);font-weight:500;">Completed</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:if>
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
            <a href="${pageContext.request.contextPath}/vehicles">Browse Fleet</a>
            <a href="${pageContext.request.contextPath}/payments">Payments</a>
        </div>
    </div>

</main>
</body>
</html>
