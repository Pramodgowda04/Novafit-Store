package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.CartItemDAO;
import com.fashionstore.model.CartItem;
import com.fashionstore.util.DBConnection;

public class CartItemDAOImpl implements CartItemDAO {

    private Connection conn = DBConnection.getConnection();

    // ADD CART ITEM
    @Override
    public boolean addCartItem(CartItem cartItem) {

        try {

            String sql = "INSERT INTO cart_items(cart_id, product_id, size, quantity) VALUES (?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, cartItem.getCartId());
            ps.setInt(2, cartItem.getProductId());
            ps.setString(3, cartItem.getSize());
            ps.setInt(4, cartItem.getQuantity());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // GET CART ITEMS BY CART ID
    @Override
    public List<CartItem> getCartItemsByCartId(int cartId) {

        List<CartItem> cartItemList = new ArrayList<>();

        try {

            String sql = "SELECT * FROM cart_items WHERE cart_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, cartId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                CartItem cartItem = new CartItem();

                cartItem.setId(rs.getInt("cart_item_id"));
                cartItem.setCartId(rs.getInt("cart_id"));
                cartItem.setProductId(rs.getInt("product_id"));
                cartItem.setSize(rs.getString("size"));
                cartItem.setQuantity(rs.getInt("quantity"));

                cartItemList.add(cartItem);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartItemList;
    }

    // UPDATE QUANTITY
    @Override
    public boolean updateQuantity(int cartItemId, int quantity) {

        try {

            String sql = "UPDATE cart_items SET quantity=? WHERE cart_item_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // REMOVE CART ITEM
    @Override
    public boolean removeCartItem(int cartItemId) {

        try {

            String sql =
                    "DELETE FROM cart_items WHERE cart_item_id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, cartItemId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}