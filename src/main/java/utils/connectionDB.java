package utils;
import java.sql.Connection;
import java.sql.DriverManager;

public class connectionDB {

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/gestion_qcm",
            "root",
            "1234"          
        ); 
    }
} 