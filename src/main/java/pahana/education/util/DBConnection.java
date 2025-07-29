package pahana.education.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static DBConnection instance;
    private static Connection connection;
    private static final String URL = "jdbc:mysql://localhost:3306/bookshop";
    private static final String USER = "root";
    private static final String PASS = "1234";

    private DBConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found", e);
        }
    }

    public static DBConnection getInstance() throws SQLException {
        synchronized (DBConnection.class) {
            if (instance == null  || connection.isClosed()) {
                instance = new DBConnection();
            }
        }
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }
}
