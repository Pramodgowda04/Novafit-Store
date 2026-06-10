package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.model.Cart;
import com.fashionstore.util.DBConnection;

public class CartDAOImpl implements CartDAO {

    private Connection conn = DBConnection.getConnection();

    // CREATE CART
    @Override
    public boolean createCart(Cart cart) {

        try {

            String sql = "INSERT INTO cart(user_id) VALUES (?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, cart.getUserId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // GET CART BY USER ID
    @Override
    public Cart getCartByUserId(int userId) {

        try {

            String sql = "SELECT * FROM cart WHERE user_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Cart cart = new Cart();

                cart.setId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setCreatedAt(rs.getTimestamp("created_at"));

                return cart;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // DELETE CART
    @Override
    public boolean deleteCart(int cartId) {

        try {

            String sql = "DELETE FROM cart WHERE cart_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, cartId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}