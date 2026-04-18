<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payments</title>
</head>
<body>

<c:choose>
    <c:when test="${isAdmin}">
        <h1>All Payments</h1>
    </c:when>
    <c:otherwise>
        <h1>My Payments</h1>
    </c:otherwise>
</c:choose>

<p style="color: green;">${successMessage}</p>
<p style="color: red;">${errorMessage}</p>

<p><a href="${pageContext.request.contextPath}/dashboard">Back to Dashboard</a></p>
<p><a href="${pageContext.request.contextPath}/bookings">Bookings</a></p>
<p><a href="${pageContext.request.contextPath}/logout">Logout</a></p>

<c:if test="${empty payments}">
    <p>No payments found.</p>
</c:if>

<c:if test="${not empty payments}">
    <table border="1" cellpadding="10" cellspacing="0">
        <tr>
            <th>Payment ID</th>
            <th>Booking ID</th>
            <c:if test="${isAdmin}">
                <th>Customer</th>
            </c:if>
            <th>Vehicle</th>
            <th>Amount</th>
            <th>Method</th>
            <th>Status</th>
            <th>Transaction Code</th>
            <th>Payment Date</th>
        </tr>

        <c:forEach var="payment" items="${payments}">
            <tr>
                <td>${payment.paymentId}</td>
                <td>${payment.bookingId}</td>
                <c:if test="${isAdmin}">
                    <td>${payment.customerName}</td>
                </c:if>
                <td>${payment.vehicleName}</td>
                <td>${payment.amount}</td>
                <td>${empty payment.paymentMethod ? '-' : payment.paymentMethod}</td>
                <td>${payment.paymentStatus}</td>
                <td>${empty payment.transactionCode ? '-' : payment.transactionCode}</td>
                <td>${payment.paymentDate}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

</body>
</html>
