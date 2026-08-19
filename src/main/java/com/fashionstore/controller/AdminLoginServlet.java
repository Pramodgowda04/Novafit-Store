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

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && Boolean.TRUE.equals(session.getAttribute("isAdmin"))) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email != null) {
            email = email.trim();
        }
        if (password != null) {
            password = password.trim();
        }

        boolean isValidAdmin = false;
        User user = null;

        // Master Admin Credentials Check (pramodgowda7377@gmail.com / AdminFashion#04)
        if (email != null && password != null) {

            boolean isMasterEmail = "pramodgowda7377@gmail.com".equalsIgnoreCase(email)
                    || "admin@fashionstore.com".equalsIgnoreCase(email)
                    || "admin".equalsIgnoreCase(email);

            boolean isMasterPassword = "AdminFashion#04".equals(password)
                    || "admin123".equals(password);

            if (isMasterEmail && isMasterPassword) {
                isValidAdmin = true;
            } else {
                // Try database login
                user = userDAO.loginUser(email, password);
                if (user != null) {
                    if ("ADMIN".equalsIgnoreCase(user.getRole()) || isMasterEmail) {
                        isValidAdmin = true;
                    }
                }
            }
        }

        if (isValidAdmin) {
            HttpSession session = request.getSession(true);
            session.setAttribute("isAdmin", true);
            session.setAttribute("adminEmail", email);

            if (user != null) {
                session.setAttribute("userId", user.getId());
                session.setAttribute("userName", user.getName());
            } else {
                session.setAttribute("userId", 1);
                session.setAttribute("userName", "Pramod Gowda (Admin)");
            }

            response.sendRedirect(request.getContextPath() + "/admin/orders");
        } else {
            request.setAttribute("errorMessage", "Invalid Admin Email or Password! 🔒");
            request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp")
                   .forward(request, response);
        }
    }
}
