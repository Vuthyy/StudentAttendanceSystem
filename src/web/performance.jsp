<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Performance Management</title>
</head>
<body>
    <h2>Manage Performance</h2>
    <form action="performance.jsp" method="POST">
        <label>Student ID:</label>
        <input type="number" name="student_id" required>
        <br>
        <label>Subject:</label>
        <input type="text" name="subject" required>
        <br>
        <label>Grade:</label>
        <input type="text" name="grade" required>
        <br>
        <button type="submit">Save Performance</button>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            int studentId = Integer.parseInt(request.getParameter("student_id"));
            String subject = request.getParameter("subject");
            String grade = request.getParameter("grade");

            try (Connection conn = DBConnection.getConnection()) {
                String query = "INSERT INTO performance (student_id, subject, grade) VALUES (?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setInt(1, studentId);
                ps.setString(2, subject);
                ps.setString(3, grade);
                ps.executeUpdate();
                out.println("<p>Performance record saved successfully!</p>");
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>

