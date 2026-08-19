package com.fashionstore.controller;

import java.io.IOException;
import java.util.List;

import com.fashionstore.dao.WishlistDAO;
import com.fashionstore.dao.impl.WishlistDAOImpl;
import com.fashionstore.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private WishlistDAO wishlistDAO = new WishlistDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Wishlist requires login
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Product> wishlistItems = wishlistDAO.getWishlistByUserId(userId);
        int wishlistCount = wishlistDAO.getWishlistCount(userId);

        session.setAttribute("wishlistCount", wishlistCount);
        request.setAttribute("wishlistItems", wishlistItems);

        request.getRequestDispatcher("/WEB-INF/views/user/wishlist.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        boolean isAjax = "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"))
                || "true".equalsIgnoreCase(request.getParameter("ajax"));

        // Wishlist requires login
        if (userId == null) {
            if (isAjax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"status\":\"unauthorized\",\"message\":\"Please login to save items to your wishlist.\",\"redirect\":\"" + request.getContextPath() + "/login\"}");
                return;
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
        }

        String action = request.getParameter("action");
        String productIdParam = request.getParameter("productId");

        boolean isWishlisted = false;

        if (productIdParam != null && !productIdParam.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdParam.trim());

                if ("add".equalsIgnoreCase(action)) {
                    wishlistDAO.addToWishlist(userId, productId);
                    isWishlisted = true;
                } else if ("remove".equalsIgnoreCase(action)) {
                    wishlistDAO.removeFromWishlist(userId, productId);
                    isWishlisted = false;
                } else if ("toggle".equalsIgnoreCase(action)) {
                    if (wishlistDAO.isInWishlist(userId, productId)) {
                        wishlistDAO.removeFromWishlist(userId, productId);
                        isWishlisted = false;
                    } else {
                        wishlistDAO.addToWishlist(userId, productId);
                        isWishlisted = true;
                    }
                } else if ("moveToCart".equalsIgnoreCase(action)) {
                    request.getRequestDispatcher("/add-to-cart").include(request, response);
                    wishlistDAO.removeFromWishlist(userId, productId);
                    isWishlisted = false;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        int count = wishlistDAO.getWishlistCount(userId);
        session.setAttribute("wishlistCount", count);

        if (isAjax) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"status\":\"success\",\"isWishlisted\":" + isWishlisted + ",\"wishlistCount\":" + count + "}");
            return;
        }

        String referer = request.getHeader("referer");
        if (referer != null && !referer.trim().isEmpty() && !referer.contains("/wishlist")) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/wishlist");
        }
    }
}
