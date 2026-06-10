package com.fashionstore.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.CartItemDAO;
import com.fashionstore.dao.CouponDAO;
import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.dao.impl.CartItemDAOImpl;
import com.fashionstore.dao.impl.CouponDAOImpl;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Cart;
import com.fashionstore.model.CartItem;
import com.fashionstore.model.Coupon;
import com.fashionstore.model.Product;
import com.fashionstore.service.CouponService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/apply-coupon")
public class ApplyCouponServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO = new CartDAOImpl();
    private CartItemDAO cartItemDAO = new CartItemDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();
    private CouponDAO couponDAO = new CouponDAOImpl();
    private CouponService couponService = new CouponService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String couponCode = request.getParameter("couponCode");

        // Validate coupon code input
        if (couponCode == null || couponCode.trim().isEmpty()) {
            session.setAttribute("couponError", "Please enter a coupon code.");
            session.removeAttribute("discountAmount");
            session.removeAttribute("finalAmount");
            session.removeAttribute("appliedCoupon");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        couponCode = couponCode.trim().toUpperCase();

        // Calculate cart total
        Cart cart = cartDAO.getCartByUserId(userId);

        if (cart == null) {
            session.setAttribute("couponError", "Your cart is empty.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        List<CartItem> cartItems = cartItemDAO.getCartItemsByCartId(cart.getId());

        if (cartItems == null || cartItems.isEmpty()) {
            session.setAttribute("couponError", "Your cart is empty.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Calculate total amount from product prices
        BigDecimal cartTotal = BigDecimal.ZERO;

        for (CartItem item : cartItems) {
            Product product = productDAO.getProductById(item.getProductId());

            if (product != null) {
                BigDecimal itemPrice = BigDecimal.valueOf(product.getPrice());
                BigDecimal itemQuantity = BigDecimal.valueOf(item.getQuantity());
                cartTotal = cartTotal.add(itemPrice.multiply(itemQuantity));
            }
        }

        // Check minimum order amount (₹2000)
        BigDecimal minAmount = new BigDecimal("2000");

        if (cartTotal.compareTo(minAmount) < 0) {
            session.setAttribute("couponError",
                    "Coupons are only available for orders above ₹2,000. Your cart total is ₹" + cartTotal + ".");
            session.removeAttribute("discountAmount");
            session.removeAttribute("finalAmount");
            session.removeAttribute("appliedCoupon");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Validate coupon from database
        Coupon coupon = couponDAO.getValidCoupon(couponCode, cartTotal);

        if (coupon == null) {
            session.setAttribute("couponError",
                    "Invalid or expired coupon code \"" + couponCode + "\". Please try another code.");
            session.removeAttribute("discountAmount");
            session.removeAttribute("finalAmount");
            session.removeAttribute("appliedCoupon");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Calculate discount
        BigDecimal discountAmount = couponService.calculateDiscount(coupon, cartTotal);
        BigDecimal finalAmount = couponService.calculateFinalAmount(cartTotal, discountAmount);

        // Store in session for cart display and checkout use
        session.setAttribute("cartTotal", cartTotal);
        session.setAttribute("discountAmount", discountAmount);
        session.setAttribute("finalAmount", finalAmount);
        session.setAttribute("appliedCoupon", coupon);
        session.setAttribute("appliedCouponCode", couponCode);

        session.setAttribute("couponSuccess",
                "Coupon \"" + couponCode + "\" applied successfully! You save ₹" + discountAmount + ".");
        session.removeAttribute("couponError");

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
