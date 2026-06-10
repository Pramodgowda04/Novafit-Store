<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    boolean isLoggedIn = session.getAttribute("userId") != null;

    String loggedUserName = (String) session.getAttribute("userName");

    if (loggedUserName == null || loggedUserName.trim().isEmpty()) {
        loggedUserName = "NovaFit User";
    }

    Object cartCountObj = session.getAttribute("cartCount");
    int navCartCount = 0;

    if (cartCountObj != null) {
        try {
            navCartCount = Integer.parseInt(cartCountObj.toString());
        } catch (Exception e) {
            navCartCount = 0;
        }
    }
%>

<!-- NOVAFIT TOP OFFER BAR -->
<div class="nf-top-offer-bar">

    <div class="nf-offer-left">
        <span>
            <i class="fa-solid fa-truck"></i>
            FREE SHIPPING on orders above ₹999
        </span>

        <span>
            <i class="fa-solid fa-crown"></i>
            EXTRA 10% OFF on prepaid orders
        </span>

        <span>
            <i class="fa-solid fa-gift"></i>
            NEW ARRIVALS are live now!
        </span>
    </div>

    <a href="<%= request.getContextPath() %>/products">
        SHOP NOW
        <i class="fa-solid fa-arrow-right"></i>
    </a>

</div>

<!-- NOVAFIT MAIN NAVBAR -->
<header class="nf-main-header">

    <a href="<%= request.getContextPath() %>/home" class="nf-site-logo">
        NOVA<span>FIT</span>
        <small>FASHION STORE</small>
    </a>

    <nav class="nf-main-nav">

        <a href="<%= request.getContextPath() %>/home">
            HOME
        </a>

        <a href="<%= request.getContextPath() %>/products?categoryId=1">
            MEN
        </a>

        <a href="<%= request.getContextPath() %>/products?categoryId=2">
            WOMEN
        </a>

        <a href="<%= request.getContextPath() %>/products?categoryId=4">
            FOOTWEAR
        </a>

        <a href="<%= request.getContextPath() %>/products?categoryId=5">
            ACCESSORIES
        </a>

        <a href="<%= request.getContextPath() %>/products">
            NEW ARRIVALS
        </a>

        <a href="<%= request.getContextPath() %>/products">
            SALE
        </a>

    </nav>

    <div class="nf-header-actions">

        <form action="<%= request.getContextPath() %>/products" method="get" class="nf-nav-search">
            <input type="text" name="keyword" placeholder="Search products...">
            <button type="submit">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
        </form>

        <a href="<%= request.getContextPath() %>/<%= isLoggedIn ? "profile" : "login" %>"
           class="nf-header-icon"
           title="Profile">
            <i class="fa-regular fa-user"></i>
        </a>

        <a href="#" class="nf-header-icon" title="Wishlist">
            <i class="fa-regular fa-heart"></i>
        </a>

        <a href="<%= request.getContextPath() %>/cart" class="cart-icon" title="Cart">
            <i class="fa-solid fa-cart-shopping"></i>
            <span>${globalCartItemCount != null ? globalCartItemCount : 0}</span>
        </a>

        <% if (isLoggedIn) { %>

            <a href="<%= request.getContextPath() %>/profile" class="nf-user-pill">
                Hi, <%= loggedUserName %>
            </a>

            <a href="<%= request.getContextPath() %>/logout" class="nf-logout-btn">
                Logout
            </a>

        <% } else { %>

            <a href="<%= request.getContextPath() %>/login" class="nf-login-btn">
                Login
            </a>

        <% } %>

    </div>

</header>