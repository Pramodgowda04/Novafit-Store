<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.fashionstore.model.User" %>

<%!
    private String safe(String value) {
        if (value == null) {
            return "";
        }

        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }

    private int getNumber(Object value) {
        if (value == null) {
            return 0;
        }

        try {
            return Integer.parseInt(value.toString());
        } catch (Exception e) {
            return 0;
        }
    }
%>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    User loggedUser = (User) session.getAttribute("loggedUser");

    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    String userPhone = (String) session.getAttribute("userPhone");
    String userAddress = (String) session.getAttribute("userAddress");

    if (loggedUser != null) {
        if (userName == null || userName.trim().isEmpty()) {
            userName = loggedUser.getName();
        }

        if (userEmail == null || userEmail.trim().isEmpty()) {
            userEmail = loggedUser.getEmail();
        }

        if (userPhone == null || userPhone.trim().isEmpty()) {
            userPhone = loggedUser.getPhone();
        }

        if (userAddress == null || userAddress.trim().isEmpty()) {
            userAddress = loggedUser.getAddress();
        }
    }

    if (userName == null || userName.trim().isEmpty()) {
        userName = "NovaFit User";
    }

    if (userEmail == null || userEmail.trim().isEmpty()) {
        userEmail = "Not Available";
    }

    if (userPhone == null || userPhone.trim().isEmpty()) {
        userPhone = "Not Available";
    }

    if (userAddress == null || userAddress.trim().isEmpty()) {
        userAddress = "Not Available";
    }

    String firstLetter = userName.substring(0, 1).toUpperCase();

    int totalOrders = getNumber(request.getAttribute("totalOrders"));
    int cartItems = getNumber(request.getAttribute("cartItems"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile - NOVAFIT Fashion Store</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/profile.css?v=5">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>

<body>

<section class="profile-page">

    <div class="profile-shell">

        <!-- HEADER -->
        <header class="profile-header">

            <a href="<%= request.getContextPath() %>/home" class="profile-logo">
                NOVA<span>FIT</span>
                <small>FASHION STORE</small>
            </a>

            <nav class="profile-nav">

                <a href="<%= request.getContextPath() %>/home">
                    <i class="fa-solid fa-house"></i>
                    Home
                </a>

                <a href="<%= request.getContextPath() %>/products">
                    <i class="fa-solid fa-bag-shopping"></i>
                    Shop
                </a>

                  <a href="<%= request.getContextPath() %>/cart" class="stat-card">
                      <i class="fa-solid fa-cart-shopping"></i>
                      Cart
                      <span>${globalCartItemCount != null ? globalCartItemCount : 0}</span>
                  </a>

                <a href="<%= request.getContextPath() %>/orders">
                    <i class="fa-solid fa-box"></i>
                    Orders
                </a>

                <a href="<%= request.getContextPath() %>/logout" class="logout-btn">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    Logout
                </a>

            </nav>

        </header>

        <!-- MAIN LAYOUT -->
        <main class="profile-layout">

            <!-- LEFT SIDEBAR -->
            <aside class="profile-sidebar">

                <div class="user-card">

                    <div class="avatar-outer">
                        <div class="avatar-inner">
                            <%= safe(firstLetter) %>
                        </div>
                    </div>

                    <h2><%= safe(userName) %></h2>
                    <p class="user-email"><%= safe(userEmail) %></p>

                    <div class="member-badge">
                        <i class="fa-solid fa-crown"></i>
                        NovaFit Member
                    </div>

                    <div class="side-line"></div>

                    <div class="side-info">
                        <div class="side-icon">
                            <i class="fa-solid fa-shield-halved"></i>
                        </div>

                        <div>
                            <h4>Account Status</h4>
                            <p class="green-text">Active & Secure</p>
                        </div>
                    </div>

                    <div class="side-info">
                        <div class="side-icon">
                            <i class="fa-solid fa-calendar-check"></i>
                        </div>

                        <div>
                            <h4>Member Since</h4>
                            <p class="gold-text">NovaFit Customer</p>
                        </div>
                    </div>

                </div>

                <div class="offer-card">

                    <div class="offer-content">
                        <h3>Special Offer</h3>
                        <p>
                            Use code <strong>NOVAFIT20</strong> and get 20% OFF on your next order.
                        </p>

                        <a href="<%= request.getContextPath() %>/products">
                            Shop Now
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>
                    </div>

                    <div class="gift-box">
                        <i class="fa-solid fa-gift"></i>
                    </div>

                </div>

            </aside>

            <!-- RIGHT CONTENT -->
            <section class="profile-content">

                <!-- WELCOME BANNER -->
                <div class="welcome-banner">

                    <div class="banner-text">
                        <p>MY ACCOUNT</p>
                        <h1>
                            Welcome back,
                            <span><%= safe(userName) %>!</span>
                        </h1>

                        <h4>
                            Manage your profile, track your orders, view cart items,
                            and continue your NovaFit fashion journey.
                        </h4>
                    </div>

                    <div class="banner-icon">
                        <i class="fa-regular fa-user"></i>
                    </div>

                </div>

                <!-- STATS -->
                <div class="stats-grid">

                    <a href="<%= request.getContextPath() %>/orders" class="stat-card">
                        <div class="stat-icon">
                            <i class="fa-solid fa-box"></i>
                        </div>

                        <div>
                            <h2><%= totalOrders %></h2>
                            <p>Total Orders</p>
                            <span>View your order history</span>
                        </div>
                    </a>

                    <a href="<%= request.getContextPath() %>/cart" class="stat-card">
                        <div class="stat-icon">
                            <i class="fa-solid fa-cart-shopping"></i>
                        </div>

                        <div>
                            <h2>${globalCartItemCount != null ? globalCartItemCount : 0}</h2>
                            <p>Cart Items</p>
                            <span>Items in your cart</span>
                        </div>
                    </a>


                </div>

                <!-- DETAILS AREA -->
                <div class="details-grid">

                    <!-- PERSONAL INFO -->
                    <div class="info-card">

                        <div class="card-title">
                            <i class="fa-regular fa-id-card"></i>
                            <h2>Personal Information</h2>
                        </div>

                        <div class="profile-table">

                            <div class="table-row">
                                <div class="table-icon">
                                    <i class="fa-regular fa-user"></i>
                                </div>

                                <div>
                                    <h4>Full Name</h4>
                                    <p><%= safe(userName) %></p>
                                </div>
                            </div>

                            <div class="table-row">
                                <div class="table-icon">
                                    <i class="fa-regular fa-envelope"></i>
                                </div>

                                <div>
                                    <h4>Email Address</h4>
                                    <p><%= safe(userEmail) %></p>
                                </div>
                            </div>

                            <div class="table-row">
                                <div class="table-icon">
                                    <i class="fa-solid fa-phone"></i>
                                </div>

                                <div>
                                    <h4>Phone Number</h4>
                                    <p><%= safe(userPhone) %></p>
                                </div>
                            </div>

                        </div>

                        <a href="#" class="edit-profile-btn">
                            <i class="fa-regular fa-pen-to-square"></i>
                            Edit Profile
                        </a>

                    </div>

                    <!-- ADDRESS INFO -->
                    <div class="info-card">

                        <div class="card-title">
                            <i class="fa-solid fa-location-dot"></i>
                            <h2>Delivery Address</h2>
                        </div>

                        <div class="address-box">

                            <div class="address-icon">
                                <i class="fa-solid fa-location-dot"></i>
                            </div>

                            <p><%= safe(userAddress) %></p>

                        </div>

                        <div class="secure-box">

                            <div class="secure-icon">
                                <i class="fa-solid fa-shield-halved"></i>
                            </div>

                            <div>
                                <h3>Secure Account</h3>
                                <p>
                                    Your account is protected using session-based authentication.
                                </p>
                            </div>

                        </div>

                    </div>

                </div>

                <!-- QUICK ACTIONS -->
                <div class="quick-actions-card">

                    <div class="card-title">
                        <i class="fa-solid fa-bolt"></i>
                        <h2>Quick Actions</h2>
                    </div>

                    <div class="actions-grid">

                        <a href="<%= request.getContextPath() %>/products">
                            <i class="fa-solid fa-shirt"></i>
                            <span>Explore Products</span>
                        </a>

                        <a href="<%= request.getContextPath() %>/cart">
                            <i class="fa-solid fa-cart-shopping"></i>
                            <span>View Cart</span>
                        </a>

                        <a href="<%= request.getContextPath() %>/orders">
                            <i class="fa-solid fa-box"></i>
                            <span>My Orders</span>
                        </a>


                        <a href="<%= request.getContextPath() %>/orders">
                            <i class="fa-solid fa-truck"></i>
                            <span>Track Order</span>
                        </a>

                        <a href="<%= request.getContextPath() %>/logout" class="danger-action">
                            <i class="fa-solid fa-right-from-bracket"></i>
                            <span>Logout</span>
                        </a>

                    </div>

                </div>

            </section>

        </main>

    </div>
    

</section>

</body>
</html>