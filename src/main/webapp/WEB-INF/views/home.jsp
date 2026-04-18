<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>UrbanDriveSolutions - Home</title>
</head>
<body>
<h1>UrbanDriveSolutions</h1>

<p style="color: green;">${successMessage}</p>

<p>Welcome to the Vehicle Rental Web Application.</p>
<p><a href="${pageContext.request.contextPath}/login">Login</a></p>
<p><a href="${pageContext.request.contextPath}/register">Register</a></p>
<p><a href="${pageContext.request.contextPath}/dashboard">Go to Dashboard</a></p>
<p><a href="${pageContext.request.contextPath}/logout">Logout</a></p>
<p><a href="${pageContext.request.contextPath}/db-check">Check Database Connection</a></p>
</body>
</html>
