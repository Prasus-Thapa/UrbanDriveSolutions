<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
<h1>Customer Dashboard</h1>

<p style="color: green;">${successMessage}</p>

<p>Welcome, ${sessionScope.loggedInUser.fullName}</p>
<p>Email: ${sessionScope.loggedInUser.email}</p>
<p>Phone: ${sessionScope.loggedInUser.phone}</p>
<p>License Number: ${sessionScope.loggedInUser.licenseNumber}</p>
<p>Role: ${sessionScope.loggedInUser.role}</p>

<p><a href="${pageContext.request.contextPath}/home">Home</a></p>
<p><a href="${pageContext.request.contextPath}/vehicles">Browse Vehicles</a></p>
<p><a href="${pageContext.request.contextPath}/bookings">My Bookings</a></p>
<p><a href="${pageContext.request.contextPath}/logout">Logout</a></p>
</body>
</html>
