<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.fashionstore.model.Product"%>

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
%>

<%
    String contextPath = request.getContextPath();

    if (session.getAttribute("userId") == null) {
        response.sendRedirect(contextPath + "/login");
        return;
    }

    String userName = (String) session.getAttribute("userName");
    if (userName == null || userName.trim().isEmpty()) {
        userName = "NovaFit User";
    }

    List<Product> wishlistItems = (List<Product>) request.getAttribute("wishlistItems");
    int wishlistCount = wishlistItems == null ? 0 : wishlistItems.size();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Wishlist - NOVAFIT Fashion Store</title>

<link rel="stylesheet" href="<%= contextPath %>/assets/css/profile.css?v=10">
<link rel="stylesheet" href="<%= contextPath %>/assets/css/product.css?v=2002">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* --- SPECIAL LUXURY GLASSMORPHISM & AMBIENT GOLD MESH BACKGROUND --- */
body {
    background: 
        radial-gradient(circle at 10% 10%, rgba(200, 155, 60, 0.22), transparent 38%),
        radial-gradient(circle at 90% 85%, rgba(255, 56, 92, 0.14), transparent 42%),
        radial-gradient(circle at 50% 50%, rgba(200, 155, 60, 0.12), transparent 50%),
        linear-gradient(135deg, #faf4e8 0%, #eddcc8 100%) !important;
}

.profile-page {
    background: transparent !important;
}

.profile-shell {
    background: rgba(255, 255, 255, 0.68) !important;
    backdrop-filter: blur(25px) !important;
    -webkit-backdrop-filter: blur(25px) !important;
    border: 1.5px solid rgba(255, 255, 255, 0.9) !important;
    box-shadow: 
        0 30px 90px rgba(0,0,0,0.08),
        0 0 50px rgba(200, 155, 60, 0.18),
        inset 0 1px 1px rgba(255,255,255,1) !important;
}

.wishlist-main-card {
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.92), rgba(255, 250, 242, 0.97)) !important;
    backdrop-filter: blur(15px);
    border-radius: 24px !important;
    padding: 30px !important;
    border: 1.5px solid rgba(200, 155, 60, 0.22) !important;
    box-shadow: 
        0 20px 50px rgba(0, 0, 0, 0.06),
        0 0 25px rgba(200, 155, 60, 0.10),
        inset 0 1px 2px rgba(255, 255, 255, 0.9) !important;
}

.wishlist-shortcuts-card {
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.92), rgba(255, 248, 236, 0.95)) !important;
    border-radius: 20px !important;
    padding: 24px !important;
    border: 1.5px solid rgba(200, 155, 60, 0.2) !important;
    box-shadow: 0 12px 35px rgba(0,0,0,0.05) !important;
}

.wishlist-grid-profile {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 24px;
}

.wishlist-item-card {
    background: linear-gradient(145deg, rgba(255, 255, 255, 0.96) 0%, rgba(255, 251, 244, 0.98) 100%) !important;
    border-radius: 22px !important;
    border: 1.5px solid rgba(200, 155, 60, 0.18) !important;
    overflow: hidden;
    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.05) !important;
    transition: transform 0.4s cubic-bezier(0.23, 1, 0.32, 1), box-shadow 0.4s cubic-bezier(0.23, 1, 0.32, 1), border-color 0.4s ease !important;
    display: flex;
    flex-direction: column;
}

.wishlist-item-card:hover {
    transform: translateY(-8px) scale(1.02) !important;
    box-shadow: 
        0 24px 50px rgba(200, 155, 60, 0.25),
        0 0 25px rgba(255, 56, 92, 0.15) !important;
    border-color: rgba(200, 155, 60, 0.6) !important;
}

.wishlist-img-box {
    height: 240px;
    background: #fafafa;
    position: relative;
    overflow: hidden;
}

.wishlist-img-box img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.4s ease;
}

.wishlist-item-card:hover .wishlist-img-box img {
    transform: scale(1.08);
}

.wishlist-content {
    padding: 20px;
    display: flex;
    flex-direction: column;
    flex: 1;
    justify-content: space-between;
}

.wishlist-item-title {
    font-size: 1.05rem;
    font-weight: 800;
    color: #111;
    margin-bottom: 6px;
}

