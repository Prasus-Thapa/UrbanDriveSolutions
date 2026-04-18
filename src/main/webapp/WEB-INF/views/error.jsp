<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${errorCode} - ${errorTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/error.css">
</head>
<body>
<div class="container">
    <h1>${errorCode}</h1>
    <h2>${errorTitle}</h2>
    <p>${errorMessage}</p>
    <a href="${buttonUrl}" class="btn">${buttonText}</a>
</div>
</body>
</html>
