<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Vehicle</title>
</head>
<body>
<h1>Edit Vehicle</h1>

<p style="color: red;">${errorMessage}</p>

<form action="${pageContext.request.contextPath}/vehicles/edit" method="post">
    <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">

    <label>Brand:</label><br>
    <input type="text" name="brand" value="${vehicle.brand}" required><br><br>

    <label>Model:</label><br>
    <input type="text" name="model" value="${vehicle.model}" required><br><br>

    <label>Vehicle Type:</label><br>
    <input type="text" name="vehicleType" value="${vehicle.vehicleType}" required><br><br>

    <label>Registration Number:</label><br>
    <input type="text" name="registrationNumber" value="${vehicle.registrationNumber}" required><br><br>

    <label>Color:</label><br>
    <input type="text" name="color" value="${vehicle.color}" required><br><br>

    <label>Seats:</label><br>
    <input type="number" name="seats" min="1" value="${vehicle.seats}" required><br><br>

    <label>Price Per Day:</label><br>
    <input type="number" step="0.01" name="pricePerDay" min="0.01" value="${vehicle.pricePerDay}" required><br><br>

    <label>Availability Status:</label><br>
    <select name="availabilityStatus" required>
        <option value="AVAILABLE" <c:if test="${vehicle.availabilityStatus == 'AVAILABLE'}">selected</c:if>>AVAILABLE</option>
        <option value="BOOKED" <c:if test="${vehicle.availabilityStatus == 'BOOKED'}">selected</c:if>>BOOKED</option>
        <option value="MAINTENANCE" <c:if test="${vehicle.availabilityStatus == 'MAINTENANCE'}">selected</c:if>>MAINTENANCE</option>
    </select><br><br>

    <button type="submit">Update Vehicle</button>
</form>

<p><a href="${pageContext.request.contextPath}/vehicles">Back to Vehicles</a></p>
</body>
</html>
