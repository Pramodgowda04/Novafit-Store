package com.fashionstore.config;

public class OAuthConfig {
    // ==========================================
    // GOOGLE OAUTH CREDENTIALS
    // ==========================================
    private static String getEnv(String name, String defaultValue) {
        String value = System.getenv(name);
        return (value != null && !value.trim().isEmpty()) ? value : defaultValue;
    }

    public static final String GOOGLE_CLIENT_ID = getEnv("GOOGLE_CLIENT_ID", "");
    public static final String GOOGLE_CLIENT_SECRET = getEnv("GOOGLE_CLIENT_SECRET", "");
    
    // Cloud hosting will require the real URL, localhost is fallback
    public static final String GOOGLE_REDIRECT_URI = getEnv("GOOGLE_REDIRECT_URI", "http://localhost:8080/fashionstore/oauth/google/callback");
}
