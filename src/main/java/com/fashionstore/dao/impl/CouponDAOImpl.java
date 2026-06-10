package com.fashionstore.dao.impl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.fashionstore.dao.CouponDAO;
import com.fashionstore.model.Coupon;
import com.fashionstore.util.DBConnection;

public class CouponDAOImpl implements CouponDAO {

    private Connection conn = DBConnection.getConnection();

    @Override
    public Coupon getValidCoupon(String code, BigDecimal cartTotal) {

        try {

            String sql = "SELECT * FROM coupons "
                       + "WHERE code = ? "
                       + "AND is_active = 1 "
                       + "AND CURDATE() BETWEEN start_date AND end_date "
                       + "AND used_count < usage_limit "
                       + "AND min_order_amount <= ?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, code);
            ps.setBigDecimal(2, cartTotal);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Coupon coupon = new Coupon();

                coupon.setCouponId(rs.getInt("coupon_id"));
                coupon.setCode(rs.getString("code"));
                coupon.setDiscountType(rs.getString("discount_type"));
                coupon.setDiscountValue(rs.getBigDecimal("discount_value"));
                coupon.setMinOrderAmount(rs.getBigDecimal("min_order_amount"));
                coupon.setMaxDiscount(rs.getBigDecimal("max_discount"));
                coupon.setStartDate(rs.getDate("start_date"));
                coupon.setEndDate(rs.getDate("end_date"));
                coupon.setActive(rs.getBoolean("is_active"));
                coupon.setUsageLimit(rs.getInt("usage_limit"));
                coupon.setUsedCount(rs.getInt("used_count"));

                return coupon;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public void increaseUsedCount(int couponId) {

        try {

            String sql = "UPDATE coupons SET used_count = used_count + 1 WHERE coupon_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, couponId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
