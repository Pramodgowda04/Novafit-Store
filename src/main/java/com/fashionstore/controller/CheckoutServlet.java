package com.fashionstore.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.http.HttpSession;

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

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

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

        double totalAmount = 0;
        Map<Integer, Product> productMap = new HashMap<>();

        if (cart != null) {
            List<CartItem> cartItems =
                    cartItemDAO.getCartItemsByCartId(cart.getId());

            for (CartItem item : cartItems) {
                Product product = productDAO.getProductById(item.getProductId());

                if (product != null) {
                    productMap.put(item.getProductId(), product);
                    totalAmount += product.getPrice() * item.getQuantity();
                }
            }

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("productMap", productMap);
            request.setAttribute("totalAmount", totalAmount);

            // Fetch coupon amounts from session
            java.math.BigDecimal discountAmount = (java.math.BigDecimal) session.getAttribute("discountAmount");
            java.math.BigDecimal finalAmount = (java.math.BigDecimal) session.getAttribute("finalAmount");

            if (discountAmount != null) {
                request.setAttribute("discountAmount", discountAmount.doubleValue());
            } else {
                request.setAttribute("discountAmount", 0.0);
            }

            if (finalAmount != null) {
                request.setAttribute("finalAmount", finalAmount.doubleValue());
            } else {
                request.setAttribute("finalAmount", totalAmount);
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp")
               .forward(request, response);
    }
}