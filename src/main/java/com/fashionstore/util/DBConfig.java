package com.fashionstore.util;

public class DBConfig {

    private static String getEnv(String name, String defaultValue) {
        String value = System.getenv(name);
        return (value != null && !value.trim().isEmpty()) ? value : defaultValue;
    }

    public static final String URL = getEnv("DB_URL", "jdbc:mysql://localhost:3306/fashion_store");
    public static final String USERNAME = getEnv("DB_USER", "root");
    public static final String PASSWORD = getEnv("DB_PASSWORD", "root123");

    public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
}