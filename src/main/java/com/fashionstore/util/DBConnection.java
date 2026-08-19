package com.fashionstore.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection connection = null;

    public static synchronized Connection getConnection() {

        try {
            if (connection == null || connection.isClosed()) {

                Class.forName(DBConfig.DRIVER);

                String currentUrl = DBConfig.getUrl();
                String currentUser = DBConfig.USERNAME;
                String currentPass = DBConfig.PASSWORD;

                connection = DriverManager.getConnection(
                        currentUrl,
                        currentUser,
                        currentPass
                );
            }

        } catch (Exception e) {
            System.err.println("Database Connection Failed!");
            e.printStackTrace();
        }

        return connection;
    }
}