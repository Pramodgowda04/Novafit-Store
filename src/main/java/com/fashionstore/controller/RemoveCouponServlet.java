package com.fashionstore.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/remove-coupon")
public class RemoveCouponServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            session.removeAttribute("discountAmount");
            session.removeAttribute("finalAmount");
            session.removeAttribute("appliedCoupon");
            session.removeAttribute("appliedCouponCode");
            session.setAttribute("couponSuccess", "Coupon removed successfully.");
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
