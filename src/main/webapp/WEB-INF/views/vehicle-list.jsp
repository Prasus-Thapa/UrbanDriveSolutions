<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <c:choose>
        <c:when test="${isAdmin}">
            <title>Manage Fleet — Urban Drive Solutions</title>
            <meta name="description" content="Admin fleet management — add, edit and manage all vehicles."/>
        </c:when>
        <c:otherwise>
            <title>Browse the Fleet — Urban Drive Solutions</title>
            <meta name="description" content="Browse our curated selection of premium vehicles available for rent in Nepal."/>
        </c:otherwise>
    </c:choose>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
    <style>
        /* ── Filter sidebar layout ── */
        .fleet-layout  { display:flex; gap:1.75rem; align-items:flex-start; }
        .fleet-filter  { width:260px; flex-shrink:0; position:sticky; top:1.5rem; background:#fff; border:1px solid #e5e7eb; border-radius:0.875rem; padding:1.5rem; }
        .fleet-results { flex:1; min-width:0; }

        /* ── Filter components ── */
        .filter-section { border-bottom:1px solid #f3f4f6; padding-bottom:1.25rem; margin-bottom:1.25rem; }
        .filter-section:last-of-type { border-bottom:none; padding-bottom:0; margin-bottom:0; }
        .filter-title { font-size:0.7rem; font-weight:700; letter-spacing:0.1em; text-transform:uppercase; color:#9ca3af; margin-bottom:0.875rem; }

        /* ── Seat pills ── */
        .seat-option input[type=radio] { display:none; }
        .seat-option input[type=radio]:checked + .seat-label { background:#000; color:#fff; border-color:#000; }
        .seat-label { display:inline-block; padding:0.35rem 0.85rem; border:1.5px solid #e5e7eb; border-radius:2rem; font-size:0.78rem; font-weight:600; cursor:pointer; color:#111; transition:border-color .15s, background .15s; }
        .seat-label:hover { border-color:#000; }

        /* ── Price slider ── */
        .price-slider { width:100%; accent-color:#000; margin-top:0.5rem; cursor:pointer; }

        @media (max-width: 768px) {
            .fleet-layout { flex-direction:column; }
            .fleet-filter { width:100%; position:static; }
        }
    </style>
</head>
<body>

<c:choose>
<%-- ═══ ADMIN VIEW ═══ --%>
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
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link"><span class="material-symbols-outlined">dashboard</span><span>Overview</span></a>
        <a href="${pageContext.request.contextPath}/vehicles"        class="sidebar-link active"><span class="material-symbols-outlined">directions_car</span><span>Fleet</span></a>
        <a href="${pageContext.request.contextPath}/bookings"        class="sidebar-link"><span class="material-symbols-outlined">calendar_today</span><span>Bookings</span></a>
        <a href="${pageContext.request.contextPath}/payments"        class="sidebar-link"><span class="material-symbols-outlined">payments</span><span>Revenue</span></a>
    </nav>
    <div class="sidebar-bottom">
        <div class="sidebar-divider"></div>
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link"><span class="material-symbols-outlined">logout</span><span>Logout</span></a>
    </div>
</aside>
<main class="page-sidebar">
</c:when>

<%-- ═══ USER / GUEST VIEW ═══ --%>
<c:otherwise>
<nav class="top-nav">
    <div class="top-nav-inner">
        <a href="${pageContext.request.contextPath}/home" class="nav-brand">Urban Drive Solutions</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/vehicles" class="active">Browse Fleet</a>
            <a href="${pageContext.request.contextPath}/blogs">Blogs</a>
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
</c:otherwise>
</c:choose>

    <!-- ── Page Header ── -->
    <div class="page-header">
        <div>
            <span class="page-eyebrow">
                <c:choose>
                    <c:when test="${isAdmin}">Fleet Management</c:when>
                    <c:otherwise>Premium Vehicles</c:otherwise>
                </c:choose>
            </span>
            <c:choose>
                <c:when test="${isAdmin}">
                    <h1 class="page-title">Manage Fleet</h1>
                </c:when>
                <c:otherwise>
                    <h1 class="page-title" style="font-size:clamp(3rem,8vw,6rem); letter-spacing:-0.04em;">THE FLEET.</h1>
                    <p class="page-subtitle" style="font-size:1.05rem; max-width:36rem; margin-top:0.75rem;">
                        Curated precision. Explore our collection of premium vehicles tailored for every journey.
                    </p>
                </c:otherwise>
            </c:choose>
        </div>
        <c:if test="${isAdmin}">
            <a href="${pageContext.request.contextPath}/vehicles/add" class="btn btn-primary btn-md">
                <span class="material-symbols-outlined">add</span>Add Vehicle
            </a>
        </c:if>
    </div>

    <%-- ══════════════════════════════════════════════════════════
         USER / GUEST — two-column layout: filter left, cards right
         ══════════════════════════════════════════════════════════ --%>
    <c:if test="${not isAdmin}">
    <div class="fleet-layout">

        <%-- ── LEFT: Filter Sidebar ── --%>
        <aside class="fleet-filter">
            <form method="get" action="${pageContext.request.contextPath}/vehicles">

                <%-- Vehicle Type --%>
                <div class="filter-section">
                    <p class="filter-title">Vehicle Type</p>
                    <select name="vehicleType" class="form-input">
                        <option value="">All Types</option>
                        <c:forEach var="type" items="${vehicleTypes}">
                            <option value="${type}" <c:if test="${filterVehicleType == type}">selected</c:if>>${type}</option>
                        </c:forEach>
                    </select>
                </div>

                <%-- Brand --%>
                <div class="filter-section">
                    <p class="filter-title">Brand</p>
                    <select name="brand" class="form-input">
                        <option value="">All Brands</option>
                        <c:forEach var="b" items="${brands}">
                            <option value="${b}" <c:if test="${filterBrand == b}">selected</c:if>>${b}</option>
                        </c:forEach>
                    </select>
                </div>

                <%-- Seats --%>
                <div class="filter-section">
                    <p class="filter-title">Seats</p>
                    <div style="display:flex; gap:0.4rem; flex-wrap:wrap;">
                        <label class="seat-option">
                            <input type="radio" name="seats" value="" <c:if test="${empty filterSeats}">checked</c:if>/>
                            <span class="seat-label">All</span>
                        </label>
                        <label class="seat-option">
                            <input type="radio" name="seats" value="2" <c:if test="${filterSeats == 2}">checked</c:if>/>
                            <span class="seat-label">2</span>
                        </label>
                        <label class="seat-option">
                            <input type="radio" name="seats" value="4" <c:if test="${filterSeats == 4}">checked</c:if>/>
                            <span class="seat-label">4</span>
                        </label>
                        <label class="seat-option">
                            <input type="radio" name="seats" value="6" <c:if test="${filterSeats == 6}">checked</c:if>/>
                            <span class="seat-label">6</span>
                        </label>
                        <label class="seat-option">
                            <input type="radio" name="seats" value="8" <c:if test="${filterSeats == 8}">checked</c:if>/>
                            <span class="seat-label">8</span>
                        </label>
                    </div>
                </div>

                <%-- Price per day --%>
                <div class="filter-section">
                    <p class="filter-title">Price per day</p>
                    <p style="font-size:0.875rem; font-weight:700; color:#111; margin-bottom:0.25rem;">
                        Rs. <span id="priceVal">${filterMaxPrice}</span>
                    </p>
                    <input type="range" name="maxPrice" id="priceSlider"
                           class="price-slider"
                           min="0"
                           max="${overallMaxPrice}"
                           step="1"
                           value="${filterMaxPrice}"
                           oninput="document.getElementById('priceVal').textContent = Math.round(this.value)"/>
                    <div style="display:flex; justify-content:space-between; font-size:0.68rem; color:#9ca3af; margin-top:0.3rem;">
                        <span>Rs. 0</span>
                        <span>Rs. ${overallMaxPrice}</span>
                    </div>
                </div>

                <%-- Actions --%>
                <div style="display:flex; flex-direction:column; gap:0.6rem; margin-top:1.25rem;">
                    <button type="submit" class="btn btn-primary btn-md btn-full">
                        <span class="material-symbols-outlined">search</span>Search
                    </button>
                    <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-outline btn-md btn-full" style="text-align:center;">
                        Reset Filters
                    </a>
                </div>

            </form>
        </aside>

        <%-- ── RIGHT: Results ── --%>
        <div class="fleet-results">

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success"><span class="material-symbols-outlined">check_circle</span>${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error"><span class="material-symbols-outlined">error</span>${errorMessage}</div>
            </c:if>

            <c:if test="${empty vehicles}">
                <div class="empty-state">
                    <span class="material-symbols-outlined empty-icon">garage</span>
                    <p class="empty-title">No vehicles match your filters</p>
                    <a href="${pageContext.request.contextPath}/vehicles" class="btn btn-outline btn-md">Clear Filters</a>
                </div>
            </c:if>

            <c:if test="${not empty vehicles}">
                <div class="vehicle-grid">
                    <c:forEach var="vehicle" items="${vehicles}">
                        <div class="v-card">
                            <div class="v-card-img">
                                <span class="material-symbols-outlined">directions_car</span>
                                <span class="v-card-status">
                                    <span class="badge badge-available">Available</span>
                                </span>
                            </div>
                            <div class="v-card-body">
                                <p class="v-card-type">${vehicle.vehicleType} · ${vehicle.color} · ${vehicle.seats} seats</p>
                                <h3 class="v-card-name">${vehicle.brand} ${vehicle.model}</h3>
                                <p class="v-card-reg">${vehicle.registrationNumber}</p>
                                <div class="v-card-footer">
                                    <div>
                                        <p class="v-price-label">Per day</p>
                                        <p class="v-price">Rs. ${vehicle.pricePerDay}</p>
                                    </div>
                                    <c:choose>
                                        <c:when test="${loggedIn}">
                                            <a href="${pageContext.request.contextPath}/bookings/add?vehicleId=${vehicle.vehicleId}"
                                               class="btn btn-primary btn-sm">Book Now</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/login"
                                               class="btn btn-primary btn-sm">Book Now</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

        </div><%-- end fleet-results --%>
    </div><%-- end fleet-layout --%>
    </c:if>

    <%-- ══════════════════════════════
         ADMIN — full-width table view
         ══════════════════════════════ --%>
    <c:if test="${isAdmin}">
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success"><span class="material-symbols-outlined">check_circle</span>${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error"><span class="material-symbols-outlined">error</span>${errorMessage}</div>
        </c:if>

        <c:if test="${empty vehicles}">
            <div class="empty-state">
                <span class="material-symbols-outlined empty-icon">garage</span>
                <p class="empty-title">No vehicles found</p>
                <a href="${pageContext.request.contextPath}/vehicles/add" class="btn btn-primary btn-md">Add First Vehicle</a>
            </div>
        </c:if>

        <c:if test="${not empty vehicles}">
            <div class="table-wrapper">
                <div class="table-scroll">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Vehicle</th>
                                <th>Type</th>
                                <th>Reg. No.</th>
                                <th>Color</th>
                                <th>Seats</th>
                                <th>Price/Day</th>
                                <th>Status</th>
                                <th class="t-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="vehicle" items="${vehicles}">
                                <tr>
                                    <td class="td-id">#${vehicle.vehicleId}</td>
                                    <td class="td-bold">${vehicle.brand} ${vehicle.model}</td>
                                    <td class="td-muted">${vehicle.vehicleType}</td>
                                    <td class="td-mono">${vehicle.registrationNumber}</td>
                                    <td class="td-muted">${vehicle.color}</td>
                                    <td class="td-muted">${vehicle.seats}</td>
                                    <td class="td-bold">Rs. ${vehicle.pricePerDay}/day</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${vehicle.availabilityStatus == 'AVAILABLE'}"><span class="badge badge-available">Available</span></c:when>
                                            <c:when test="${vehicle.availabilityStatus == 'MAINTENANCE'}"><span class="badge badge-maintenance">Maintenance</span></c:when>
                                            <c:otherwise><span class="badge badge-maintenance">${vehicle.availabilityStatus}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="t-right">
                                        <div class="td-actions">
                                            <a href="${pageContext.request.contextPath}/vehicles/edit?id=${vehicle.vehicleId}" class="tbl-link">Edit</a>
                                            <form action="${pageContext.request.contextPath}/vehicles/delete" method="post"
                                                  style="display:inline;" onsubmit="return confirm('Delete this vehicle?')">
                                                <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
                                                <button type="submit" class="tbl-link danger">Delete</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
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
                    <a href="${pageContext.request.contextPath}/bookings">Bookings</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/home">Home</a>
                    <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

<script>
    var slider = document.getElementById('priceSlider');
    var display = document.getElementById('priceVal');
    if (slider && display) {
        display.textContent = Math.round(slider.value);
    }
</script>
</main>
</body>
</html>
