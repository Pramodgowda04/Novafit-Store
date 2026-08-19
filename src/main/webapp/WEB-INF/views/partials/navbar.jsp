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

<!-- MOBILE BOTTOM NAVIGATION DOCK (Native App Bar) -->
<div class="nf-mobile-bottom-dock">
    <a href="<%= request.getContextPath() %>/home" class="dock-item">
        <i class="fa-solid fa-house"></i>
        <span>Home</span>
    </a>
    <a href="<%= request.getContextPath() %>/products" class="dock-item">
        <i class="fa-solid fa-bag-shopping"></i>
        <span>Shop</span>
    </a>
    <a href="<%= request.getContextPath() %>/wishlist" class="dock-item dock-badge-item">
        <i class="fa-solid fa-heart" style="color:#ff385c;"></i>
        <span>Wishlist</span>
        <span class="dock-badge">${sessionScope.wishlistCount != null ? sessionScope.wishlistCount : 0}</span>
    </a>
    <a href="<%= request.getContextPath() %>/cart" class="dock-item dock-badge-item">
        <i class="fa-solid fa-cart-shopping"></i>
        <span>Cart</span>
        <span class="dock-badge">${globalCartItemCount != null ? globalCartItemCount : 0}</span>
    </a>
    <a href="<%= request.getContextPath() %>/<%= isLoggedIn ? "profile" : "login" %>" class="dock-item">
        <i class="fa-regular fa-user"></i>
        <span>Account</span>
    </a>
</div>

<!-- DESKTOP AND MOBILE RESPONSIVENESS STYLES -->
<style>
/* DOCK DEFAULT HIDDEN */
.nf-mobile-bottom-dock {
    display: none;
}

/* FULL DESKTOP MODE (SYSTEMS & LAPTOPS > 768px) */
@media screen and (min-width: 769px) {
    .nf-main-header {
        flex-direction: row !important;
        justify-content: space-between !important;
        align-items: center !important;
        padding: 16px 55px !important;
    }
    .nf-main-nav {
        display: flex !important;
        flex-direction: row !important;
        gap: 25px !important;
        overflow: visible !important;
        white-space: normal !important;
    }
    .nf-header-actions {
        width: auto !important;
    }
}

/* MOBILE APP MODE (PHONES & TABLETS <= 768px) */
@media screen and (max-width: 768px) {
    body {
        padding-bottom: 70px !important;
    }
    .nf-main-header {
        flex-direction: column;
        gap: 12px;
        padding: 12px 18px;
        background: #ffffff;
        box-shadow: 0 4px 15px rgba(0,0,0,0.05);
    }
    .nf-main-nav {
        display: flex;
        overflow-x: auto;
        width: 100%;
        padding-bottom: 8px;
        white-space: nowrap;
        gap: 10px;
        -webkit-overflow-scrolling: touch;
    }
    .nf-main-nav a {
        background: #f5f5f7;
        color: #111;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.82rem;
        font-weight: 700;
        text-decoration: none;
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
        border-radius: 20px;
    }
    .nf-top-offer-bar {
        padding: 0 15px;
        font-size: 0.75rem;
    }

    /* MOBILE BOTTOM DOCK */
    .nf-mobile-bottom-dock {
        display: flex;
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 62px;
        background: rgba(255, 255, 255, 0.96);
        backdrop-filter: blur(15px);
        -webkit-backdrop-filter: blur(15px);
        border-top: 1px solid rgba(0, 0, 0, 0.08);
        box-shadow: 0 -5px 25px rgba(0, 0, 0, 0.08);
        justify-content: space-around;
        align-items: center;
        z-index: 99999;
        padding: 6px 0;
    }
    .dock-item {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        color: #666;
        font-size: 0.72rem;
        font-weight: 700;
        gap: 3px;
        position: relative;
        flex: 1;
        transition: color 0.3s ease;
    }
    .dock-item i {
        font-size: 1.25rem;
    }
    .dock-item:hover {
        color: #111;
    }
    .dock-badge {
        position: absolute;
        top: -2px;
        right: 22%;
        background: #ff385c;
        color: #fff;
        font-size: 0.65rem;
        font-weight: 800;
        width: 16px;
        height: 16px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* MOBILE PRODUCT GRID 2-COLUMN */
    .product-grid, .products-grid {
        grid-template-columns: repeat(2, 1fr) !important;
        gap: 12px !important;
        padding: 0 10px !important;
    }
    .product-card {
        border-radius: 16px !important;
    }
}
</style>