package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    // Connection details for XAMPP
    private static final String URL = "jdbc:mysql://127.0.0.1:3300/studentsystem"; // Use your XAMPP database (e.g., "test")
    private static final String USER = "root"; // Default XAMPP username
    private static final String PASSWORD = ""; // Default XAMPP password (empty)

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
