<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bookings</title>
</head>
<body>

<c:choose>
    <c:when test="${isAdmin}">
        <h1>All Bookings</h1>
    </c:when>
    <c:otherwise>
        <h1>My Bookings</h1>
    </c:otherwise>
</c:choose>

<p style="color: green;">${successMessage}</p>
<p style="color: red;">${errorMessage}</p>

<p><a href="${pageContext.request.contextPath}/dashboard">Back to Dashboard</a></p>
<p><a href="${pageContext.request.contextPath}/vehicles">Vehicles</a></p>
<p><a href="${pageContext.request.contextPath}/logout">Logout</a></p>

<c:if test="${empty bookings}">
    <p>No bookings found.</p>
</c:if>

<c:if test="${not empty bookings}">
    <table border="1" cellpadding="10" cellspacing="0">
        <tr>
            <th>Booking ID</th>
            <c:if test="${isAdmin}">
                <th>Customer</th>
            </c:if>
            <th>Vehicle</th>
            <th>Registration Number</th>
            <th>Pickup Date</th>
            <th>Return Date</th>
            <th>Total Amount</th>
            <th>Status</th>
        </tr>

        <c:forEach var="booking" items="${bookings}">
            <tr>
                <td>${booking.bookingId}</td>
                <c:if test="${isAdmin}">
                    <td>${booking.customerName}</td>
                </c:if>
                <td>${booking.vehicleName}</td>
                <td>${booking.registrationNumber}</td>
                <td>${booking.pickupDate}</td>
                <td>${booking.returnDate}</td>
                <td>${booking.totalAmount}</td>
                <td>${booking.bookingStatus}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

</body>
</html>
