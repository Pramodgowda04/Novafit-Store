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

@WebFilter(urlPatterns = {"/home", "/cart", "/checkout", "/orders", "/products", "/profile", "/product-details"})
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
        HttpSession session = httpRequest.getSession(false);
        
        int cartItemCount = 0;
        
        if (session != null && session.getAttribute("userId") != null) {
            int userId = (Integer) session.getAttribute("userId");
            Cart cart = cartDAO.getCartByUserId(userId);
            if (cart != null) {
                List<CartItem> items = cartItemDAO.getCartItemsByCartId(cart.getId());
                cartItemCount = items.size();
            }
        }
        
        httpRequest.setAttribute("globalCartItemCount", cartItemCount);
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
