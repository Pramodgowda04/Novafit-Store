package com.fashionstore.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection connection = null;

    public static Connection getConnection() {

        try {
            if (connection == null || connection.isClosed()) {

                Class.forName(DBConfig.DRIVER);

                String currentUrl = DBConfig.getUrl();
                String currentUser = DBConfig.USERNAME;
                String currentPass = DBConfig.PASSWORD;

                System.out.println("Connecting to Database URL: " + currentUrl);

                connection = DriverManager.getConnection(
                        currentUrl,
                        currentUser,
                        currentPass
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