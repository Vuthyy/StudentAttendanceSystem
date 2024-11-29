package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import web.util.DBConnection;

public class PerformanceDAO {

    // Method to add a performance record
    public boolean addPerformance(int studentId, String subject, String grade) {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO performance (student_id, subject, grade) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, studentId);
            ps.setString(2, subject);
            ps.setString(3, grade);
            return ps.executeUpdate() > 0; // Returns true if the record is successfully added
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to retrieve performance records for a student
    public List<String[]> getPerformance(int studentId) {
        List<String[]> performanceRecords = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT * FROM performance WHERE student_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] record = {
                    rs.getString("subject"),
                    rs.getString("grade")
                };
                performanceRecords.add(record);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return performanceRecords;
    }
}

