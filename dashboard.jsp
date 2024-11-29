<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    String username = request.getParameter("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard</title>
</head>
<body>
    <h2>Welcome, <%= username %></h2>
    <ul>
        <li><a href="attendance.jsp">Manage Attendance</a></li>
        <li><a href="performance.jsp">Manage Performance</a></li>
        <li><a href="attendance-report.jsp">View Attendance</a></li>
        <li><a href="performance-report.jsp">View Performance</a></li>
    </ul>
</body>
</html>

