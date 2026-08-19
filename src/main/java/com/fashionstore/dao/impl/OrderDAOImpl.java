package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.OrderDAO;
import com.fashionstore.model.Order;
import com.fashionstore.util.DBConnection;

public class OrderDAOImpl implements OrderDAO {

    private Connection conn = DBConnection.getConnection();

    // PLACE ORDER
    @Override
    public boolean placeOrder(Order order) {

        try {

            String sql = "INSERT INTO orders(user_id, total_amount, status) VALUES (?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, order.getUserId());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // GET ORDER BY ID
    @Override
    public Order getOrderById(int orderId) {

        try {

            String sql = "SELECT * FROM orders WHERE order_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Order order = new Order();

                order.setId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setCreatedAt(rs.getTimestamp("created_at"));

                try { order.setCancellationReason(rs.getString("cancellation_reason")); } catch (Exception ex) {}

                return order;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // GET ORDERS BY USER ID
    @Override
    public List<Order> getOrdersByUserId(int userId) {

        List<Order> orderList = new ArrayList<>();

        try {

            String sql = "SELECT * FROM orders WHERE user_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                try { order.setCancellationReason(rs.getString("cancellation_reason")); } catch (Exception ex) {}

                orderList.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderList;
    }

    // GET ALL ORDERS FOR ADMIN
    @Override
    public List<Order> getAllOrders() {

        List<Order> orderList = new ArrayList<>();

        if (conn != null) {
            try {

                String sql = "SELECT * FROM orders ORDER BY order_id DESC";

                PreparedStatement ps = conn.prepareStatement(sql);

                ResultSet rs = ps.executeQuery();

                while (rs.next()) {

                    Order order = new Order();

                    order.setId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setCreatedAt(rs.getTimestamp("created_at"));
                    try { order.setCancellationReason(rs.getString("cancellation_reason")); } catch (Exception ex) {}

                    orderList.add(order);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return orderList;
    }

    // UPDATE ORDER STATUS
    @Override
    public boolean updateOrderStatus(int orderId, String status) {

        try {

            String sql = "UPDATE orders SET status=? WHERE order_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // UPDATE ORDER STATUS WITH CANCELLATION REASON
    @Override
    public boolean updateOrderStatus(int orderId, String status, String cancellationReason) {
        addCancellationReasonColumnIfNotExists();

        if (conn != null) {
            try {
                String sql = "UPDATE orders SET status=?, cancellation_reason=? WHERE order_id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, status);
                ps.setString(2, cancellationReason);
                ps.setInt(3, orderId);
                if (ps.executeUpdate() > 0) {
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return updateOrderStatus(orderId, status);
    }

    private void addCancellationReasonColumnIfNotExists() {
        if (conn != null) {
            try {
                String sql = "ALTER TABLE orders ADD COLUMN cancellation_reason VARCHAR(255) DEFAULT NULL";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.executeUpdate();
            } catch (Exception e) {
                // Column already exists
            }
        }
    }

    // DELETE ORDER
    @Override
    public boolean deleteOrder(int orderId) {

        try {

            String sql = "DELETE FROM orders WHERE order_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}