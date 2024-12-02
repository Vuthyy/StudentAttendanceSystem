<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    int studentId = Integer.parseInt(request.getParameter("studentId"));
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String date = request.getParameter("date");
    String status = request.getParameter("status");

    Connection conn = null;
    PreparedStatement pstmtAttendance = null;
    PreparedStatement pstmtStudent = null;

    try {
        conn = DBConnection.getConnection();
        conn.setAutoCommit(false); // Begin transaction

        // Update attendance table
        String updateQueryAttendance = "UPDATE attendance SET first_name = ?, last_name = ?, date = ?, status = ? WHERE student_id = ?";
        pstmtAttendance = conn.prepareStatement(updateQueryAttendance);
        pstmtAttendance.setString(1, firstName);
        pstmtAttendance.setString(2, lastName);
        pstmtAttendance.setString(3, date);
        pstmtAttendance.setString(4, status);
        pstmtAttendance.setInt(5, studentId);
        pstmtAttendance.executeUpdate();

        // Update students table
        String updateQueryStudent = "UPDATE students SET first_name = ?, last_name = ? WHERE student_id = ?";
        pstmtStudent = conn.prepareStatement(updateQueryStudent);
        pstmtStudent.setString(1, firstName);
        pstmtStudent.setString(2, lastName);
        pstmtStudent.setInt(3, studentId);
        pstmtStudent.executeUpdate();

        conn.commit(); // Commit transaction
        response.sendRedirect("attendance-report.jsp");
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
        if (pstmtAttendance != null) {
            try {
                pstmtAttendance.close();
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
