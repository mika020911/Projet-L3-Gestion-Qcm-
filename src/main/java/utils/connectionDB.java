package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class connectionDB {

    public static Connection getConnection() throws Exception {


        String host     = System.getenv("MYSQLHOST")     != null ? System.getenv("MYSQLHOST")     : "localhost";
        String port     = System.getenv("MYSQLPORT")     != null ? System.getenv("MYSQLPORT")     : "3306";
        String database = System.getenv("MYSQLDATABASE") != null ? System.getenv("MYSQLDATABASE") : "gestion_qcm";
        String user     = System.getenv("MYSQLUSER")     != null ? System.getenv("MYSQLUSER")     : "root";
        String password = System.getenv("MYSQLPASSWORD") != null ? System.getenv("MYSQLPASSWORD") : "1234";

        String url = "jdbc:mysql://" + host + ":" + port + "/" + database
                   + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, password);
    }
}