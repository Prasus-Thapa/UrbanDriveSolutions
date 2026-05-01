<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Sign in to Urban Drive Solutions — Nepal's premium vehicle rental platform."/>
    <title>Login — Urban Drive Solutions</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>
</head>
<body>

<div class="auth-bg"></div>

<div class="auth-page">
    <div class="auth-wrap">

        <!-- Logo -->
        <div class="auth-logo">
            <a href="${pageContext.request.contextPath}/home" class="auth-logo-link">
                <span class="auth-logo-name">Urban Drive</span>
                <span class="auth-logo-sub">Solutions</span>
            </a>
        </div>

        <!-- Card -->
        <div class="auth-card">
            <h1 class="auth-title">Welcome back.</h1>
            <p class="auth-subtitle">Sign in to access your account.</p>

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    <span class="material-symbols-outlined">check_circle</span>${successMessage}
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">
                    <span class="material-symbols-outlined">error</span>${errorMessage}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" class="form-space">
                    <input type="hidden" name="redirect" value="${param.redirect}"/>
                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <input id="email" type="email" name="email" value="${email}" required
                           placeholder="you@example.com" class="form-input"/>
                </div>
                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <input id="password" type="password" name="password" required
                           placeholder="••••••••" class="form-input"/>
                </div>
                <button type="submit" class="btn btn-primary btn-lg btn-full" style="margin-top:0.5rem;">
                    Sign In
                </button>
            </form>

            <hr class="auth-divider"/>
            <p class="auth-switch">Don't have an account?
                <a href="${pageContext.request.contextPath}/register">Register here</a>
            </p>
        </div>

        <div class="auth-back">
            <a href="${pageContext.request.contextPath}/home">← Back to Home</a>
        </div>
    </div>
</div>

</body>
</html>
