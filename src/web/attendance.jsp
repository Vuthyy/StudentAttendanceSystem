<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Attendance Management</title>
</head>
<body>
    <h2>Mark Attendance</h2>
    <form action="attendance.jsp" method="POST">
        <label>Date:</label>
        <input type="date" name="date" required>
        <br>
        <label>Student ID:</label>
        <input type="number" name="student_id" required>
        <br>
        <label>Status:</label>
        <select name="status">
            <option value="Present">Present</option>
            <option value="Absent">Absent</option>
        </select>
        <br>
        <button type="submit">Mark Attendance</button>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String date = request.getParameter("date");
            int studentId = Integer.parseInt(request.getParameter("student_id"));
            String status = request.getParameter("status");

            try (Connection conn = DBConnection.getConnection()) {
                String query = "INSERT INTO attendance (student_id, date, status) VALUES (?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setInt(1, studentId);
                ps.setString(2, date);
                ps.setString(3, status);
                ps.executeUpdate();
                out.println("<p>Attendance marked successfully!</p>");
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>

