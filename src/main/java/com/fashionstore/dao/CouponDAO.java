package com.fashionstore.dao;

import java.math.BigDecimal;

import com.fashionstore.model.Coupon;

public interface CouponDAO {

    Coupon getValidCoupon(String code, BigDecimal cartTotal);

    void increaseUsedCount(int couponId);
}