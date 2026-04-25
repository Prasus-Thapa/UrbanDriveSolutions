<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Book Vehicle — Urban Drive Solutions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
</head>
<body>

<!-- ── Top Nav ── -->
<nav class="top-nav">
    <div class="top-nav-inner">
        <a href="${pageContext.request.contextPath}/home" class="nav-brand">Urban Drive Solutions</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/vehicles" class="active">Browse Fleet</a>
            <a href="${pageContext.request.contextPath}/bookings">My Bookings</a>
            <a href="${pageContext.request.contextPath}/payments">My Payments</a>
            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
        </div>
        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-outline btn-md">← Back to Fleet</a>
            <a href="${pageContext.request.contextPath}/logout"   class="btn btn-primary btn-md">Logout</a>
        </div>
    </div>
</nav>

<main class="page-topnav">

    <!-- Header -->
    <div class="page-header">
        <div>
            <span class="page-eyebrow">Booking</span>
            <h1 class="page-title">Reserve Your Ride</h1>
            <p class="page-subtitle">Complete your booking details below</p>
        </div>
    </div>

    <!-- Error -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">
            <span class="material-symbols-outlined">error</span>${errorMessage}
        </div>
    </c:if>

    <!-- Two-col layout -->
    <div class="two-col">

        <!-- Vehicle Detail Card -->
        <div class="card">
            <div class="vehicle-img-box">
                <span class="material-symbols-outlined">directions_car</span>
            </div>
            <div class="card-body">
                <p class="v-card-type">${vehicle.vehicleType} · ${vehicle.color} · ${vehicle.seats} seats</p>
                <h2 class="v-card-name" style="font-size:1.75rem;">${vehicle.brand} ${vehicle.model}</h2>
                <p class="v-card-reg" style="margin-bottom:1.5rem;">${vehicle.registrationNumber}</p>

                <div style="border-top:1px solid var(--n-100); padding-top:1.25rem;">
                    <div style="display:flex; justify-content:space-between; align-items:flex-end;">
                        <div>
                            <p class="v-price-label">Daily Rate</p>
                            <p class="v-price">Rs. ${vehicle.pricePerDay}</p>
                        </div>
                        <span class="badge badge-available">Available</span>
                    </div>
                    <p style="font-size:0.75rem; color:var(--n-400); margin-top:1rem; display:flex; align-items:center; gap:0.25rem;">
                        <span class="material-symbols-outlined" style="font-size:14px;">info</span>
                        Total calculated based on rental duration
                    </p>
                </div>
            </div>
        </div>

        <!-- Booking Form -->
        <div class="card">
            <div class="card-body">
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.25rem; font-weight:700; margin-bottom:1.5rem; letter-spacing:-0.01em;">
                    Booking Details
                </h2>
                <form action="${pageContext.request.contextPath}/bookings/add" method="post" class="form-space">
                    <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">

                    <div class="form-group">
                        <label class="form-label" for="pickupDate">Pickup Date</label>
                        <input id="pickupDate" type="date" name="pickupDate" value="${pickupDate}" required class="form-input"/>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="returnDate">Return Date</label>
                        <input id="returnDate" type="date" name="returnDate" value="${returnDate}" required class="form-input"/>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg btn-full" style="margin-top:0.5rem;">
                        <span class="material-symbols-outlined">check_circle</span>Confirm Booking
                    </button>
                    <p style="font-size:0.75rem; color:var(--n-400); text-align:center;">
                        By confirming, you agree to our vehicle return policy
                    </p>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="inner-footer">
        <p class="footer-brand-name">Urban Drive Solutions</p>
        <p class="footer-copy">&copy;2026 Urban Drive Solutions</p>
    </div>

</main>
</body>
</html>
