package com.fashionstore.util;

public class DBConfig {

    private static String getEnv(String name, String defaultValue) {
        String value = System.getenv(name);
        return (value != null && !value.trim().isEmpty()) ? value.trim() : defaultValue;
    }

    public static String getUrl() {
        String dbUrl = System.getenv("DB_URL");
        if (dbUrl != null && !dbUrl.trim().isEmpty()) {
            return dbUrl.trim();
        }

        String host = getEnv("DB_HOST", "localhost");
        String port = getEnv("DB_PORT", "3306");
        String dbName = getEnv("DB_NAME", "fashion_store");

        return "jdbc:mysql://" + host + ":" + port + "/" + dbName + "?useSSL=false&allowPublicKeyRetrieval=true&autoReconnect=true";
    }

    public static final String URL = getUrl();
    public static final String USERNAME = getEnv("DB_USER", "root");
    public static final String PASSWORD = getEnv("DB_PASSWORD", "root123");

    public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
}