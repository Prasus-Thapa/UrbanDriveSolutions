<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Vehicles</title>
</head>
<body>

<c:choose>
  <c:when test="${isAdmin}">
    <h1>Vehicle Management</h1>
  </c:when>
  <c:otherwise>
    <h1>Available Vehicles</h1>
  </c:otherwise>
</c:choose>

<p style="color: green;">${successMessage}</p>
<p style="color: red;">${errorMessage}</p>

<c:if test="${isAdmin}">
  <p><a href="${pageContext.request.contextPath}/vehicles/add">Add New Vehicle</a></p>
</c:if>

<p><a href="${pageContext.request.contextPath}/dashboard">Back to Dashboard</a></p>
<p><a href="${pageContext.request.contextPath}/logout">Logout</a></p>

<c:if test="${empty vehicles}">
  <p>No vehicles found.</p>
</c:if>

<c:if test="${not empty vehicles}">
  <table border="1" cellpadding="10" cellspacing="0">
    <tr>
      <th>ID</th>
      <th>Brand</th>
      <th>Model</th>
      <th>Type</th>
      <th>Registration Number</th>
      <th>Color</th>
      <th>Seats</th>
      <th>Price Per Day</th>
      <th>Status</th>
      <c:if test="${isAdmin}">
        <th>Actions</th>
      </c:if>
    </tr>

    <c:forEach var="vehicle" items="${vehicles}">
      <tr>
        <td>${vehicle.vehicleId}</td>
        <td>${vehicle.brand}</td>
        <td>${vehicle.model}</td>
        <td>${vehicle.vehicleType}</td>
        <td>${vehicle.registrationNumber}</td>
        <td>${vehicle.color}</td>
        <td>${vehicle.seats}</td>
        <td>${vehicle.pricePerDay}</td>
        <td>${vehicle.availabilityStatus}</td>

        <c:if test="${isAdmin}">
          <td>
            <a href="${pageContext.request.contextPath}/vehicles/edit?id=${vehicle.vehicleId}">Edit</a>

            <form action="${pageContext.request.contextPath}/vehicles/delete" method="post" style="display:inline;">
              <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
              <button type="submit">Delete</button>
            </form>
          </td>
        </c:if>
      </tr>
    </c:forEach>
  </table>
</c:if>

</body>
</html>
