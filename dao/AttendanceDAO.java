package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import web.util.DBConnection;

public class AttendanceDAO {

    // Method to mark attendance
    public boolean markAttendance(int studentId, String date, String status) {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO attendance (student_id, date, status) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, studentId);
            ps.setString(2, date);
            ps.setString(3, status);
            return ps.executeUpdate() > 0; // Returns true if attendance is successfully marked
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to retrieve attendance records for a student
    public List<String[]> getAttendance(int studentId) {
        List<String[]> attendanceRecords = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT * FROM attendance WHERE student_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] record = {
                    rs.getString("date"),
                    rs.getString("status")
                };
                attendanceRecords.add(record);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attendanceRecords;
    }
}

