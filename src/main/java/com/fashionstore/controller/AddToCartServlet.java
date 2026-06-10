package com.fashionstore.controller;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.CartItemDAO;
import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.dao.impl.CartItemDAOImpl;
import com.fashionstore.model.Cart;
import com.fashionstore.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO = new CartDAOImpl();
    private CartItemDAO cartItemDAO = new CartItemDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

    	HttpSession session = request.getSession(false);

    	if (session == null || session.getAttribute("userId") == null) {
    	    response.sendRedirect(request.getContextPath() + "/login");
    	    return;
    	}

    	int userId = (int) session.getAttribute("userId"); // temporary test user

        int productId = Integer.parseInt(request.getParameter("productId"));
        String size = request.getParameter("size");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Cart cart = cartDAO.getCartByUserId(userId);

        if (cart == null) {
            Cart newCart = new Cart();
            newCart.setUserId(userId);
            cartDAO.createCart(newCart);

            cart = cartDAO.getCartByUserId(userId);
        }

        CartItem item = new CartItem();
        item.setCartId(cart.getId());
        item.setProductId(productId);
        item.setSize(size);
        item.setQuantity(quantity);

        cartItemDAO.addCartItem(item);

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}