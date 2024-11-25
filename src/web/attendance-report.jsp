<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Attendance Report</title>
</head>
<body>
    <h2>Attendance Report</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Date</th>
                <th>Student ID</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                try (Connection conn = DBConnection.getConnection()) {
                    String query = "SELECT * FROM attendance";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("date") + "</td>");
                        out.println("<td>" + rs.getInt("student_id") + "</td>");
                        out.println("<td>" + rs.getString("status") + "</td>");
                        out.println("</tr>");
                    }
                } catch (SQLException e) {
                    out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </tbody>
    </table>
</body>
</html>

