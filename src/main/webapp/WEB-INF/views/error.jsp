<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${errorCode} — Urban Drive Solutions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
</head>
<body>

<div class="auth-bg"></div>

<div class="error-page">
    <div class="error-wrap">
        <span class="material-symbols-outlined error-icon">error</span>
        <p class="error-eyebrow">Something went wrong</p>
        <h1 class="error-code">${errorCode}</h1>
        <h2 class="error-title">${errorTitle}</h2>
        <p class="error-desc">${errorMessage}</p>
        <a href="${buttonUrl}" class="btn btn-primary btn-lg">
            <span class="material-symbols-outlined">arrow_back</span>${buttonText}
        </a>
        <div class="error-brand">Urban Drive Solutions</div>
    </div>
</div>

</body>
</html>
