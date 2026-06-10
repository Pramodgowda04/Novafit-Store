package com.fashionstore.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.CartItemDAO;
import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.dao.impl.CartItemDAOImpl;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Cart;
import com.fashionstore.model.CartItem;
import com.fashionstore.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO = new CartDAOImpl();
    private CartItemDAO cartItemDAO = new CartItemDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        Cart cart = cartDAO.getCartByUserId(userId);

        int cartCount = 0;
        int totalQuantity = 0;
        BigDecimal cartTotal = BigDecimal.ZERO;

        if (cart != null) {

            List<CartItem> cartItems =
                    cartItemDAO.getCartItemsByCartId(cart.getId());

            if (cartItems != null) {

                cartCount = cartItems.size();

                for (CartItem item : cartItems) {
                    totalQuantity += item.getQuantity();

                    Product product = productDAO.getProductById(item.getProductId());

                    if (product != null) {
                        BigDecimal price = BigDecimal.valueOf(product.getPrice());
                        BigDecimal qty = BigDecimal.valueOf(item.getQuantity());
                        cartTotal = cartTotal.add(price.multiply(qty));
                    }
                }
            }

            request.setAttribute("cartItems", cartItems);
        }

        /*
         * This is important.
         * Navbar cart badge reads this value.
         */
        session.setAttribute("cartCount", totalQuantity);

        request.setAttribute("cartCount", cartCount);
        request.setAttribute("totalQuantity", totalQuantity);
        request.setAttribute("cartTotal", cartTotal);

        // Move coupon messages from session to request (flash messages)
        if (session.getAttribute("couponSuccess") != null) {
            request.setAttribute("couponSuccess", session.getAttribute("couponSuccess"));
            session.removeAttribute("couponSuccess");
        }

        if (session.getAttribute("couponError") != null) {
            request.setAttribute("couponError", session.getAttribute("couponError"));
            session.removeAttribute("couponError");
        }

        request.getRequestDispatcher("/WEB-INF/views/user/cart.jsp")
               .forward(request, response);
    }
}