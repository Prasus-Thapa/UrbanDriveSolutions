<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Blogs — Urban Drive Solutions</title>
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
            <a href="${pageContext.request.contextPath}/blogs" class="active">Blogs</a>
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

<main class="page-topnav">

    <!-- Header -->
    <div class="page-header">
        <div>
            <span class="page-eyebrow">Insights &amp; Travel</span>
            <h1 class="page-title" style="font-size:clamp(2.5rem,7vw,5rem); letter-spacing:-0.04em;">THE BLOG.</h1>
            <p class="page-subtitle" style="font-size:1.05rem; max-width:36rem; margin-top:0.75rem;">
                Road trip guides, driving tips, and travel inspiration from across Nepal.
            </p>
        </div>
    </div>

    <!-- Blog Grid -->
    <div style="display:grid; grid-template-columns:repeat(auto-fill,minmax(300px,1fr)); gap:1.5rem; margin-bottom:3rem;">

        <!-- Post 1 -->
        <div class="card" style="overflow:hidden;">
            <div style="background:#f1f5f9; height:180px; display:flex; align-items:center; justify-content:center;">
                <span class="material-symbols-outlined" style="font-size:4rem; color:var(--n-300);">landscape</span>
            </div>
            <div class="card-body">
                <p style="font-size:0.7rem; font-weight:700; letter-spacing:0.1em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.5rem;">
                    Travel Guide · Apr 10, 2026
                </p>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.15rem; font-weight:700; letter-spacing:-0.02em; margin-bottom:0.75rem; line-height:1.35;">
                    Top 5 Mountain Road Trips in Nepal
                </h2>
                <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65; margin-bottom:1.25rem;">
                    From Kathmandu to Mustang, Nepal's mountain roads offer some of the most breathtaking drives on the planet. Here are five routes you can't miss this season.
                </p>
                <a href="#" style="font-size:0.8rem; font-weight:600; color:#000; text-decoration:none; display:flex; align-items:center; gap:0.25rem;">
                    Read More <span class="material-symbols-outlined" style="font-size:16px;">arrow_forward</span>
                </a>
            </div>
        </div>

        <!-- Post 2 -->
        <div class="card" style="overflow:hidden;">
            <div style="background:#f0fdf4; height:180px; display:flex; align-items:center; justify-content:center;">
                <span class="material-symbols-outlined" style="font-size:4rem; color:var(--n-300);">directions_car</span>
            </div>
            <div class="card-body">
                <p style="font-size:0.7rem; font-weight:700; letter-spacing:0.1em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.5rem;">
                    Rental Tips · Mar 22, 2026
                </p>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.15rem; font-weight:700; letter-spacing:-0.02em; margin-bottom:0.75rem; line-height:1.35;">
                    How to Choose the Right Vehicle for Your Journey
                </h2>
                <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65; margin-bottom:1.25rem;">
                    SUV or sedan? Automatic or manual? Picking the right vehicle can make or break your trip. We break down exactly what to consider before you book.
                </p>
                <a href="#" style="font-size:0.8rem; font-weight:600; color:#000; text-decoration:none; display:flex; align-items:center; gap:0.25rem;">
                    Read More <span class="material-symbols-outlined" style="font-size:16px;">arrow_forward</span>
                </a>
            </div>
        </div>

        <!-- Post 3 -->
        <div class="card" style="overflow:hidden;">
            <div style="background:#fef9f0; height:180px; display:flex; align-items:center; justify-content:center;">
                <span class="material-symbols-outlined" style="font-size:4rem; color:var(--n-300);">location_city</span>
            </div>
            <div class="card-body">
                <p style="font-size:0.7rem; font-weight:700; letter-spacing:0.1em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.5rem;">
                    Driving Tips · Mar 5, 2026
                </p>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.15rem; font-weight:700; letter-spacing:-0.02em; margin-bottom:0.75rem; line-height:1.35;">
                    Urban Driving Tips for Kathmandu
                </h2>
                <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65; margin-bottom:1.25rem;">
                    Kathmandu traffic can be overwhelming for first-timers. Here's a practical guide to navigating ring roads, one-ways, and peak hour rush like a local.
                </p>
                <a href="#" style="font-size:0.8rem; font-weight:600; color:#000; text-decoration:none; display:flex; align-items:center; gap:0.25rem;">
                    Read More <span class="material-symbols-outlined" style="font-size:16px;">arrow_forward</span>
                </a>
            </div>
        </div>

        <!-- Post 4 -->
        <div class="card" style="overflow:hidden;">
            <div style="background:#fdf2f8; height:180px; display:flex; align-items:center; justify-content:center;">
                <span class="material-symbols-outlined" style="font-size:4rem; color:var(--n-300);">map</span>
            </div>
            <div class="card-body">
                <p style="font-size:0.7rem; font-weight:700; letter-spacing:0.1em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.5rem;">
                    Planning · Feb 14, 2026
                </p>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.15rem; font-weight:700; letter-spacing:-0.02em; margin-bottom:0.75rem; line-height:1.35;">
                    Planning a Weekend Road Trip: A Complete Guide
                </h2>
                <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65; margin-bottom:1.25rem;">
                    Weekend road trips are the perfect escape. From packing essentials to fuel stops and route planning — everything you need for a stress-free getaway.
                </p>
                <a href="#" style="font-size:0.8rem; font-weight:600; color:#000; text-decoration:none; display:flex; align-items:center; gap:0.25rem;">
                    Read More <span class="material-symbols-outlined" style="font-size:16px;">arrow_forward</span>
                </a>
            </div>
        </div>

        <!-- Post 5 -->
        <div class="card" style="overflow:hidden;">
            <div style="background:#f0f4ff; height:180px; display:flex; align-items:center; justify-content:center;">
                <span class="material-symbols-outlined" style="font-size:4rem; color:var(--n-300);">verified_user</span>
            </div>
            <div class="card-body">
                <p style="font-size:0.7rem; font-weight:700; letter-spacing:0.1em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.5rem;">
                    Policy · Jan 30, 2026
                </p>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.15rem; font-weight:700; letter-spacing:-0.02em; margin-bottom:0.75rem; line-height:1.35;">
                    Understanding Rental Cancellation Policies
                </h2>
                <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65; margin-bottom:1.25rem;">
                    Plans change. Knowing your cancellation rights and fees before you book can save you money and stress. A clear breakdown of how our policy works.
                </p>
                <a href="#" style="font-size:0.8rem; font-weight:600; color:#000; text-decoration:none; display:flex; align-items:center; gap:0.25rem;">
                    Read More <span class="material-symbols-outlined" style="font-size:16px;">arrow_forward</span>
                </a>
            </div>
        </div>

        <!-- Post 6 -->
        <div class="card" style="overflow:hidden;">
            <div style="background:#f0fffe; height:180px; display:flex; align-items:center; justify-content:center;">
                <span class="material-symbols-outlined" style="font-size:4rem; color:var(--n-300);">eco</span>
            </div>
            <div class="card-body">
                <p style="font-size:0.7rem; font-weight:700; letter-spacing:0.1em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.5rem;">
                    Sustainability · Jan 12, 2026
                </p>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.15rem; font-weight:700; letter-spacing:-0.02em; margin-bottom:0.75rem; line-height:1.35;">
                    Eco-Friendly Driving: Small Habits, Big Impact
                </h2>
                <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65; margin-bottom:1.25rem;">
                    Fuel-efficient driving is not just good for the environment — it saves you money too. These simple habits can reduce fuel consumption by up to 20%.
                </p>
                <a href="#" style="font-size:0.8rem; font-weight:600; color:#000; text-decoration:none; display:flex; align-items:center; gap:0.25rem;">
                    Read More <span class="material-symbols-outlined" style="font-size:16px;">arrow_forward</span>
                </a>
            </div>
        </div>

        <!-- Post 7 -->
        <div class="card" style="overflow:hidden;">
            <div style="background:#fff7ed; height:180px; display:flex; align-items:center; justify-content:center;">
                <span class="material-symbols-outlined" style="font-size:4rem; color:var(--n-300);">build</span>
            </div>
            <div class="card-body">
                <p style="font-size:0.7rem; font-weight:700; letter-spacing:0.1em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.5rem;">
                    Maintenance · Dec 28, 2025
                </p>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.15rem; font-weight:700; letter-spacing:-0.02em; margin-bottom:0.75rem; line-height:1.35;">
                    What to Check Before You Drive a Rental Car Off the Lot
                </h2>
                <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65; margin-bottom:1.25rem;">
                    Tyres, mirrors, fuel level, scratches — handing back a car you didn't properly inspect at pickup can be an expensive lesson. Here's a 5-minute pre-drive checklist every renter should run through.
                </p>
                <a href="#" style="font-size:0.8rem; font-weight:600; color:#000; text-decoration:none; display:flex; align-items:center; gap:0.25rem;">
                    Read More <span class="material-symbols-outlined" style="font-size:16px;">arrow_forward</span>
                </a>
            </div>
        </div>

        <!-- Post 8 -->
        <div class="card" style="overflow:hidden;">
            <div style="background:#f5f0ff; height:180px; display:flex; align-items:center; justify-content:center;">
                <span class="material-symbols-outlined" style="font-size:4rem; color:var(--n-300);">wb_sunny</span>
            </div>
            <div class="card-body">
                <p style="font-size:0.7rem; font-weight:700; letter-spacing:0.1em; text-transform:uppercase; color:var(--n-400); margin-bottom:0.5rem;">
                    Seasonal Guide · Dec 10, 2025
                </p>
                <h2 style="font-family:'Space Grotesk',sans-serif; font-size:1.15rem; font-weight:700; letter-spacing:-0.02em; margin-bottom:0.75rem; line-height:1.35;">
                    Best Time of Year to Road Trip Across Nepal
                </h2>
                <p style="font-size:0.875rem; color:var(--n-500); line-height:1.65; margin-bottom:1.25rem;">
                    Monsoon washes out passes, winter closes high-altitude roads, and festival seasons bring heavy traffic. Knowing Nepal's travel calendar before you book can save your entire trip.
                </p>
                <a href="#" style="font-size:0.8rem; font-weight:600; color:#000; text-decoration:none; display:flex; align-items:center; gap:0.25rem;">
                    Read More <span class="material-symbols-outlined" style="font-size:16px;">arrow_forward</span>
                </a>
            </div>
        </div>

    </div>

    <!-- Read More -->
    <div style="text-align:center; margin-bottom:3rem;">
        <button class="btn btn-outline btn-lg" disabled style="cursor:default;">Read More Blogs</button>
    </div>

    <!-- Footer -->
    <div class="inner-footer">
        <div>
            <p class="footer-brand-name">Urban Drive Solutions</p>
            <p class="footer-copy">&copy;2026 Urban Drive Solutions</p>
        </div>
        <div class="footer-links">
            <a href="${pageContext.request.contextPath}/vehicles">Browse Fleet</a>
            <a href="${pageContext.request.contextPath}/about">About Us</a>
            <a href="${pageContext.request.contextPath}/policy">Cancellation Policy</a>
        </div>
    </div>

</main>
</body>
</html>
