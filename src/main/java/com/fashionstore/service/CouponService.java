package com.fashionstore.service;

import java.math.BigDecimal;
import java.math.RoundingMode;

import com.fashionstore.model.Coupon;

public class CouponService {

    public BigDecimal calculateDiscount(Coupon coupon, BigDecimal cartTotal) {

        BigDecimal discountAmount = BigDecimal.ZERO;

        if (coupon == null || cartTotal == null) {
            return discountAmount;
        }

        if ("PERCENTAGE".equalsIgnoreCase(coupon.getDiscountType())) {

            discountAmount = cartTotal
                    .multiply(coupon.getDiscountValue())
                    .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);

        } else if ("FIXED".equalsIgnoreCase(coupon.getDiscountType())) {

            discountAmount = coupon.getDiscountValue();
        }

        if (coupon.getMaxDiscount() != null && discountAmount.compareTo(coupon.getMaxDiscount()) > 0) {
            discountAmount = coupon.getMaxDiscount();
        }

        if (discountAmount.compareTo(cartTotal) > 0) {
            discountAmount = cartTotal;
        }

        return discountAmount;
    }

    public BigDecimal calculateFinalAmount(BigDecimal cartTotal, BigDecimal discountAmount) {

        if (cartTotal == null) {
            return BigDecimal.ZERO;
        }

        if (discountAmount == null) {
            discountAmount = BigDecimal.ZERO;
        }

        return cartTotal.subtract(discountAmount);
    }
}