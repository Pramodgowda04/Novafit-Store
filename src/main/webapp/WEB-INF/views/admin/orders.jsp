<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,java.util.Map,com.fashionstore.model.Order,com.fashionstore.model.OrderItem,com.fashionstore.model.User"%>

<%
    String contextPath = request.getContextPath();

    List<Order> allOrders = (List<Order>) request.getAttribute("allOrders");
    Map<Integer, List<OrderItem>> orderItemsMap = (Map<Integer, List<OrderItem>>) request.getAttribute("orderItemsMap");
    Map<Integer, User> userMap = (Map<Integer, User>) request.getAttribute("userMap");
    Map<String, List<Order>> ordersByDateMap = (Map<String, List<Order>>) request.getAttribute("ordersByDateMap");

    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
    Integer totalOrdersCount = (Integer) request.getAttribute("totalOrdersCount");
    Integer pendingOrdersCount = (Integer) request.getAttribute("pendingOrdersCount");
    Integer deliveredOrdersCount = (Integer) request.getAttribute("deliveredOrdersCount");

    if (totalRevenue == null) totalRevenue = 0.0;
    if (totalOrdersCount == null) totalOrdersCount = 0;
    if (pendingOrdersCount == null) pendingOrdersCount = 0;
    if (deliveredOrdersCount == null) deliveredOrdersCount = 0;

    String adminMessage = (String) session.getAttribute("adminMessage");
    if (adminMessage != null) {
        session.removeAttribute("adminMessage");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Order Management - NOVAFIT</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
* { margin:0; padding:0; box-sizing:border-box; font-family: Arial, Helvetica, sans-serif; }

body {
    background: #0f1115;
    color: #e5e5e5;
    min-height: 100vh;
}

.admin-header {
    background: #161920;
    border-bottom: 1px solid rgba(200, 155, 60, 0.3);
    padding: 18px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.admin-logo {
    font-size: 1.6rem;
    font-weight: 900;
    color: #ffffff;
    letter-spacing: 2px;
    text-decoration: none;
}
.admin-logo span { color: #c89b3c; }

.admin-nav {
    display: flex;
    gap: 20px;
    align-items: center;
}
.admin-nav a {
    color: #ddd;
    text-decoration: none;
    font-weight: 700;
    font-size: 0.95rem;
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 8px 16px;
    border-radius: 20px;
    transition: 0.3s ease;
}
.admin-nav a:hover, .admin-nav a.active {
    background: rgba(200, 155, 60, 0.2);
    color: #c89b3c;
}

.admin-container {
    max-width: 1300px;
    margin: 35px auto;
    padding: 0 20px;
}

/* STATS ROW */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 20px;
    margin-bottom: 35px;
}

.stat-box {
    background: #161920;
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 18px;
    padding: 22px;
    display: flex;
    align-items: center;
    gap: 18px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
}

.stat-icon {
    width: 54px;
    height: 54px;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
}
.stat-revenue { background: rgba(200, 155, 60, 0.15); color: #c89b3c; }
.stat-orders { background: rgba(13, 110, 253, 0.15); color: #0d6efd; }
.stat-pending { background: rgba(255, 193, 7, 0.15); color: #ffc107; }
.stat-delivered { background: rgba(25, 135, 84, 0.15); color: #198754; }

.stat-info h4 { font-size: 0.85rem; color: #888; text-transform: uppercase; letter-spacing: 1px; }
.stat-info p { font-size: 1.6rem; font-weight: 900; color: #fff; margin-top: 4px; }

/* FILTER TABS */
.filter-bar {
    display: flex;
    gap: 12px;
    margin-bottom: 25px;
    overflow-x: auto;
    padding-bottom: 8px;
}

.filter-tab {
    background: #161920;
    color: #aaa;
    border: 1px solid rgba(255,255,255,0.08);
    padding: 10px 20px;
    border-radius: 25px;
    font-weight: 700;
    font-size: 0.88rem;
    cursor: pointer;
    transition: 0.3s ease;
}
.filter-tab:hover, .filter-tab.active {
    background: #c89b3c;
    color: #111;
    border-color: #c89b3c;
}

/* ORDER CARDS */
.orders-list { display: flex; flex-direction: column; gap: 24px; }

.admin-order-card {
    background: #161920;
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 20px;
    padding: 25px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.25);
    transition: transform 0.3s ease;
}
.admin-order-card:hover { border-color: rgba(200, 155, 60, 0.4); }

.order-card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid rgba(255,255,255,0.08);
    padding-bottom: 15px;
    margin-bottom: 18px;
}

.order-id-title { font-size: 1.2rem; font-weight: 800; color: #fff; }
.order-id-title span { color: #c89b3c; }

.badge-status {
    padding: 6px 16px;
    border-radius: 20px;
    font-size: 0.82rem;
    font-weight: 800;
    text-transform: uppercase;
}
.badge-placed { background: rgba(13, 110, 253, 0.2); color: #0d6efd; border: 1px solid #0d6efd; }

.date-group-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-top: 30px;
    margin-bottom: 18px;
    padding: 14px 24px;
    background: rgba(22, 25, 32, 0.9);
    border-left: 5px solid #c89b3c;
    border-radius: 16px;
    border: 1px solid rgba(200, 155, 60, 0.25);
    box-shadow: 0 8px 25px rgba(0,0,0,0.3);
}
.date-group-title {
    display: flex;
    align-items: center;
    gap: 12px;
}
.date-group-title h3 {
    font-size: 1.15rem;
    color: #ffffff;
    font-weight: 800;
    letter-spacing: 0.5px;
}
.date-order-badge {
    background: rgba(200, 155, 60, 0.18);
    color: #c89b3c;
    padding: 5px 14px;
    border-radius: 20px;
    font-size: 0.82rem;
    font-weight: 800;
    border: 1px solid rgba(200, 155, 60, 0.3);
}
.badge-processing { background: rgba(255, 193, 7, 0.2); color: #ffc107; border: 1px solid #ffc107; }
.badge-shipped { background: rgba(13, 202, 240, 0.2); color: #0dcaf0; border: 1px solid #0dcaf0; }
.badge-delivered { background: rgba(25, 135, 84, 0.2); color: #198754; border: 1px solid #198754; }
.badge-cancelled { background: rgba(220, 53, 69, 0.2); color: #dc3545; border: 1px solid #dc3545; }

.order-body-grid {
    display: grid;
    grid-template-columns: 1fr 2fr;
    gap: 25px;
}

.customer-info-box {
    background: #0f1115;
    padding: 18px;
    border-radius: 14px;
    border: 1px solid rgba(255,255,255,0.05);
}
.customer-info-box h4 { color: #c89b3c; font-size: 0.95rem; margin-bottom: 10px; }
.customer-info-box p { color: #bbb; font-size: 0.88rem; margin-bottom: 6px; }

.items-table {
    width: 100%;
    border-collapse: collapse;
}
.items-table th { text-align: left; color: #888; font-size: 0.82rem; padding: 8px 10px; border-bottom: 1px solid rgba(255,255,255,0.08); }
.items-table td { color: #ddd; font-size: 0.88rem; padding: 10px; border-bottom: 1px solid rgba(255,255,255,0.04); }

.order-card-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 20px;
    padding-top: 15px;
    border-top: 1px solid rgba(255,255,255,0.08);
}

.status-update-form {
    display: flex;
    gap: 12px;
    align-items: center;
}

.select-status {
    background: #0f1115;
    color: #fff;
    border: 1px solid rgba(200, 155, 60, 0.4);
    padding: 8px 14px;
    border-radius: 20px;
    font-weight: 700;
    outline: none;
}

.btn-update {
    background: linear-gradient(135deg, #c89b3c, #b47a18);
    color: #fff;
    border: none;
    padding: 9px 22px;
    border-radius: 20px;
    font-weight: 800;
    cursor: pointer;
    transition: 0.3s ease;
}
.btn-update:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(200, 155, 60, 0.3); }

/* TOAST */
.admin-toast {
    position: fixed;
    bottom: 30px;
    right: 30px;
    background: #c89b3c;
    color: #111;
    padding: 14px 24px;
    border-radius: 30px;
    font-weight: 900;
    box-shadow: 0 10px 30px rgba(0,0,0,0.5);
    z-index: 9999;
}

/* MOBILE RESPONSIVENESS */
@media (max-width: 768px) {
    .admin-header { flex-direction: column; gap: 15px; text-align: center; padding: 15px 20px; }
    .admin-nav { flex-wrap: wrap; justify-content: center; gap: 10px; }
    .stats-grid { grid-template-columns: repeat(2, 1fr); gap: 12px; }
    .order-body-grid { grid-template-columns: 1fr; }
    .order-card-header { flex-direction: column; align-items: flex-start; gap: 10px; }
    .order-card-footer { flex-direction: column; align-items: flex-start; gap: 15px; }
    .status-update-form { width: 100%; flex-direction: column; align-items: stretch; }
    .input-reason { width: 100% !important; }
    .filter-bar { overflow-x: auto; flex-wrap: nowrap; }
}
</style>
</head>

<body>

<!-- ADMIN HEADER -->
<header class="admin-header">
    <a href="<%= contextPath %>/admin/orders" class="admin-logo">
        NOVA<span>FIT</span> <small style="font-size: 0.6rem; letter-spacing: 2px; color:#888;">ADMIN PANEL</small>
    </a>

    <nav class="admin-nav">
        <a href="javascript:history.back()" style="background:rgba(255,255,255,0.08); color:#fff;">
            <i class="fa-solid fa-arrow-left"></i> Back
        </a>
        <a href="<%= contextPath %>/admin/orders">
            <i class="fa-solid fa-boxes-stacked"></i> Orders
        </a>
        <a href="<%= contextPath %>/admin/products">
            <i class="fa-solid fa-shirt"></i> Product Inventory
        </a>
        <a href="<%= contextPath %>/products">
            <i class="fa-solid fa-store"></i> Storefront
        </a>
        <a href="<%= contextPath %>/admin/logout">
            <i class="fa-solid fa-right-from-bracket"></i> Logout
        </a>
    </nav>
</header>

<div class="admin-container">

    <!-- STATS ROW (CLICKABLE FOR INSTANT FILTERING) -->
    <div class="stats-grid">
        <div class="stat-box" onclick="filterOrders('ALL', document.getElementById('tabAll'))" title="Click to view all orders">
            <div class="stat-icon stat-revenue"><i class="fa-solid fa-indian-rupee-sign"></i></div>
            <div class="stat-info">
                <h4>Total Revenue</h4>
                <p>₹ <%= String.format("%.2f", totalRevenue) %></p>
            </div>
        </div>

        <div class="stat-box" onclick="filterOrders('ALL', document.getElementById('tabAll'))" title="Click to view all orders">
            <div class="stat-icon stat-orders"><i class="fa-solid fa-bag-shopping"></i></div>
            <div class="stat-info">
                <h4>Total Orders</h4>
                <p><%= totalOrdersCount %></p>
            </div>
        </div>

        <div class="stat-box" id="pendingStatBox" onclick="filterOrders('PENDING', document.getElementById('tabPending'))" title="Click to view pending orders" style="border: 1px solid rgba(255, 193, 7, 0.4); background: rgba(255, 193, 7, 0.05);">
            <div class="stat-icon stat-pending"><i class="fa-solid fa-clock"></i></div>
            <div class="stat-info">
                <h4 style="color:#ffc107;">Pending Orders 👈</h4>
                <p style="color:#ffc107;"><%= pendingOrdersCount %></p>
            </div>
        </div>

        <div class="stat-box" onclick="filterOrders('Delivered', document.getElementById('tabDelivered'))" title="Click to view delivered orders">
            <div class="stat-icon stat-delivered"><i class="fa-solid fa-circle-check"></i></div>
            <div class="stat-info">
                <h4>Delivered Orders</h4>
                <p><%= deliveredOrdersCount %></p>
            </div>
        </div>
    </div>

    <!-- FILTER TABS -->
    <div class="filter-bar">
        <button class="filter-tab active" id="tabAll" onclick="filterOrders('ALL', this)">ALL ORDERS (<%= totalOrdersCount %>)</button>
        <button class="filter-tab" id="tabPending" onclick="filterOrders('PENDING', this)" style="border-color:#ffc107; color:#ffc107;">PENDING (<%= pendingOrdersCount %>)</button>
        <button class="filter-tab" onclick="filterOrders('Placed', this)">PLACED</button>
        <button class="filter-tab" onclick="filterOrders('Processing', this)">PROCESSING</button>
        <button class="filter-tab" onclick="filterOrders('Shipped', this)">SHIPPED</button>
        <button class="filter-tab" id="tabDelivered" onclick="filterOrders('Delivered', this)">DELIVERED</button>
        <button class="filter-tab" onclick="filterOrders('Cancelled', this)">CANCELLED</button>
    </div>

    <!-- ORDERS LIST CATEGORIZED BY DATE -->
    <div class="orders-list">
        <% if (ordersByDateMap != null && !ordersByDateMap.isEmpty()) {
            for (Map.Entry<String, List<Order>> dateEntry : ordersByDateMap.entrySet()) {
                String dateLabel = dateEntry.getKey();
                List<Order> dateOrders = dateEntry.getValue();
        %>
            <div class="date-group-header">
                <div class="date-group-title">
                    <i class="fa-solid fa-calendar-days" style="color:#c89b3c; font-size:1.2rem;"></i>
                    <h3><%= dateLabel %></h3>
                </div>
                <span class="date-order-badge"><%= dateOrders.size() %> Order(s)</span>
            </div>

            <% for (Order order : dateOrders) {
                User u = userMap != null ? userMap.get(order.getUserId()) : null;
                List<OrderItem> items = orderItemsMap != null ? orderItemsMap.get(order.getId()) : null;
                String st = order.getStatus() == null ? "Placed" : order.getStatus();
                String badgeClass = "badge-placed";
                if ("Processing".equalsIgnoreCase(st)) badgeClass = "badge-processing";
                else if ("Shipped".equalsIgnoreCase(st)) badgeClass = "badge-shipped";
                else if ("Delivered".equalsIgnoreCase(st)) badgeClass = "badge-delivered";
                else if ("Cancelled".equalsIgnoreCase(st)) badgeClass = "badge-cancelled";
            %>
                <div class="admin-order-card" data-status="<%= st %>">
                    <div class="order-card-header">
                        <div class="order-id-title">
                            Order <span>#<%= order.getId() %></span>
                            <small style="font-size:0.85rem; color:#888; margin-left:12px; font-weight:normal;">
                                <%= order.getCreatedAt() != null ? order.getCreatedAt().toString() : "" %>
                            </small>
                        </div>

                        <span class="badge-status <%= badgeClass %>"><%= st %></span>
                    </div>

                    <div class="order-body-grid">
                        <!-- CUSTOMER INFO -->
                        <div class="customer-info-box">
                            <h4><i class="fa-solid fa-user"></i> Customer Details</h4>
                            <p><strong>Name:</strong> <%= u != null ? u.getName() : "Customer #" + order.getUserId() %></p>
                            <p><strong>Email:</strong> <%= u != null ? u.getEmail() : "N/A" %></p>
                            <p><strong>Phone:</strong> <%= u != null ? u.getPhone() : "N/A" %></p>
                            <p><strong>Shipping Address:</strong> <%= u != null && u.getAddress() != null ? u.getAddress() : "Standard Address" %></p>
                        </div>

                        <!-- ORDER ITEMS TABLE -->
                        <div>
                            <h4 style="color:#c89b3c; font-size:0.95rem; margin-bottom:10px;"><i class="fa-solid fa-list-check"></i> Ordered Items</h4>
                            <table class="items-table">
                                <thead>
                                    <tr>
                                        <th>Item</th>
                                        <th>Size</th>
                                        <th>Qty</th>
                                        <th>Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (items != null && !items.isEmpty()) {
                                        for (OrderItem item : items) {
                                    %>
                                        <tr>
                                            <td>Product #<%= item.getProductId() %></td>
                                            <td><%= item.getSize() %></td>
                                            <td><%= item.getQuantity() %></td>
                                            <td>₹ <%= item.getPrice() %></td>
                                        </tr>
                                    <% } } else { %>
                                        <tr><td colspan="4">Standard Product Package</td></tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <% if (order.getCancellationReason() != null && !order.getCancellationReason().trim().isEmpty()) { %>
                        <div style="margin-top:15px; background:rgba(220,53,69,0.12); border:1px solid rgba(220,53,69,0.3); color:#ff6b6b; padding:10px 16px; border-radius:12px; font-size:0.88rem; font-weight:700;">
                            <i class="fa-solid fa-triangle-exclamation"></i> <strong>Cancellation Reason:</strong> <%= order.getCancellationReason() %>
                        </div>
                    <% } %>

                    <div class="order-card-footer">
                        <div>
                            <span style="color:#888; font-size:0.9rem;">Total Amount:</span>
                            <strong style="color:#c89b3c; font-size:1.3rem; margin-left:8px;">₹ <%= String.format("%.2f", order.getTotalAmount()) %></strong>
                        </div>

                        <form action="<%= contextPath %>/admin/orders" method="post" class="status-update-form">
                            <input type="hidden" name="action" value="updateStatus">
                            <input type="hidden" name="orderId" value="<%= order.getId() %>">
                            <select name="status" class="select-status" onchange="handleStatusChange(this)">
                                <option value="Placed" <%= "Placed".equalsIgnoreCase(st) ? "selected" : "" %>>Placed</option>
                                <option value="Processing" <%= "Processing".equalsIgnoreCase(st) ? "selected" : "" %>>Processing</option>
                                <option value="Shipped" <%= "Shipped".equalsIgnoreCase(st) ? "selected" : "" %>>Shipped</option>
                                <option value="Delivered" <%= "Delivered".equalsIgnoreCase(st) ? "selected" : "" %>>Delivered</option>
                                <option value="Cancelled" <%= "Cancelled".equalsIgnoreCase(st) ? "selected" : "" %>>Cancelled</option>
                            </select>

                            <input type="text" name="cancellationReason" class="input-reason" placeholder="Reason for cancellation..." style="display:<%= "Cancelled".equalsIgnoreCase(st) ? "inline-block" : "none" %>; background:#0f1115; color:#fff; border:1px solid rgba(220,53,69,0.5); padding:8px 14px; border-radius:20px; outline:none; font-size:0.85rem; width:220px;" value="<%= order.getCancellationReason() != null ? order.getCancellationReason() : "" %>">

                            <button type="submit" class="btn-update">Update Status</button>
                        </form>
                    </div>
                </div>
            <% } %>
        <% } } else { %>
            <div style="text-align:center; padding:60px; background:#161920; border-radius:20px;">
                <h3>No Orders Found</h3>
            </div>
        <% } %>
    </div>

</div>

<% if (adminMessage != null) { %>
    <div class="admin-toast">
        <i class="fa-solid fa-crown"></i> <%= adminMessage %>
    </div>
    <script>
        setTimeout(() => {
            const toast = document.querySelector('.admin-toast');
            if (toast) toast.style.display = 'none';
        }, 3000);
    </script>
<% } %>

<script>
function filterOrders(status, btn) {
    if (btn) {
        document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
        btn.classList.add('active');
    }

    const cards = document.querySelectorAll('.admin-order-card');
    cards.forEach(card => {
        const cardStatus = card.getAttribute('data-status') || '';
        const stLower = cardStatus.toLowerCase();

        if (status === 'ALL') {
            card.style.display = 'block';
        } else if (status === 'PENDING') {
            if (stLower === 'placed' || stLower === 'processing') {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        } else if (stLower === status.toLowerCase()) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });

    const ordersList = document.querySelector('.orders-list');
    if (ordersList) {
        ordersList.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
}

function handleStatusChange(selectElem) {
    const form = selectElem.closest('form');
    const reasonInput = form.querySelector('.input-reason');
    if (selectElem.value === 'Cancelled') {
        reasonInput.style.display = 'inline-block';
        reasonInput.required = true;
        reasonInput.focus();
    } else {
        reasonInput.style.display = 'none';
        reasonInput.required = false;
    }
}
</script>

</body>
</html>