.wishlist-item-desc {
    font-size: 0.85rem;
    color: #666;
    margin-bottom: 14px;
    line-height: 1.4;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.wishlist-item-price {
    font-size: 1.3rem;
    font-weight: 900;
    color: #c89b3c;
    margin-bottom: 18px;
}

.wishlist-item-actions {
    display: flex;
    gap: 10px;
    align-items: center;
}

.btn-profile-cart {
    flex: 1;
    background: linear-gradient(135deg, #111111, #2a2a2a);
    color: #ffffff;
    border: none;
    padding: 12px 16px;
    border-radius: 30px;
    font-weight: 800;
    font-size: 0.85rem;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.12);
}

.btn-profile-cart:hover {
    background: linear-gradient(135deg, #c89b3c, #b47a18);
    color: #ffffff;
    transform: translateY(-2px);
    box-shadow: 0 12px 25px rgba(200, 155, 60, 0.35);
}

.btn-profile-remove {
    background: rgba(220, 53, 69, 0.1);
    color: #dc3545;
    border: none;
    width: 42px;
    height: 42px;
    border-radius: 50%;
    cursor: pointer;
    font-size: 1rem;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
}

.btn-profile-remove:hover {
    background: #dc3545;
    color: white;
    transform: scale(1.1);
}

.empty-wishlist-profile {
    text-align: center;
    padding: 70px 20px;
    background: #ffffff;
    border-radius: 20px;
    border: 1px solid #eee;
    box-shadow: 0 10px 30px rgba(0,0,0,0.04);
}

.empty-icon-profile {
    font-size: 4rem;
    color: #c89b3c;
    margin-bottom: 15px;
}

.btn-profile-explore {
    background: linear-gradient(135deg, #c89b3c, #b47a18);
    color: white;
    padding: 14px 34px;
    border-radius: 30px;
    font-weight: 800;
    text-decoration: none;
    display: inline-block;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    box-shadow: 0 10px 25px rgba(200, 155, 60, 0.3);
}

.btn-profile-explore:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 35px rgba(200, 155, 60, 0.45);
}
</style>

</head>

<body>

<section class="profile-page">

    <div class="profile-shell">

        <!-- HEADER (EXACT PROFILE THEME) -->
        <header class="profile-header">

            <a href="<%= contextPath %>/home" class="profile-logo">
                NOVA<span>FIT</span>
                <small>FASHION STORE</small>
            </a>

            <nav class="profile-nav">

                <a href="<%= contextPath %>/home">
                    <i class="fa-solid fa-house"></i>
                    Home
                </a>

                <a href="<%= contextPath %>/products">
                    <i class="fa-solid fa-bag-shopping"></i>
                    Shop
                </a>

                <a href="<%= contextPath %>/wishlist" class="active" style="background:#fff; box-shadow:0 8px 25px rgba(0,0,0,0.08);">
                    <i class="fa-solid fa-heart" style="color:#ff385c;"></i>
                    Wishlist
                    <span class="nav-wishlist-badge" style="background:#ff385c; color:white; border-radius:50%; width:22px; height:22px; display:inline-flex; align-items:center; justify-content:center; font-size:11px; font-weight:900; margin-left:4px;">
                        ${sessionScope.wishlistCount != null ? sessionScope.wishlistCount : 0}
                    </span>
                </a>

                <a href="<%= contextPath %>/cart" class="nav-cart">
                    <i class="fa-solid fa-cart-shopping"></i>
                    Cart
                    <span>${globalCartItemCount != null ? globalCartItemCount : 0}</span>
                </a>

                <a href="<%= contextPath %>/orders">
                    <i class="fa-solid fa-box"></i>
                    Orders
                </a>

                <a href="<%= contextPath %>/logout" class="logout-btn">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    Logout
                </a>

            </nav>

        </header>

        <!-- TOP OFFER BAR (RIGHT-TO-LEFT MARQUEE) -->
        <div class="top-bar" style="margin-bottom: 24px; border-radius: 14px;">
            <div class="top-bar-marquee">
                <!-- Group 1 -->
                <div class="top-bar-item">⭐ <span>NEW COLLECTION ALERT!</span> Get 20% OFF on your first order. Use code: <span>NOVAFIT20</span></div>
                <div class="top-bar-item">🚀 <span>FREE EXPRESS SHIPPING</span> on orders above ₹999</div>
                <div class="top-bar-item">⚡ <span>SEASON SALE</span> Up to 50% OFF on Men's & Women's Fashion</div>
                <div class="top-bar-item">🎁 <span>SPECIAL OFFER</span> Buy 2 Get 1 FREE on Accessories</div>

                <!-- Duplicated Group for seamless Right-to-Left infinite scrolling -->
                <div class="top-bar-item">⭐ <span>NEW COLLECTION ALERT!</span> Get 20% OFF on your first order. Use code: <span>NOVAFIT20</span></div>
                <div class="top-bar-item">🚀 <span>FREE EXPRESS SHIPPING</span> on orders above ₹999</div>
                <div class="top-bar-item">⚡ <span>SEASON SALE</span> Up to 50% OFF on Men's & Women's Fashion</div>
                <div class="top-bar-item">🎁 <span>SPECIAL OFFER</span> Buy 2 Get 1 FREE on Accessories</div>
            </div>
        </div>

        <!-- MAIN PROFILE LAYOUT -->
        <main class="profile-layout">

            <!-- LEFT SIDEBAR (WISHLIST STATS & SHORTCUTS) -->
            <aside class="profile-sidebar">

                <div class="user-card">

                    <div class="avatar-outer">
                        <div class="avatar-inner">
                            ❤️
                        </div>
                    </div>

                    <h2>My Wishlist</h2>
                    <p class="user-email" style="color:#c89b3c; font-weight:800;"><%= safe(userName) %></p>

                    <div class="user-pill-tag" style="margin-top:14px; background:rgba(200,155,60,0.15); color:#c89b3c; border:1px solid rgba(200,155,60,0.3); padding:8px 16px; border-radius:20px; font-weight:800; font-size:0.85rem; display:inline-block;">
                        <span class="nav-wishlist-badge">${sessionScope.wishlistCount != null ? sessionScope.wishlistCount : 0}</span> Saved Items
                    </div>

                </div>

                <!-- QUICK NAVIGATION BOX -->
                <div class="wishlist-shortcuts-card">
                    <h3 style="font-size:1.05rem; font-weight:800; margin-bottom:14px; color:#111;">Quick Shortcuts</h3>
                    
                    <a href="<%= contextPath %>/products" style="display:flex; align-items:center; gap:10px; color:#333; text-decoration:none; padding:10px 0; font-weight:700; border-bottom:1px solid #f4f4f4; transition:0.2s;">
                        <i class="fa-solid fa-plus" style="color:#c89b3c;"></i> Add More Items
                    </a>

                    <a href="<%= contextPath %>/cart" style="display:flex; align-items:center; gap:10px; color:#333; text-decoration:none; padding:10px 0; font-weight:700; border-bottom:1px solid #f4f4f4; transition:0.2s;">
                        <i class="fa-solid fa-cart-shopping" style="color:#c89b3c;"></i> View Shopping Bag
                    </a>

                    <a href="<%= contextPath %>/profile" style="display:flex; align-items:center; gap:10px; color:#333; text-decoration:none; padding:10px 0 0 0; font-weight:700; transition:0.2s;">
                        <i class="fa-solid fa-user" style="color:#c89b3c;"></i> Account Details
                    </a>
                </div>

            </aside>

            <!-- RIGHT MAIN CONTENT (WISHLIST ITEMS LIST) -->
            <section class="profile-main">

                <div class="wishlist-main-card">

                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:24px; border-bottom:2px solid #f4f4f4; padding-bottom:16px;">
                        <div>
                            <h2 style="font-size:1.6rem; font-weight:900; color:#111;">SAVED FAVORITES</h2>
                            <p style="font-size:0.9rem; color:#666; margin-top:4px;">Manage your saved products and transfer them to cart anytime.</p>
                        </div>
                        <div style="background:#fff0f3; color:#ff385c; padding:8px 18px; border-radius:30px; font-weight:800; font-size:0.85rem; border:1px solid rgba(255,56,92,0.2);">
                            💖 ${sessionScope.wishlistCount != null ? sessionScope.wishlistCount : 0} Items Saved
                        </div>
                    </div>

                    <% if (wishlistItems != null && !wishlistItems.isEmpty()) { %>
                        <div class="wishlist-grid-profile">
                            <%
                            for (Product product : wishlistItems) {
                                String imagePath = product.getImage();
                                if (imagePath == null || imagePath.trim().isEmpty()) {
                                    imagePath = "assets/images/products/default-product.jpg";
                                }
                                if (!imagePath.startsWith("http") && !imagePath.startsWith("/")) {
                                    imagePath = contextPath + "/" + imagePath;
                                }
                            %>
                                <div class="wishlist-item-card">
                                    <div class="wishlist-img-box">
                                        <img src="<%= imagePath %>" alt="<%= product.getName() %>">
                                    </div>
                                    <div class="wishlist-content">
                                        <div>
                                            <h3 class="wishlist-item-title"><%= product.getName() %></h3>
                                            <p class="wishlist-item-desc"><%= product.getDescription() %></p>
                                            <div class="wishlist-item-price">₹ <%= product.getPrice() %></div>
                                        </div>

                                        <div class="wishlist-item-actions">
                                            <form action="<%= contextPath %>/wishlist" method="post" style="flex:1;">
                                                <input type="hidden" name="action" value="moveToCart">
                                                <input type="hidden" name="productId" value="<%= product.getId() %>">
                                                <input type="hidden" name="quantity" value="1">
                                                <input type="hidden" name="size" value="M">
                                                <button type="submit" class="btn-profile-cart">
                                                    <i class="fa-solid fa-cart-shopping"></i> MOVE TO CART
                                                </button>
                                            </form>

                                            <form action="<%= contextPath %>/wishlist" method="post">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="productId" value="<%= product.getId() %>">
                                                <button type="submit" class="btn-profile-remove" title="Remove from Wishlist">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    <% } else { %>
                        <div class="empty-wishlist-profile">
                            <div class="empty-icon-profile">💖</div>
                            <h2 style="font-size:1.8rem; font-weight:900; color:#111; margin-bottom:10px;">Your Wishlist is Empty</h2>
                            <p style="color:#666; margin-bottom:28px; font-size:1rem;">You haven't saved any items to your wishlist yet. Explore our collections and tap the heart icon on any product!</p>
                            <a href="<%= contextPath %>/products" class="btn-profile-explore">EXPLORE PRODUCTS NOW →</a>
                        </div>
                    <% } %>

                </div>

            </section>

        </main>

    </div>

</section>

<jsp:include page="../partials/footer.jsp"/>

</body>
</html>
