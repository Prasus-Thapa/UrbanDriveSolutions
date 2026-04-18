<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h1>Login</h1>

<p style="color: green;">${successMessage}</p>
<p style="color: red;">${errorMessage}</p>

<form action="${pageContext.request.contextPath}/login" method="post">
    <label>Email:</label><br>
    <input type="email" name="email" value="${email}" required><br><br>

    <label>Password:</label><br>
    <input type="password" name="password" required><br><br>

    <button type="submit">Login</button>
</form>

<p><a href="${pageContext.request.contextPath}/register">Create new account</a></p>
<p><a href="${pageContext.request.contextPath}/home">Back to Home</a></p>
</body>
</html>
