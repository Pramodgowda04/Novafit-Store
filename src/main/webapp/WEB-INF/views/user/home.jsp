<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NOVAFIT Fashion Store</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/home.css?v=2042">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>

<body>

<!-- Top Offer Bar -->
<div class="top-bar">
    <div>
        ⭐ NEW COLLECTION ALERT! Get 20% OFF on your first order.
        Use code: <span>NOVAFIT20</span>
    </div>

    <div class="top-links">
        <a href="<%= request.getContextPath() %>/orders">Track Order</a>
        <span>|</span>
        <a href="mailto:Pramodgowda7377@gmail.com">Help & Support</a>
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

        <a href="<%= request.getContextPath() %>/login" class="nav-icon">
            <i class="fa-regular fa-user"></i>
        </a>

        <a href="#" class="nav-icon">
            <i class="fa-regular fa-heart"></i>
        </a>

        <a href="<%= request.getContextPath() %>/cart" class="cart-icon">
            <i class="fa-solid fa-cart-shopping"></i>
            <span>${globalCartItemCount != null ? globalCartItemCount : 0}</span>
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