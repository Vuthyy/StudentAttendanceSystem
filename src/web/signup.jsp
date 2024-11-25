<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Signup</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h2>Signup</h2>
    <form action="signup.jsp" method="POST">
        <label>Name:</label>
        <input type="text" name="name" required>
        <label>Email:</label>
        <input type="email" name="email" required>
        <label>Username:</label>
        <input type="text" name="username" required>
        <label>Password:</label>
        <input type="password" name="password" required>
        <label>Role:</label>
        <select name="role">
            <option value="admin">Admin</option>
            <option value="teacher">Teacher</option>
            <option value="student">Student</option>
        </select>
        <button type="submit">Signup</button>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            try (Connection conn = DBConnection.getConnection()) {
                String query = "INSERT INTO users (name, email, username, password, role) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, username);
                ps.setString(4, password);
                ps.setString(5, role);
                ps.executeUpdate();
                out.println("<p>Signup successful! <a href='login.jsp'>Login here</a></p>");
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>

