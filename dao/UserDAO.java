package dao;

import java.sql.*;

import web.util.DBConnection;

public class UserDAO {

    // Method to authenticate user login
    public boolean authenticate(String username, String password) {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // If a result exists, login is successful
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to add a new user
    public boolean addUser(String name, String email, String username, String password, String role) {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO users (name, email, username, password, role) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, username);
            ps.setString(4, password);
            ps.setString(5, role);
            return ps.executeUpdate() > 0; // Returns true if the user is successfully added
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to retrieve user role
    public String getUserRole(String username) {
        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT role FROM users WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("role");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

