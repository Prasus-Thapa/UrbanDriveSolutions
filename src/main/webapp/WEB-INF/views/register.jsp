<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="Create your Urban Drive Solutions account and start renting premium vehicles today."/>
    <title>Register — Urban Drive Solutions</title>
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
            <h1 class="auth-title">Create account.</h1>
            <p class="auth-subtitle">Join Urban Drive Solutions today.</p>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">
                    <span class="material-symbols-outlined">error</span>${errorMessage}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post" class="form-space">
                <div class="form-group">
                    <label class="form-label" for="fullName">Full Name</label>
                    <input id="fullName" type="text" name="fullName" value="${fullName}" required
                           placeholder="John Doe" class="form-input"/>
                </div>
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
                <div class="form-group">
                    <label class="form-label" for="phone">Phone Number</label>
                    <input id="phone" type="text" name="phone" value="${phone}" required
                           placeholder="+977 98XXXXXXXX" class="form-input"/>
                </div>
                <div class="form-group">
                    <label class="form-label" for="licenseNumber">License Number</label>
                    <input id="licenseNumber" type="text" name="licenseNumber" value="${licenseNumber}" required
                           placeholder="LIC-XXXXXXX" class="form-input"/>
                </div>
                <button type="submit" class="btn btn-primary btn-lg btn-full" style="margin-top:0.5rem;">
                    Create Account
                </button>
            </form>

            <hr class="auth-divider"/>
            <p class="auth-switch">Already have an account?
                <a href="${pageContext.request.contextPath}/login">Sign in</a>
            </p>
        </div>

        <div class="auth-back">
            <a href="${pageContext.request.contextPath}/home">← Back to Home</a>
        </div>
    </div>
</div>

</body>
</html>
