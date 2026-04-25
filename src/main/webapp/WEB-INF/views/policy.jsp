<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Cancellation &amp; Rental Policy — Urban Drive Solutions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
</head>
<body>

<!-- ── Nav ── -->
<nav class="top-nav">
    <div class="top-nav-inner">
        <a href="${pageContext.request.contextPath}/home" class="nav-brand">Urban Drive Solutions</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Home</a>
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

<main class="page-topnav">

    <!-- Header -->
    <div class="page-header">
        <div>
            <span class="page-eyebrow">Transparency First</span>
            <h1 class="page-title" style="font-size:clamp(2.5rem,7vw,5rem); letter-spacing:-0.04em;">OUR POLICY.</h1>
            <p class="page-subtitle" style="font-size:1.05rem; max-width:40rem; margin-top:0.75rem;">
                No fine print. No surprises. Everything you need to know about cancellations, payments, and your rental — clearly explained.
            </p>
        </div>
    </div>

    <!-- Cancellation Policy -->
    <div class="card" style="margin-bottom:1.5rem;">
        <div class="card-body">
            <div style="display:flex; align-items:center; gap:0.75rem; margin-bottom:1.5rem;">
                <span class="material-symbols-outlined" style="font-size:1.75rem;">event_busy</span>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.35rem; font-weight:800; letter-spacing:-0.02em;">Cancellation Policy</h2>
            </div>
            <p style="font-size:0.9rem; color:var(--n-500); line-height:1.75; margin-bottom:1.5rem;">
                We understand that plans change. Our cancellation fees are based on how much notice you give us before your scheduled pickup date. The earlier you cancel, the less you pay.
            </p>

            <!-- Fee Tiers -->
            <div style="display:grid; grid-template-columns:repeat(auto-fill,minmax(220px,1fr)); gap:1rem; margin-bottom:1.5rem;">

                <div style="border:1px solid #d1fae5; border-radius:0.75rem; padding:1.25rem; background:#f0fdf4;">
                    <div style="display:flex; align-items:center; gap:0.5rem; margin-bottom:0.5rem;">
                        <span class="material-symbols-outlined" style="color:#16a34a; font-size:1.25rem;">check_circle</span>
                        <span style="font-weight:700; font-size:0.9rem; color:#15803d;">No Fee</span>
                    </div>
                    <p style="font-size:0.8rem; font-weight:700; margin-bottom:0.25rem;">2 or more days before pickup</p>
                    <p style="font-size:0.8rem; color:var(--n-500); line-height:1.55;">Cancel at least 2 days before your pickup date and receive a full refund — no questions asked.</p>
                </div>

                <div style="border:1px solid #fef9c3; border-radius:0.75rem; padding:1.25rem; background:#fefce8;">
                    <div style="display:flex; align-items:center; gap:0.5rem; margin-bottom:0.5rem;">
                        <span class="material-symbols-outlined" style="color:#ca8a04; font-size:1.25rem;">schedule</span>
                        <span style="font-weight:700; font-size:0.9rem; color:#a16207;">20% Fee</span>
                    </div>
                    <p style="font-size:0.8rem; font-weight:700; margin-bottom:0.25rem;">The day before pickup</p>
                    <p style="font-size:0.8rem; color:var(--n-500); line-height:1.55;">A 20% cancellation fee is deducted; the remaining 80% is refunded to your original payment method.</p>
                </div>

                <div style="border:1px solid #fed7aa; border-radius:0.75rem; padding:1.25rem; background:#fff7ed;">
                    <div style="display:flex; align-items:center; gap:0.5rem; margin-bottom:0.5rem;">
                        <span class="material-symbols-outlined" style="color:#ea580c; font-size:1.25rem;">warning</span>
                        <span style="font-weight:700; font-size:0.9rem; color:#c2410c;">50% Fee</span>
                    </div>
                    <p style="font-size:0.8rem; font-weight:700; margin-bottom:0.25rem;">On the pickup date itself</p>
                    <p style="font-size:0.8rem; color:var(--n-500); line-height:1.55;">A 50% cancellation fee applies if you cancel on the same day as your scheduled pickup. The remaining 50% is refunded within 3–5 business days.</p>
                </div>

                <div style="border:1px solid #fecaca; border-radius:0.75rem; padding:1.25rem; background:#fef2f2;">
                    <div style="display:flex; align-items:center; gap:0.5rem; margin-bottom:0.5rem;">
                        <span class="material-symbols-outlined" style="color:#dc2626; font-size:1.25rem;">cancel</span>
                        <span style="font-weight:700; font-size:0.9rem; color:#b91c1c;">Non-Refundable</span>
                    </div>
                    <p style="font-size:0.8rem; font-weight:700; margin-bottom:0.25rem;">After the pickup date</p>
                    <p style="font-size:0.8rem; color:var(--n-500); line-height:1.55;">Cancellations made after the pickup date has passed are non-refundable as the vehicle was reserved for your exclusive use.</p>
                </div>

            </div>

            <div style="background:#f8f9fa; border-radius:0.75rem; padding:1rem 1.25rem; font-size:0.8rem; color:var(--n-500); line-height:1.65;">
                <span class="material-symbols-outlined" style="font-size:0.9rem; vertical-align:middle; margin-right:0.25rem;">info</span>
                Refunds are processed to your original payment method (eSewa, Khalti, Connect IPS, or card). Processing time may vary by payment provider — typically 3–5 business days.
            </div>
        </div>
    </div>

    <!-- Payment Policy -->
    <div class="card" style="margin-bottom:1.5rem;">
        <div class="card-body">
            <div style="display:flex; align-items:center; gap:0.75rem; margin-bottom:1.25rem;">
                <span class="material-symbols-outlined" style="font-size:1.75rem;">payments</span>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.35rem; font-weight:800; letter-spacing:-0.02em;">Payment Policy</h2>
            </div>
            <ul style="list-style:none; padding:0; margin:0; display:flex; flex-direction:column; gap:0.875rem;">
                <li style="display:flex; gap:0.75rem; font-size:0.9rem; color:var(--n-500); line-height:1.65;">
                    <span class="material-symbols-outlined" style="font-size:1rem; flex-shrink:0; margin-top:2px; color:#000;">arrow_right</span>
                    Payment is required in full at the time of booking confirmation. Your booking remains in <strong style="color:#000;">PENDING</strong> status until payment is completed.
                </li>
                <li style="display:flex; gap:0.75rem; font-size:0.9rem; color:var(--n-500); line-height:1.65;">
                    <span class="material-symbols-outlined" style="font-size:1rem; flex-shrink:0; margin-top:2px; color:#000;">arrow_right</span>
                    We accept <strong style="color:#000;">eSewa, Khalti, Connect IPS, and Card</strong> payments. All transactions are processed securely.
                </li>
                <li style="display:flex; gap:0.75rem; font-size:0.9rem; color:var(--n-500); line-height:1.65;">
                    <span class="material-symbols-outlined" style="font-size:1rem; flex-shrink:0; margin-top:2px; color:#000;">arrow_right</span>
                    Your full payment history is always accessible from the <strong style="color:#000;">My Payments</strong> section of your dashboard.
                </li>
                <li style="display:flex; gap:0.75rem; font-size:0.9rem; color:var(--n-500); line-height:1.65;">
                    <span class="material-symbols-outlined" style="font-size:1rem; flex-shrink:0; margin-top:2px; color:#000;">arrow_right</span>
                    Total rental cost is calculated as: <strong style="color:#000;">Daily Rate × Number of Days</strong>. The exact amount is shown before you confirm.
                </li>
            </ul>
        </div>
    </div>

    <!-- Vehicle Use Policy -->
    <div class="card" style="margin-bottom:1.5rem;">
        <div class="card-body">
            <div style="display:flex; align-items:center; gap:0.75rem; margin-bottom:1.25rem;">
                <span class="material-symbols-outlined" style="font-size:1.75rem;">directions_car</span>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.35rem; font-weight:800; letter-spacing:-0.02em;">Vehicle Use Policy</h2>
            </div>
            <ul style="list-style:none; padding:0; margin:0; display:flex; flex-direction:column; gap:0.875rem;">
                <li style="display:flex; gap:0.75rem; font-size:0.9rem; color:var(--n-500); line-height:1.65;">
                    <span class="material-symbols-outlined" style="font-size:1rem; flex-shrink:0; margin-top:2px; color:#000;">arrow_right</span>
                    A valid driver's license matching your registered license number is required at vehicle pickup. No license, no rental.
                </li>
                <li style="display:flex; gap:0.75rem; font-size:0.9rem; color:var(--n-500); line-height:1.65;">
                    <span class="material-symbols-outlined" style="font-size:1rem; flex-shrink:0; margin-top:2px; color:#000;">arrow_right</span>
                    Vehicles must be returned by the end of your <strong style="color:#000;">return date</strong>. Late returns may incur additional daily charges.
                </li>
                <li style="display:flex; gap:0.75rem; font-size:0.9rem; color:var(--n-500); line-height:1.65;">
                    <span class="material-symbols-outlined" style="font-size:1rem; flex-shrink:0; margin-top:2px; color:#000;">arrow_right</span>
                    The renter is responsible for any damages, traffic violations, or fines incurred during the rental period.
                </li>
                <li style="display:flex; gap:0.75rem; font-size:0.9rem; color:var(--n-500); line-height:1.65;">
                    <span class="material-symbols-outlined" style="font-size:1rem; flex-shrink:0; margin-top:2px; color:#000;">arrow_right</span>
                    Vehicles are provided with a full fuel tank and must be returned with a full tank. Fuel costs for shortfalls will be charged.
                </li>
                <li style="display:flex; gap:0.75rem; font-size:0.9rem; color:var(--n-500); line-height:1.65;">
                    <span class="material-symbols-outlined" style="font-size:1rem; flex-shrink:0; margin-top:2px; color:#000;">arrow_right</span>
                    Subletting or lending the vehicle to a third party not listed in the booking is strictly prohibited.
                </li>
            </ul>
        </div>
    </div>

    <!-- Contact -->
    <div class="card" style="margin-bottom:3rem;">
        <div class="card-body" style="display:flex; flex-wrap:wrap; justify-content:space-between; align-items:center; gap:1.5rem;">
            <div>
                <h3 style="font-family:'Space Grotesk',sans-serif; font-weight:700; font-size:1.1rem; margin-bottom:0.4rem;">Have a question about our policy?</h3>
                <p style="font-size:0.875rem; color:var(--n-500);">Our support team is available 24/7 to help clarify anything before you book.</p>
            </div>
            <a href="${pageContext.request.contextPath}/about" class="btn btn-primary btn-md">Contact Us</a>
        </div>
    </div>

    <!-- Footer -->
    <div class="inner-footer">
        <div>
            <p class="footer-brand-name">Urban Drive Solutions</p>
            <p class="footer-copy">&copy;2026 Urban Drive Solutions — Nepal's Premium Fleet</p>
        </div>
        <div class="footer-links">
            <a href="${pageContext.request.contextPath}/vehicles">Browse Fleet</a>
            <a href="${pageContext.request.contextPath}/blogs">Blogs</a>
            <a href="${pageContext.request.contextPath}/about">About Us</a>
        </div>
    </div>

</main>
</body>
</html>
