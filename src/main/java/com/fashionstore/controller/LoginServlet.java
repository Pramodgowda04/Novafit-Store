package com.fashionstore.controller;

import java.io.IOException;

import com.fashionstore.dao.UserDAO;
import com.fashionstore.dao.impl.UserDAOImpl;
import com.fashionstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("userId") != null) {
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                   .forward(request, response);
            return;
        }

        User user = userDAO.loginUser(email.trim(), password.trim());

        if (user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("loggedUser", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userPhone", user.getPhone());
            session.setAttribute("userAddress", user.getAddress());

            session.setMaxInactiveInterval(30 * 60);
            
            String remember = request.getParameter("remember");
            if (remember != null) {
                jakarta.servlet.http.Cookie emailCookie = new jakarta.servlet.http.Cookie("rememberEmail", email.trim());
                emailCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                response.addCookie(emailCookie);
                
                jakarta.servlet.http.Cookie passCookie = new jakarta.servlet.http.Cookie("rememberPassword", password.trim());
                passCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                response.addCookie(passCookie);
            } else {
                jakarta.servlet.http.Cookie emailCookie = new jakarta.servlet.http.Cookie("rememberEmail", "");
                emailCookie.setMaxAge(0);
                response.addCookie(emailCookie);
                
                jakarta.servlet.http.Cookie passCookie = new jakarta.servlet.http.Cookie("rememberPassword", "");
                passCookie.setMaxAge(0);
                response.addCookie(passCookie);
            }

            response.sendRedirect(request.getContextPath() + "/profile");
            return;

        } else {

            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                   .forward(request, response);
        }
    }
}