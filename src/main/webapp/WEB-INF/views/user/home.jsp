<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.fashionstore.model.Product"%>

<%
    boolean isLoggedInHome = session.getAttribute("userId") != null;
    if (isLoggedInHome && session.getAttribute("wishlistCount") == null) {
        try {
            int userId = (Integer) session.getAttribute("userId");
            com.fashionstore.dao.WishlistDAO navWishlistDAO = new com.fashionstore.dao.impl.WishlistDAOImpl();
            session.setAttribute("wishlistCount", navWishlistDAO.getWishlistCount(userId));
        } catch (Exception e) {
            session.setAttribute("wishlistCount", 0);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>NOVAFIT Fashion Store</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/home.css?v=2042">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* --- Top Offer Bar Right-to-Left Marquee Animation --- */
.top-bar {
    width: 100%;
    background: #111111;
    color: #ffffff;
    height: 42px;
    display: flex;
    align-items: center;
    overflow: hidden;
    position: relative;
    border-bottom: 1px solid rgba(200, 155, 60, 0.35);
    font-family: 'Roboto', sans-serif;
    font-size: 0.88rem;
    font-weight: 600;
}
.top-bar-marquee {
    display: flex;
    gap: 60px;
    white-space: nowrap;
    width: max-content;
    animation: top-bar-scroll 25s linear infinite;
}
.top-bar-marquee:hover {
    animation-play-state: paused;
}
@keyframes top-bar-scroll {
    0% { transform: translateX(0); }
    100% { transform: translateX(-50%); }
}
.top-bar-item {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    color: #f5f5f5;
}
.top-bar-item span {
    color: #c89b3c;
    font-weight: 800;
}

/* --- Circular Product Marquee Section --- */
.inspiration-section {
    padding: 50px 0 35px 0;
    background: #ffffff;
    overflow: hidden;
    text-align: center;
    border-bottom: 1px solid #f0f0f0;
}
.inspiration-section h2 {
    font-family: 'Montserrat', sans-serif;
    font-size: 2.2rem;
    font-weight: 800;
    letter-spacing: 1px;
    color: #111;
    margin-bottom: 8px;
    text-transform: uppercase;
}
.inspiration-section .section-line {
    width: 70px;
    height: 4px;
    background: #ff385c;
    margin: 0 auto 35px auto;
    border-radius: 2px;
}
.inspiration-carousel {
    width: 100%;
    overflow: hidden;
    padding: 15px 0 25px 0;
    position: relative;
}
.inspiration-track {
    display: flex;
    gap: 35px;
    width: max-content;
    animation: inspiration-scroll 35s linear infinite;
}
.inspiration-track:hover {
    animation-play-state: paused;
}
@keyframes inspiration-scroll {
    0% { transform: translateX(0); }
    100% { transform: translateX(-50%); }
}
.inspiration-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
    min-width: 130px;
    max-width: 140px;
    text-decoration: none;
    color: #222;
    transition: transform 0.3s ease;
}
.inspiration-item:hover {
    transform: translateY(-8px);
}
.inspiration-circle {
    width: 130px;
    height: 130px;
    border-radius: 50%;
    overflow: hidden;
    border: 4px solid #f0f0f0;
    box-shadow: 0 6px 18px rgba(0,0,0,0.08);
    transition: all 0.3s ease;
    background: #fafafa;
}
.inspiration-item:hover .inspiration-circle {
    border-color: #ff385c;
    box-shadow: 0 12px 30px rgba(255, 56, 92, 0.3);
    transform: scale(1.05);
}
.inspiration-circle img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.4s ease;
}
.inspiration-item:hover .inspiration-circle img {
    transform: scale(1.1);
}
.inspiration-name {
    font-size: 0.95rem;
    font-weight: 700;
    font-family: 'Roboto', sans-serif;
    color: #222;
    text-align: center;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    width: 100%;
}
</style>

</head>

<body>

