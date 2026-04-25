<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Complete Payment — Urban Drive Solutions</title>
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
            <a href="${pageContext.request.contextPath}/vehicles">Browse Fleet</a>
            <a href="${pageContext.request.contextPath}/bookings" class="active">My Bookings</a>
            <a href="${pageContext.request.contextPath}/payments">My Payments</a>
            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
        </div>
        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/bookings" class="btn btn-outline btn-md">← My Bookings</a>
            <a href="${pageContext.request.contextPath}/logout"   class="btn btn-primary btn-md">Logout</a>
        </div>
    </div>
</nav>

<main class="page-topnav">

    <!-- Header -->
    <div class="page-header">
        <div>
            <span class="page-eyebrow">Checkout</span>
            <h1 class="page-title">Review &amp; Pay</h1>
            <p class="page-subtitle">Complete your payment to confirm your booking</p>
        </div>
    </div>

    <!-- Error -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">
            <span class="material-symbols-outlined">error</span>${errorMessage}
        </div>
    </c:if>

    <!-- Layout -->
    <div class="pay-col">

        <!-- Order Summary -->
        <div class="card">
            <div class="card-body">
                <p style="font-size:0.625rem; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; color:var(--n-400); margin-bottom:1.5rem;">Order Summary</p>

                <div class="order-row">
                    <span class="order-row-label">Booking ID</span>
                    <span class="order-row-value" style="font-family:monospace;">#${payment.bookingId}</span>
                </div>
                <div class="order-row">
                    <span class="order-row-label">Vehicle</span>
                    <span class="order-row-value">${payment.vehicleName}</span>
                </div>
                <div class="order-row">
                    <span class="order-row-label">Payment Status</span>
                    <span class="badge badge-pending">${payment.paymentStatus}</span>
                </div>
                <div class="order-row" style="margin-top:0.5rem; border-bottom:none; padding-top:1rem;">
                    <span class="order-row-label" style="font-weight:700; text-transform:uppercase; letter-spacing:0.08em; font-size:0.75rem;">Total Amount</span>
                    <span class="order-row-value big">Rs. ${payment.amount}</span>
                </div>
            </div>
        </div>

        <!-- Payment Form -->
        <div class="card">
            <div class="card-body">
                <p style="font-size:0.625rem; font-weight:700; text-transform:uppercase; letter-spacing:0.1em; color:var(--n-400); margin-bottom:1.5rem;">Payment Details</p>

                <form action="${pageContext.request.contextPath}/payments/pay" method="post" class="form-space">
                    <input type="hidden" name="bookingId" value="${payment.bookingId}">

                    <div class="form-group">
                        <label class="form-label">Select Payment Method</label>
                        <div style="display:flex; flex-direction:column; gap:0.75rem; margin-top:0.375rem;">
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="CARD" <c:if test="${selectedMethod == 'CARD'}">checked</c:if>/>
                                <span class="material-symbols-outlined" style="color:var(--n-600);">credit_card</span>
                                <span class="payment-option-label">Credit / Debit Card</span>
                            </label>
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="ESEWA" <c:if test="${selectedMethod == 'ESEWA'}">checked</c:if>/>
                                <span class="material-symbols-outlined" style="color:#16a34a;">account_balance_wallet</span>
                                <span class="payment-option-label">eSewa</span>
                            </label>
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="KHALTI" <c:if test="${selectedMethod == 'KHALTI'}">checked</c:if>/>
                                <span class="material-symbols-outlined" style="color:#9333ea;">account_balance_wallet</span>
                                <span class="payment-option-label">Khalti</span>
                            </label>
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="CONNECT_IPS" <c:if test="${selectedMethod == 'CONNECT_IPS'}">checked</c:if>/>
                                <span class="material-symbols-outlined" style="color:#2563eb;">account_balance</span>
                                <span class="payment-option-label">connectIPS</span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="transactionCode">Transaction Code / Reference</label>
                        <input id="transactionCode" type="text" name="transactionCode" value="${transactionCode}"
                               required placeholder="Enter your transaction reference code" class="form-input"/>
                        <p class="form-hint">Enter the transaction code from your payment app or bank</p>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg btn-full">
                        <span class="material-symbols-outlined">lock</span>Complete Payment — Rs. ${payment.amount}
                    </button>
                    <p style="font-size:0.75rem; color:var(--n-400); text-align:center;">
                        Your payment is secured. By proceeding, you agree to our terms.
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
