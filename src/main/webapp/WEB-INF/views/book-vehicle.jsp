<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Vehicle</title>
</head>
<body>
<h1>Book Vehicle</h1>

<p style="color: red;">${errorMessage}</p>

<p><strong>Vehicle:</strong> ${vehicle.brand} ${vehicle.model}</p>
<p><strong>Type:</strong> ${vehicle.vehicleType}</p>
<p><strong>Registration Number:</strong> ${vehicle.registrationNumber}</p>
<p><strong>Color:</strong> ${vehicle.color}</p>
<p><strong>Seats:</strong> ${vehicle.seats}</p>
<p><strong>Price Per Day:</strong> ${vehicle.pricePerDay}</p>
<p>Total amount will be calculated automatically after booking.</p>

<form action="${pageContext.request.contextPath}/bookings/add" method="post">
    <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">

    <label>Pickup Date:</label><br>
    <input type="date" name="pickupDate" value="${pickupDate}" required><br><br>

    <label>Return Date:</label><br>
    <input type="date" name="returnDate" value="${returnDate}" required><br><br>

    <button type="submit">Confirm Booking</button>
</form>

<p><a href="${pageContext.request.contextPath}/vehicles">Back to Vehicles</a></p>
<p><a href="${pageContext.request.contextPath}/bookings">My Bookings</a></p>
</body>
</html>
