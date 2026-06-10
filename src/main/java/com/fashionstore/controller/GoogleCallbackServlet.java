package com.fashionstore.controller;

import com.fashionstore.config.OAuthConfig;
import com.fashionstore.dao.UserDAO;
import com.fashionstore.dao.impl.UserDAOImpl;
import com.fashionstore.model.User;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@WebServlet("/oauth/google/callback")
public class GoogleCallbackServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=Google login cancelled");
            return;
        }

        try {
            HttpClient client = HttpClient.newHttpClient();
            
            // 1. Exchange authorization code for access token
            String tokenRequestBody = "code=" + code +
                    "&client_id=" + OAuthConfig.GOOGLE_CLIENT_ID +
                    "&client_secret=" + OAuthConfig.GOOGLE_CLIENT_SECRET +
                    "&redirect_uri=" + OAuthConfig.GOOGLE_REDIRECT_URI +
                    "&grant_type=authorization_code";

            HttpRequest tokenRequest = HttpRequest.newBuilder()
                    .uri(URI.create("https://oauth2.googleapis.com/token"))
                    .header("Content-Type", "application/x-www-form-urlencoded")
                    .POST(HttpRequest.BodyPublishers.ofString(tokenRequestBody))
                    .build();

            HttpResponse<String> tokenResponse = client.send(tokenRequest, HttpResponse.BodyHandlers.ofString());
            
            // Check for errors in token response
            if (tokenResponse.statusCode() != 200) {
                response.sendRedirect(request.getContextPath() + "/login?error=Failed to retrieve access token. Make sure your API keys are correct.");
                return;
            }

            JsonObject jsonObject = JsonParser.parseString(tokenResponse.body()).getAsJsonObject();
            String accessToken = jsonObject.get("access_token").getAsString();

            // 2. Fetch user profile data from Google using access token
            HttpRequest profileRequest = HttpRequest.newBuilder()
                    .uri(URI.create("https://www.googleapis.com/oauth2/v2/userinfo"))
                    .header("Authorization", "Bearer " + accessToken)
                    .GET()
                    .build();

            HttpResponse<String> profileResponse = client.send(profileRequest, HttpResponse.BodyHandlers.ofString());
            JsonObject profileJson = JsonParser.parseString(profileResponse.body()).getAsJsonObject();
            
            String email = profileJson.get("email").getAsString();
            String name = profileJson.has("name") ? profileJson.get("name").getAsString() : "Google User";
            
            // 3. Login or auto-register the user in our database
            User user = userDAO.getUserByEmail(email);
            if (user == null) {
                user = new User();
                user.setName(name);
                user.setEmail(email);
                user.setPassword("OAUTH_LOGIN_PLACEHOLDER");
                user.setPhone("0000000000"); // Default since Google doesn't provide phone
                user.setAddress(""); 
                user.setRole("user");
                
                boolean registered = userDAO.registerUser(user);
                if (registered) {
                    user = userDAO.getUserByEmail(email);
                }
            }

            // 4. Create the session and log them in
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("userName", user.getName());
                session.setAttribute("userRole", user.getRole());
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                response.sendRedirect(request.getContextPath() + "/login?error=Authentication failed. Could not create account.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login?error=An error occurred during Google authentication.");
        }
    }
}
