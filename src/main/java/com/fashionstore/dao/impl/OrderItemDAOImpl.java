package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.OrderItemDAO;
import com.fashionstore.model.OrderItem;
import com.fashionstore.util.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

    private Connection conn = DBConnection.getConnection();

    // ADD ORDER ITEM
    @Override
    public boolean addOrderItem(OrderItem orderItem) {

        try {

            String sql = "INSERT INTO order_items(order_id, product_id, size, quantity, price) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getProductId());
            ps.setString(3, orderItem.getSize());
            ps.setInt(4, orderItem.getQuantity());
            ps.setDouble(5, orderItem.getPrice());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // GET ITEMS BY ORDER ID
    @Override
    public List<OrderItem> getItemsByOrderId(int orderId) {

        List<OrderItem> orderItemList = new ArrayList<>();

        try {

            String sql = "SELECT * FROM order_items WHERE order_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                OrderItem orderItem = new OrderItem();

                orderItem.setId(rs.getInt("order_item_id"));
                orderItem.setOrderId(rs.getInt("order_id"));
                orderItem.setProductId(rs.getInt("product_id"));
                orderItem.setSize(rs.getString("size"));
                orderItem.setQuantity(rs.getInt("quantity"));
                orderItem.setPrice(rs.getDouble("price"));

                orderItemList.add(orderItem);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderItemList;
    }

    // DELETE ORDER ITEM
    @Override
    public boolean deleteOrderItem(int orderItemId) {

        try {

            String sql = "DELETE FROM order_items WHERE order_item_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, orderItemId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}