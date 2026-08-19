package com.fashionstore.controller;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.CartItemDAO;
import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.dao.impl.CartItemDAOImpl;
import com.fashionstore.model.Cart;
import com.fashionstore.model.CartItem;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebFilter(urlPatterns = {"/*"})
public class CartCountFilter implements Filter {

    private CartDAO cartDAO;
    private CartItemDAO cartItemDAO;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        cartDAO = new CartDAOImpl();
        cartItemDAO = new CartItemDAOImpl();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String uri = httpRequest.getRequestURI().toLowerCase();

        // Skip DB queries for static assets to make page loading lightning fast!
        if (uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".png") || 
            uri.endsWith(".jpg") || uri.endsWith(".jpeg") || uri.endsWith(".gif") || 
            uri.endsWith(".svg") || uri.endsWith(".ico") || uri.endsWith(".woff") || uri.endsWith(".woff2")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(true);
        int cartItemCount = 0;
        
        if (session != null && session.getAttribute("userId") != null) {
            try {
                int userId = (Integer) session.getAttribute("userId");
                Cart cart = cartDAO.getCartByUserId(userId);
                if (cart != null) {
                    List<CartItem> items = cartItemDAO.getCartItemsByCartId(cart.getId());
                    if (items != null) {
                        for (CartItem item : items) {
                            cartItemCount += item.getQuantity();
                        }
                    }
                }
            } catch (Exception e) {
                cartItemCount = 0;
            }
        }
        
        httpRequest.setAttribute("globalCartItemCount", cartItemCount);
        session.setAttribute("globalCartItemCount", cartItemCount);
        session.setAttribute("cartCount", cartItemCount);

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
