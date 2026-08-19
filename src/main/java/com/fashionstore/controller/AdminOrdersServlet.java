package com.fashionstore.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.fashionstore.dao.OrderDAO;
import com.fashionstore.dao.OrderItemDAO;
import com.fashionstore.dao.UserDAO;
import com.fashionstore.dao.impl.OrderDAOImpl;
import com.fashionstore.dao.impl.OrderItemDAOImpl;
import com.fashionstore.dao.impl.UserDAOImpl;
import com.fashionstore.model.Order;
import com.fashionstore.model.OrderItem;
import com.fashionstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO = new OrderDAOImpl();
    private OrderItemDAO orderItemDAO = new OrderItemDAOImpl();
    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Order> allOrders = orderDAO.getAllOrders();

        double totalRevenue = 0;
        int totalOrdersCount = 0;
        int pendingOrdersCount = 0;
        int deliveredOrdersCount = 0;

        Map<Integer, List<OrderItem>> orderItemsMap = new HashMap<>();
        Map<Integer, User> userMap = new HashMap<>();
        Map<String, List<Order>> ordersByDateMap = new LinkedHashMap<>();

        SimpleDateFormat dateKeyFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat displayDateFormat = new SimpleDateFormat("dd MMM yyyy (EEEE)");

        String todayKey = dateKeyFormat.format(new Date());

        if (allOrders != null) {
            totalOrdersCount = allOrders.size();
            for (Order order : allOrders) {
                if ("Delivered".equalsIgnoreCase(order.getStatus())) {
                    deliveredOrdersCount++;
                    totalRevenue += order.getTotalAmount();
                } else if ("Placed".equalsIgnoreCase(order.getStatus()) || "Processing".equalsIgnoreCase(order.getStatus())) {
                    pendingOrdersCount++;
                    totalRevenue += order.getTotalAmount();
                } else if ("Shipped".equalsIgnoreCase(order.getStatus())) {
                    totalRevenue += order.getTotalAmount();
                }

                // Fetch items for each order
                List<OrderItem> items = orderItemDAO.getItemsByOrderId(order.getId());
                orderItemsMap.put(order.getId(), items);

                // Fetch user info for each order
                if (!userMap.containsKey(order.getUserId())) {
                    User u = userDAO.getUserById(order.getUserId());
                    if (u != null) {
                        userMap.put(order.getUserId(), u);
                    }
                }

                // Group orders by date
                String dateGroupLabel = "Earlier Orders";
                String rawDateKey = todayKey;
                if (order.getCreatedAt() != null) {
                    rawDateKey = dateKeyFormat.format(order.getCreatedAt());
                    dateGroupLabel = displayDateFormat.format(order.getCreatedAt());
                    if (todayKey.equals(rawDateKey)) {
                        dateGroupLabel = "Today - " + dateGroupLabel;
                    }
                }

                if (!ordersByDateMap.containsKey(dateGroupLabel)) {
                    ordersByDateMap.put(dateGroupLabel, new ArrayList<>());
                }
                ordersByDateMap.get(dateGroupLabel).add(order);
            }
        }

        request.setAttribute("allOrders", allOrders);
        request.setAttribute("orderItemsMap", orderItemsMap);
        request.setAttribute("userMap", userMap);
        request.setAttribute("ordersByDateMap", ordersByDateMap);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalOrdersCount", totalOrdersCount);
        request.setAttribute("pendingOrdersCount", pendingOrdersCount);
        request.setAttribute("deliveredOrdersCount", deliveredOrdersCount);

        request.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("updateStatus".equalsIgnoreCase(action)) {
            String orderIdParam = request.getParameter("orderId");
            String status = request.getParameter("status");
            String cancellationReason = request.getParameter("cancellationReason");

            if (orderIdParam != null && status != null) {
                try {
                    int orderId = Integer.parseInt(orderIdParam.trim());
                    boolean updated = false;

                    if ("Cancelled".equalsIgnoreCase(status)) {
                        if (cancellationReason == null || cancellationReason.trim().isEmpty()) {
                            cancellationReason = "Cancelled by Store Administrator";
                        }
                        updated = orderDAO.updateOrderStatus(orderId, status, cancellationReason.trim());
                    } else {
                        updated = orderDAO.updateOrderStatus(orderId, status);
                    }

                    if (updated) {
                        request.getSession().setAttribute("adminMessage", "Order #" + orderId + " updated to " + status + " 👑");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
