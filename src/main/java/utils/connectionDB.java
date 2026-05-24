package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class connectionDB {

    public static Connection getConnection() throws Exception {

        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");

        // MODE LOCAL si variables absentes
        if (url == null) {
            url = "jdbc:mysql://localhost:3306/gestion_qcm?useSSL=false";
            user = "root";
            password = "1234";
        }
        System.out.println("=== DB_URL utilisée : " + url);
    System.out.println("=== DB_USER utilisé : " + user);

        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(url, user, password);
    }
}