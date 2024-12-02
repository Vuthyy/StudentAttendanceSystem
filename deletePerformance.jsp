<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    int studentId = Integer.parseInt(request.getParameter("studentId"));

    Connection conn = null;
    PreparedStatement pstmtPerformance = null;
    PreparedStatement pstmtStudent = null;

    try {
        conn = DBConnection.getConnection();
        conn.setAutoCommit(false); // Begin transaction

        // Delete from performance table
        String deleteQueryPerformance = "DELETE FROM performance WHERE student_id = ?";
        pstmtPerformance = conn.prepareStatement(deleteQueryPerformance);
        pstmtPerformance.setInt(1, studentId);
        pstmtPerformance.executeUpdate();

        // Delete from students table
        String deleteQueryStudent = "DELETE FROM students WHERE student_id = ?";
        pstmtStudent = conn.prepareStatement(deleteQueryStudent);
        pstmtStudent.setInt(1, studentId);
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
