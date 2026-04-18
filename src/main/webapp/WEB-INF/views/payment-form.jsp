<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
</head>
<body>
<h1>Complete Payment</h1>

<p style="color: red;">${errorMessage}</p>

<p><strong>Booking ID:</strong> ${payment.bookingId}</p>
<p><strong>Vehicle:</strong> ${payment.vehicleName}</p>
<p><strong>Amount:</strong> ${payment.amount}</p>
<p><strong>Status:</strong> ${payment.paymentStatus}</p>

<form action="${pageContext.request.contextPath}/payments/pay" method="post">
    <input type="hidden" name="bookingId" value="${payment.bookingId}">

    <label>Payment Method:</label><br>
    <select name="paymentMethod" required>
        <option value="">Select Payment Method</option>
        <option value="CARD" <c:if test="${selectedMethod == 'CARD'}">selected</c:if>>Card</option>
        <option value="ESEWA" <c:if test="${selectedMethod == 'ESEWA'}">selected</c:if>>eSewa</option>
        <option value="KHALTI" <c:if test="${selectedMethod == 'KHALTI'}">selected</c:if>>Khalti</option>
        <option value="CONNECT_IPS" <c:if test="${selectedMethod == 'CONNECT_IPS'}">selected</c:if>>connectIPS</option>
    </select><br><br>

    <label>Transaction Code:</label><br>
    <input type="text" name="transactionCode" value="${transactionCode}" required><br><br>

    <button type="submit">Pay Now</button>
</form>

<p><a href="${pageContext.request.contextPath}/bookings">Back to Bookings</a></p>
<p><a href="${pageContext.request.contextPath}/payments">My Payments</a></p>
</body>
</html>
