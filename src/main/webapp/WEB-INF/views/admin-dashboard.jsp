<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
<h1>Admin Dashboard</h1>

<p style="color: green;">${successMessage}</p>

<p>Welcome, ${sessionScope.loggedInUser.fullName}</p>
<p>Email: ${sessionScope.loggedInUser.email}</p>
<p>Phone: ${sessionScope.loggedInUser.phone}</p>
<p>Role: ${sessionScope.loggedInUser.role}</p>

<h2>Revenue Analytics</h2>
<p>Total Revenue: ${analytics.totalRevenue}</p>
<p>Card Revenue: ${analytics.cardRevenue}</p>
<p>eSewa Revenue: ${analytics.esewaRevenue}</p>
<p>Khalti Revenue: ${analytics.khaltiRevenue}</p>
<p>connectIPS Revenue: ${analytics.connectIpsRevenue}</p>

<h2>Business Summary</h2>
<p>Total Paid Payments: ${analytics.totalPaidPayments}</p>
<p>Pending Payments: ${analytics.totalPendingPayments}</p>
<p>Total Bookings: ${analytics.totalBookings}</p>
<p>Confirmed Bookings: ${analytics.totalConfirmedBookings}</p>
<p>Total Vehicles: ${analytics.totalVehicles}</p>
<p>Available Vehicles: ${analytics.availableVehicles}</p>

<p><a href="${pageContext.request.contextPath}/home">Home</a></p>
<p><a href="${pageContext.request.contextPath}/vehicles">Manage Vehicles</a></p>
<p><a href="${pageContext.request.contextPath}/bookings">Manage Bookings</a></p>
<p><a href="${pageContext.request.contextPath}/payments">Manage Payments</a></p>
<p><a href="${pageContext.request.contextPath}/logout">Logout</a></p>
</body>
</html>
