<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Add New Vehicle — Urban Drive Solutions</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" />
            <link rel="stylesheet"
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
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
                    <a href="${pageContext.request.contextPath}/home" class="sidebar-link"><span
                            class="material-symbols-outlined">home</span><span>Home</span></a>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link"><span
                            class="material-symbols-outlined">dashboard</span><span>Overview</span></a>
                    <a href="${pageContext.request.contextPath}/vehicles" class="sidebar-link active"><span
                            class="material-symbols-outlined">directions_car</span><span>Fleet</span></a>
                    <a href="${pageContext.request.contextPath}/bookings" class="sidebar-link"><span
                            class="material-symbols-outlined">calendar_today</span><span>Bookings</span></a>
                    <a href="${pageContext.request.contextPath}/payments" class="sidebar-link"><span
                            class="material-symbols-outlined">payments</span><span>Revenue</span></a>
                </nav>
                <div class="sidebar-bottom">
                    <div class="sidebar-divider"></div>
                    <a href="${pageContext.request.contextPath}/logout" class="sidebar-link"><span
                            class="material-symbols-outlined">logout</span><span>Logout</span></a>
                </div>
            </aside>

            <!-- ── Main ── -->
            <main class="page-sidebar">

                <!-- Header -->
                <div class="page-header">
                    <div>
                        <a href="${pageContext.request.contextPath}/vehicles" class="back-link">
                            <span class="material-symbols-outlined">arrow_back</span>Back to Fleet
                        </a>
                        <span class="page-eyebrow">Fleet Management</span>
                        <h1 class="page-title">Add New Vehicle</h1>
                    </div>
                </div>

                <!-- Error -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error">
                        <span class="material-symbols-outlined">error</span>${errorMessage}
                    </div>
                </c:if>

                <!-- Form -->
                <div style="max-width:42rem;">
                    <div class="card">
                        <div class="card-body-lg">
                            <form action="${pageContext.request.contextPath}/vehicles/add" method="post"
                                class="form-space">

                                <div class="form-grid-2">
                                    <div class="form-group">
                                        <label class="form-label" for="brand">Brand</label>
                                        <input id="brand" type="text" name="brand" value="${brand}" required
                                            placeholder="e.g. Toyota" class="form-input" />
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label" for="model">Model</label>
                                        <input id="model" type="text" name="model" value="${model}" required
                                            placeholder="e.g. Camry" class="form-input" />
                                    </div>
                                </div>

                                <div class="form-grid-2">
                                    <div class="form-group">
                                        <label class="form-label" for="vehicleType">Vehicle Type</label>
                                        <input id="vehicleType" type="text" name="vehicleType" value="${vehicleType}"
                                            required placeholder="e.g. Sedan, SUV" class="form-input" />
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label" for="registrationNumber">Registration Number</label>
                                        <input id="registrationNumber" type="text" name="registrationNumber"
                                            value="${registrationNumber}" required placeholder="e.g. BA 1 CHA 1234"
                                            class="form-input" />
                                    </div>
                                </div>

                                <div class="form-grid-2">
                                    <div class="form-group">
                                        <label class="form-label" for="color">Color</label>
                                        <input id="color" type="text" name="color" value="${color}" required
                                            placeholder="e.g. Pearl White" class="form-input" />
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label" for="seats">Number of Seats</label>
                                        <input id="seats" type="number" name="seats" min="1" value="${seats}" required
                                            placeholder="5" class="form-input" />
                                    </div>
                                </div>

                                <div class="form-grid-2">
                                    <div class="form-group">
                                        <label class="form-label" for="pricePerDay">Price Per Day (Rs.)</label>
                                        <input id="pricePerDay" type="number" step="0.01" name="pricePerDay" min="0.01"
                                            value="${pricePerDay}" required placeholder="2500.00" class="form-input" />
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label" for="availabilityStatus">Availability Status</label>
                                        <select id="availabilityStatus" name="availabilityStatus" required
                                            class="form-input">
                                            <option value="AVAILABLE" <c:if
                                                test="${availabilityStatus == 'AVAILABLE' || empty availabilityStatus}">
                                                selected</c:if>>Available</option>
                                            <option value="BOOKED" <c:if test="${availabilityStatus == 'BOOKED'}">
                                                selected</c:if>>Booked</option>
                                            <option value="MAINTENANCE" <c:if
                                                test="${availabilityStatus == 'MAINTENANCE'}">selected</c:if>
                                                >Maintenance</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary btn-md">
                                        <span class="material-symbols-outlined">add</span>Add Vehicle
                                    </button>
                                    <a href="${pageContext.request.contextPath}/vehicles"
                                        class="btn btn-outline btn-md">Cancel</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <div class="inner-footer">
                    <div>
                        <p class="footer-brand-name">Urban Drive Solutions</p>
                        <p class="footer-copy">&copy;2026 Urban Drive Solutions — Internal Admin Portal</p>
                    </div>
                </div>

            </main>
        </body>

        </html>