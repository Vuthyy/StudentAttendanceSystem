<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    int studentId = Integer.parseInt(request.getParameter("studentId"));
    String subject = request.getParameter("subject");
    String point = request.getParameter("point");

    Connection conn = null;
    PreparedStatement pstmtPerformance = null;
    PreparedStatement pstmtStudent = null;

    try {
        conn = DBConnection.getConnection();
        conn.setAutoCommit(false); // Begin transaction

        // Update performance table
        String updateQueryPerformance = "UPDATE performance SET subject = ?, point = ? WHERE student_id = ?";
        pstmtPerformance = conn.prepareStatement(updateQueryPerformance);
        pstmtPerformance.setString(1, subject);
        pstmtPerformance.setString(2, point);
        pstmtPerformance.setInt(3, studentId);
        pstmtPerformance.executeUpdate();

        // Update students table
        String updateQueryStudent = "UPDATE students SET subject = ?, point = ? WHERE student_id = ?";
        pstmtStudent = conn.prepareStatement(updateQueryStudent);
        pstmtStudent.setString(1, subject);
        pstmtStudent.setString(2, point);
        pstmtStudent.setInt(3, studentId);
        pstmtStudent.executeUpdate();

        conn.commit(); // Commit transaction
        response.sendRedirect("performance-report.jsp");
    } catch (SQLException e) {
        if (conn != null) {
            try {
                conn.rollback(); // Rollback transaction on error
            } catch (SQLException ex) {
                out.println("<p class='text-red-500'>Error: " + ex.getMessage() + "</p>");
            }
        }
        out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (pstmtPerformance != null) {
            try {
                pstmtPerformance.close();
            } catch (SQLException e) {
                out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
            }
        }
        if (pstmtStudent != null) {
            try {
                pstmtStudent.close();
            } catch (SQLException e) {
                out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
            }
        }
    }
%>
