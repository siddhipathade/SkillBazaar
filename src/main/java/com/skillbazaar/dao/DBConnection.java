package com.skillbazaar.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = getEnvOrDefault(
            "SKILLBAZAAR_DB_URL",
            "jdbc:mysql://localhost:3306/skillbazaar?useSSL=false&serverTimezone=UTC");

    private static final String USERNAME = getEnvOrDefault(
            "SKILLBAZAAR_DB_USERNAME",
            "root");

    private static final String PASSWORD = System.getenv("SKILLBAZAAR_DB_PASSWORD");

    public static Connection getConnection() {
        if (PASSWORD == null) {
            throw new IllegalStateException(
                    "SKILLBAZAAR_DB_PASSWORD environment variable is not set.");
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private static String getEnvOrDefault(String variableName, String defaultValue) {
        String value = System.getenv(variableName);
        return (value == null || value.trim().isEmpty()) ? defaultValue : value;
    }
}
