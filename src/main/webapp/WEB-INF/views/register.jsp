<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Register</title>
</head>
<body>
<h1>Register</h1>

<p style="color: red;">${errorMessage}</p>

<form action="${pageContext.request.contextPath}/register" method="post">
  <label>Full Name:</label><br>
  <input type="text" name="fullName" value="${fullName}" required><br><br>

  <label>Email:</label><br>
  <input type="email" name="email" value="${email}" required><br><br>

  <label>Password:</label><br>
  <input type="password" name="password" required><br><br>

  <label>Phone:</label><br>
  <input type="text" name="phone" value="${phone}" required><br><br>

  <label>License Number:</label><br>
  <input type="text" name="licenseNumber" value="${licenseNumber}" required><br><br>

  <button type="submit">Register</button>
</form>

<p><a href="${pageContext.request.contextPath}/login">Go to Login</a></p>
<p><a href="${pageContext.request.contextPath}/home">Back to Home</a></p>
</body>
</html>
