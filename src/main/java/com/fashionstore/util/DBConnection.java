package com.fashionstore.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection connection = null;

    public static Connection getConnection() {

        try {
            if (connection == null || connection.isClosed()) {

                Class.forName(DBConfig.DRIVER);

                connection = DriverManager.getConnection(
                        DBConfig.URL,
                        DBConfig.USERNAME,
                        DBConfig.PASSWORD
                );

                System.out.println("Database Connected Successfully!");
            }

        } catch (Exception e) {
            System.out.println("Database Connection Failed!");
            e.printStackTrace();
        }

        return connection;
    }
}