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

                    <!-- Live price preview -->
                    <div id="pricePreviewBox" style="display:none; justify-content:space-between; align-items:center; padding:0.75rem 1rem; background:#f8f9fa; border-radius:0.625rem; font-size:0.875rem;">
                        <span style="color:var(--n-500);" id="pricePreviewDays"></span>
                        <span style="font-weight:700; font-size:1rem;" id="pricePreviewTotal"></span>
                    </div>

                    <!-- Cancellation Policy Summary -->
                    <details open style="border:1px solid var(--n-100); border-radius:0.75rem; overflow:hidden; margin-top:0.25rem;">
                        <summary style="padding:0.875rem 1rem; font-size:0.8rem; font-weight:600; cursor:pointer; display:flex; align-items:center; gap:0.5rem; list-style:none; user-select:none;">
                            <span class="material-symbols-outlined" style="font-size:1rem; color:var(--n-400);">event_busy</span>
                            Cancellation Policy Summary
                            <span class="material-symbols-outlined" id="policyChevron" style="font-size:1rem; margin-left:auto; color:var(--n-400); transition:transform 0.2s;">expand_more</span>
                        </summary>
                        <div style="padding:0 1rem 1rem; border-top:1px solid var(--n-100);">
                            <div style="display:flex; flex-direction:column; gap:0.5rem; margin-top:0.875rem; font-size:0.8rem;">
                                <div style="display:flex; justify-content:space-between; align-items:center; padding:0.5rem 0.75rem; background:#f0fdf4; border-radius:0.5rem;">
                                    <span style="color:var(--n-500);">2+ days before pickup</span>
                                    <span style="font-weight:700; color:#16a34a;">Full Refund</span>
                                </div>
                                <div style="display:flex; justify-content:space-between; align-items:center; padding:0.5rem 0.75rem; background:#fefce8; border-radius:0.5rem;">
                                    <span style="color:var(--n-500);">The day before pickup</span>
                                    <span style="font-weight:700; color:#ca8a04;">20% Fee</span>
                                </div>
                                <div style="display:flex; justify-content:space-between; align-items:center; padding:0.5rem 0.75rem; background:#fff7ed; border-radius:0.5rem;">
                                    <span style="color:var(--n-500);">On the pickup date</span>
                                    <span style="font-weight:700; color:#ea580c;">50% Fee</span>
                                </div>
                                <div style="display:flex; justify-content:space-between; align-items:center; padding:0.5rem 0.75rem; background:#fef2f2; border-radius:0.5rem;">
                                    <span style="color:var(--n-500);">After pickup date</span>
                                    <span style="font-weight:700; color:#dc2626;">Non-Refundable</span>
                                </div>
                            </div>
                            <a href="${pageContext.request.contextPath}/policy" target="_blank"
                               style="display:inline-flex; align-items:center; gap:0.25rem; font-size:0.75rem; font-weight:600; color:#000; text-decoration:none; margin-top:0.875rem;">
                                Read full policy
                                <span class="material-symbols-outlined" style="font-size:14px;">open_in_new</span>
                            </a>
                        </div>
                    </details>

                    <button type="submit" class="btn btn-primary btn-lg btn-full" style="margin-top:0.75rem;">
                        <span class="material-symbols-outlined">check_circle</span>Confirm Booking
                    </button>
                    <p style="font-size:0.75rem; color:var(--n-400); text-align:center;">
                        By confirming, you agree to our
                        <a href="${pageContext.request.contextPath}/policy" target="_blank" style="color:#000; font-weight:600;">Cancellation &amp; Rental Policy</a>
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

<script>
(function () {
    var pickup   = document.getElementById('pickupDate');
    var ret      = document.getElementById('returnDate');
    var previewBox   = document.getElementById('pricePreviewBox');
    var previewDays  = document.getElementById('pricePreviewDays');
    var previewTotal = document.getElementById('pricePreviewTotal');
    var chevron  = document.getElementById('policyChevron');
    var details  = chevron ? chevron.closest('details') : null;
    var pricePerDay  = parseFloat('${vehicle.pricePerDay}') || 0;

    // Set today as minimum pickup date
    var today = new Date();
    var todayStr = today.getFullYear() + '-' +
        String(today.getMonth() + 1).padStart(2, '0') + '-' +
        String(today.getDate()).padStart(2, '0');
    pickup.min = todayStr;

    function addDays(dateStr, n) {
        var d = new Date(dateStr + 'T00:00:00');
        d.setDate(d.getDate() + n);
        return d.getFullYear() + '-' +
            String(d.getMonth() + 1).padStart(2, '0') + '-' +
            String(d.getDate()).padStart(2, '0');
    }

    function updateReturnMin() {
        if (!pickup.value) return;
        var minReturn = addDays(pickup.value, 1);
        ret.min = minReturn;
        if (ret.value && ret.value <= pickup.value) {
            ret.value = minReturn;
        }
        updatePrice();
    }

    function updatePrice() {
        if (!pickup.value || !ret.value) {
            previewBox.style.display = 'none';
            return;
        }
        var p = new Date(pickup.value + 'T00:00:00');
        var r = new Date(ret.value + 'T00:00:00');
        var days = Math.round((r - p) / 86400000);
        if (days > 0) {
            var total = (days * pricePerDay).toFixed(2);
            previewDays.textContent  = days + ' day' + (days > 1 ? 's' : '');
            previewTotal.textContent = 'Rs. ' + Number(total).toLocaleString('en-IN', {minimumFractionDigits: 2});
            previewBox.style.display = 'flex';
        } else {
            previewBox.style.display = 'none';
        }
    }

    // Chevron flip
    if (details && chevron) {
        details.addEventListener('toggle', function () {
            chevron.style.transform = details.open ? 'rotate(180deg)' : 'rotate(0deg)';
        });
        // Sync initial state (details is open by default)
        if (details.open) chevron.style.transform = 'rotate(180deg)';
    }

    pickup.addEventListener('change', updateReturnMin);
    ret.addEventListener('change', updatePrice);

    // Initialise on page load (for back-navigation with values preserved)
    if (pickup.value) updateReturnMin();
    updatePrice();
})();
</script>

</body>
</html>