<!-- Top Offer Bar (Right-to-Left Marquee Motion) -->
<div class="top-bar">
    <div class="top-bar-marquee">
        <!-- Item Group 1 -->
        <div class="top-bar-item">⭐ <span>NEW COLLECTION ALERT!</span> Get 20% OFF on your first order. Use code: <span>NOVAFIT20</span></div>
        <div class="top-bar-item">🚀 <span>FREE EXPRESS SHIPPING</span> on orders above ₹999</div>
        <div class="top-bar-item">⚡ <span>SEASON SALE</span> Up to 50% OFF on Men's & Women's Fashion</div>
        <div class="top-bar-item">🎁 <span>SPECIAL OFFER</span> Buy 2 Get 1 FREE on Accessories</div>

        <!-- Duplicated for seamless Right-to-Left infinite scrolling -->
        <div class="top-bar-item">⭐ <span>NEW COLLECTION ALERT!</span> Get 20% OFF on your first order. Use code: <span>NOVAFIT20</span></div>
        <div class="top-bar-item">🚀 <span>FREE EXPRESS SHIPPING</span> on orders above ₹999</div>
        <div class="top-bar-item">⚡ <span>SEASON SALE</span> Up to 50% OFF on Men's & Women's Fashion</div>
        <div class="top-bar-item">🎁 <span>SPECIAL OFFER</span> Buy 2 Get 1 FREE on Accessories</div>
    </div>
</div>

<!-- Navbar -->
<header class="main-navbar">

    <div class="logo">
        NOVA<span>FIT</span>
        <small>FASHION STORE</small>
    </div>

    <nav class="nav-menu">
        <a href="<%= request.getContextPath() %>/home" class="active">HOME</a>
        <a href="<%= request.getContextPath() %>/products?categoryId=1">MEN</a>
        <a href="<%= request.getContextPath() %>/products?categoryId=2">WOMEN</a>
        <a href="<%= request.getContextPath() %>/products?categoryId=3">KIDS</a>
        <a href="<%= request.getContextPath() %>/products?categoryId=4">FOOTWEAR</a>
        <a href="<%= request.getContextPath() %>/products?categoryId=5">ACCESSORIES</a>
        <a href="<%= request.getContextPath() %>/products">NEW ARRIVALS</a>
    </nav>

    <div class="nav-right">

        <form action="<%= request.getContextPath() %>/products" method="get" class="search-box">
            <input type="text" name="keyword" placeholder="Search products...">
            <button type="submit">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
        </form>

        <a href="<%= request.getContextPath() %>/<%= isLoggedInHome ? "profile" : "login" %>" class="nav-icon" title="Account">
            <i class="fa-regular fa-user"></i>
        </a>

        <a href="<%= request.getContextPath() %>/wishlist" class="cart-icon" title="Wishlist">
            <i class="fa-solid fa-heart" style="color: #ff385c;"></i>
            <span class="nav-wishlist-badge">${sessionScope.wishlistCount != null ? sessionScope.wishlistCount : 0}</span>
        </a>

        <a href="<%= request.getContextPath() %>/cart" class="cart-icon" title="Cart">
            <i class="fa-solid fa-cart-shopping"></i>
            <span class="nav-cart-badge">${sessionScope.globalCartItemCount != null ? sessionScope.globalCartItemCount : 0}</span>
        </a>
    </div>
</header>

<!-- Hero Section -->
<section class="hero-section"
    style="
        background-image: url('<%= request.getContextPath() %>/assets/images/hero back.png');
        background-repeat: no-repeat;
        background-size: 100% 100%;
        background-position: center center;
    ">

    <div class="hero-content">
        <p class="season-text">NEW SEASON</p>

        <h1>
            FIND YOUR <br>
            <span>TRUE STYLE</span>
        </h1>

        <p class="hero-desc">
            Explore the latest collections of fashion-forward<br>
            clothing, footwear and accessories.
        </p>

        <a href="<%= request.getContextPath() %>/products" class="hero-btn">
            SHOP NOW <i class="fa-solid fa-arrow-right"></i>
        </a>
    </div>

    <!-- Right Side People Image -->
    <div class="hero-image">
        <img src="<%= request.getContextPath() %>/assets/images/hero-fashion.png"
             alt="NovaFit Fashion Models">
    </div>

</section>

<!-- Service Features -->
<section class="service-section">

    <div class="service-box">
        <i class="fa-solid fa-truck"></i>
        <div>
            <h4>FREE SHIPPING</h4>
            <p>On orders above ₹999</p>
        </div>
    </div>

    <div class="service-box">
        <i class="fa-solid fa-rotate-left"></i>
        <div>
            <h4>EASY RETURNS</h4>
            <p>Within 7 days</p>
        </div>
    </div>

    <div class="service-box">
        <i class="fa-solid fa-shield-halved"></i>
        <div>
            <h4>100% SECURE</h4>
            <p>Safe & secure payments</p>
        </div>
    </div>

    <div class="service-box">
        <i class="fa-solid fa-headset"></i>
        <div>
            <h4>24/7 SUPPORT</h4>
            <p>We're here to help</p>
        </div>
    </div>

</section>

