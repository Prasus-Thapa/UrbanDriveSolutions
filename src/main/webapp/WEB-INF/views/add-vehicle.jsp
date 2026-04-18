<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Vehicle</title>
</head>
<body>
<h1>Add Vehicle</h1>

<p style="color: red;">${errorMessage}</p>

<form action="${pageContext.request.contextPath}/vehicles/add" method="post">
    <label>Brand:</label><br>
    <input type="text" name="brand" value="${brand}" required><br><br>

    <label>Model:</label><br>
    <input type="text" name="model" value="${model}" required><br><br>

    <label>Vehicle Type:</label><br>
    <input type="text" name="vehicleType" value="${vehicleType}" required><br><br>

    <label>Registration Number:</label><br>
    <input type="text" name="registrationNumber" value="${registrationNumber}" required><br><br>

    <label>Color:</label><br>
    <input type="text" name="color" value="${color}" required><br><br>

    <label>Seats:</label><br>
    <input type="number" name="seats" min="1" value="${seats}" required><br><br>

    <label>Price Per Day:</label><br>
    <input type="number" step="0.01" name="pricePerDay" min="0.01" value="${pricePerDay}" required><br><br>

    <label>Availability Status:</label><br>
    <select name="availabilityStatus" required>
        <option value="AVAILABLE" <c:if test="${availabilityStatus == 'AVAILABLE' || empty availabilityStatus}">selected</c:if>>AVAILABLE</option>
        <option value="BOOKED" <c:if test="${availabilityStatus == 'BOOKED'}">selected</c:if>>BOOKED</option>
        <option value="MAINTENANCE" <c:if test="${availabilityStatus == 'MAINTENANCE'}">selected</c:if>>MAINTENANCE</option>
    </select><br><br>

    <button type="submit">Save Vehicle</button>
</form>

<p><a href="${pageContext.request.contextPath}/vehicles">Back to Vehicles</a></p>
</body>
</html>
