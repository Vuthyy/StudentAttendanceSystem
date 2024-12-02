<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    int studentId = Integer.parseInt(request.getParameter("studentId"));

    try (Connection conn = DBConnection.getConnection()) {
        String deleteQuery = "DELETE FROM attendance WHERE student_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(deleteQuery);
        pstmt.setInt(1, studentId);
        pstmt.executeUpdate();
        response.sendRedirect("attendance-report.jsp");
    } catch (SQLException e) {
        out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
    }
%>
