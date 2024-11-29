<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Performance Report</title>
</head>
<body>
    <h2>Performance Report</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Student ID</th>
                <th>Subject</th>
                <th>Grade</th>
            </tr>
        </thead>
        <tbody>
            <%
                try (Connection conn = DBConnection.getConnection()) {
                    String query = "SELECT * FROM performance";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getInt("student_id") + "</td>");
                        out.println("<td>" + rs.getString("subject") + "</td>");
                        out.println("<td>" + rs.getString("grade") + "</td>");
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