<!-- Inspiration For Your First Order Section (Top 15 Random Items Marquee) -->
<section class="inspiration-section">
    <h2>INSPIRATION FOR YOUR LOOK</h2>
    <div class="section-line"></div>

    <%
    List<Product> carouselProducts = (List<Product>) request.getAttribute("carouselProducts");
    if (carouselProducts == null || carouselProducts.isEmpty()) {
        try {
            List<Product> allProds = new com.fashionstore.dao.impl.ProductDAOImpl().getAllProducts();
            if (allProds != null && !allProds.isEmpty()) {
                java.util.Collections.shuffle(allProds);
                carouselProducts = allProds.subList(0, Math.min(15, allProds.size()));
            }
        } catch(Exception e) {}
    }
    if (carouselProducts != null && !carouselProducts.isEmpty()) {
    %>
    <div class="inspiration-carousel">
        <div class="inspiration-track">
            <!-- Original Items -->
            <% for (Product p : carouselProducts) { 
                String imgPath = p.getImage();
                if (imgPath == null || imgPath.trim().isEmpty()) {
                    imgPath = "assets/images/mens.png";
                }
                if (!imgPath.startsWith("http") && !imgPath.startsWith("/")) {
                    imgPath = request.getContextPath() + "/" + imgPath;
                }
            %>
            <a href="<%= request.getContextPath() %>/product-details?id=<%= p.getId() %>" class="inspiration-item">
                <div class="inspiration-circle">
                    <img src="<%= imgPath %>" alt="<%= p.getName() %>">
                </div>
                <span class="inspiration-name"><%= p.getName() %></span>
            </a>
            <% } %>

            <!-- Duplicated for seamless infinite marquee scroll -->
            <% for (Product p : carouselProducts) { 
                String imgPath = p.getImage();
                if (imgPath == null || imgPath.trim().isEmpty()) {
                    imgPath = "assets/images/mens.png";
                }
                if (!imgPath.startsWith("http") && !imgPath.startsWith("/")) {
                    imgPath = request.getContextPath() + "/" + imgPath;
                }
            %>
            <a href="<%= request.getContextPath() %>/product-details?id=<%= p.getId() %>" class="inspiration-item">
                <div class="inspiration-circle">
                    <img src="<%= imgPath %>" alt="<%= p.getName() %>">
                </div>
                <span class="inspiration-name"><%= p.getName() %></span>
            </a>
            <% } %>
        </div>
    </div>
    <% } %>
</section>

<!-- Category Section -->
<section class="category-section">

    <h2>SHOP BY CATEGORY</h2>
    <div class="section-line"></div>

    <div class="category-grid">

        <a href="<%= request.getContextPath() %>/products?categoryId=1" class="category-card">
            <img src="<%= request.getContextPath() %>/assets/images/mens.png" alt="Men">
            <div class="category-content">
                <h3>MEN</h3>
                <button>SHOP NOW</button>
            </div>
        </a>

        <a href="<%= request.getContextPath() %>/products?categoryId=2" class="category-card">
            <img src="<%= request.getContextPath() %>/assets/images/women.png" alt="Women">
            <div class="category-content">
                <h3>WOMEN</h3>
                <button>SHOP NOW</button>
            </div>
        </a>

        <a href="<%= request.getContextPath() %>/products?categoryId=4" class="category-card">
            <img src="<%= request.getContextPath() %>/assets/images/footwear.png" alt="Footwear">
            <div class="category-content">
                <h3>FOOTWEAR</h3>
                <button>SHOP NOW</button>
            </div>
        </a>

        <a href="<%= request.getContextPath() %>/products?categoryId=5" class="category-card">
            <img src="<%= request.getContextPath() %>/assets/images/accessories.png" alt="Accessories">
            <div class="category-content">
                <h3>ACCESSORIES</h3>
                <button>SHOP NOW</button>
            </div>
        </a>

    </div>

</section>

<!-- Bottom Promo Cards -->
<section class="bottom-cards">

    <div class="info-card">
        <i class="fa-regular fa-star"></i>
        <h3>NEW ARRIVALS</h3>
        <p>Latest fashion styles added for this season.</p>
    </div>

    <div class="info-card">
        <i class="fa-solid fa-crown"></i>
        <h3>BEST SELLERS</h3>
        <p>Shop the most loved products by our customers.</p>
    </div>

    <div class="info-card">
        <i class="fa-solid fa-gift"></i>
        <h3>SPECIAL OFFERS</h3>
        <p>Get amazing deals on selected fashion items.</p>
    </div>

</section>

<jsp:include page="../partials/footer.jsp"/>

</body>
</html>