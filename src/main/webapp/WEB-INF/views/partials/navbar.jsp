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

    if (isLoggedIn && session.getAttribute("wishlistCount") == null) {
        try {
            int userId = (Integer) session.getAttribute("userId");
            com.fashionstore.dao.WishlistDAO navWishlistDAO = new com.fashionstore.dao.impl.WishlistDAOImpl();
            session.setAttribute("wishlistCount", navWishlistDAO.getWishlistCount(userId));
        } catch (Exception e) {
            session.setAttribute("wishlistCount", 0);
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

    <a href="javascript:history.back()" class="nf-nav-back-btn" title="Go Back" style="display:inline-flex; align-items:center; gap:6px; background:rgba(0,0,0,0.06); color:#111; text-decoration:none; padding:6px 14px; border-radius:20px; font-weight:700; font-size:0.82rem; border:1px solid rgba(0,0,0,0.15); transition:all 0.3s ease; margin-left:10px;">
        <i class="fa-solid fa-arrow-left"></i>
        <span>Back</span>
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

        <a href="<%= request.getContextPath() %>/wishlist" class="cart-icon" title="Wishlist">
            <i class="fa-solid fa-heart" style="color: #ff385c;"></i>
            <span class="nav-wishlist-badge">${sessionScope.wishlistCount != null ? sessionScope.wishlistCount : 0}</span>
        </a>

        <a href="<%= request.getContextPath() %>/cart" class="cart-icon" title="Cart">
            <i class="fa-solid fa-cart-shopping"></i>
            <span>${globalCartItemCount != null ? globalCartItemCount : 0}</span>
        </a>

        <% boolean isUserAdmin = session.getAttribute("isAdmin") != null && (Boolean) session.getAttribute("isAdmin"); %>

        <% if (isUserAdmin) { %>
            <a href="<%= request.getContextPath() %>/admin/products" style="background:#111; color:#c89b3c; border:1px solid #c89b3c; padding:7px 16px; border-radius:20px; font-weight:800; font-size:0.82rem; text-decoration:none; display:inline-flex; align-items:center; gap:6px; box-shadow: 0 4px 12px rgba(200,155,60,0.2);">
                <i class="fa-solid fa-crown" style="color:#c89b3c;"></i> ADMIN INVENTORY
            </a>
        <% } %>

        <% if (isLoggedIn) { %>

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

<!-- MOBILE NAVBAR RESPONSIVENESS STYLES -->
<style>
@media (max-width: 768px) {
    .nf-main-header {
        flex-direction: column;
        gap: 12px;
        padding: 12px 18px;
    }
    .nf-main-nav {
        display: flex;
        overflow-x: auto;
        width: 100%;
        padding-bottom: 6px;
        white-space: nowrap;
        gap: 12px;
    }
    .nf-header-actions {
        width: 100%;
        justify-content: space-between;
        gap: 8px;
    }
    .nf-nav-search {
        flex: 1;
    }
    .nf-nav-search input {
        width: 100%;
    }
    .nf-top-offer-bar {
        padding: 0 15px;
        font-size: 0.75rem;
    }
}
</style>