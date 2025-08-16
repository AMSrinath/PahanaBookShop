package pahana.education.dao;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

@WebListener
public class AppContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("✅ AppContextListener initialized successfully");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Context shutting down: cleaning up MySQL threads and JDBC drivers...");

        AbandonedConnectionCleanupThread.checkedShutdown();
        System.out.println("MySQL cleanup thread shutdown complete.");

        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            if (driver.getClass().getClassLoader() == cl) {
                try {
                    DriverManager.deregisterDriver(driver);
                    System.out.println("Deregistered JDBC driver: " + driver);
                } catch (SQLException ex) {
                    System.err.println("Error deregistering driver: " + driver);
                    ex.printStackTrace();
                }
            }
        }
    }
}
