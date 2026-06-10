<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.fashionstore.model.Product" %>

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

    String categoryId = request.getParameter("categoryId");
    String keyword = request.getParameter("keyword");
    String minPrice = request.getParameter("minPrice");
    String maxPrice = request.getParameter("maxPrice");
    String sort = request.getParameter("sort");

    if (keyword == null) keyword = "";
    if (minPrice == null) minPrice = "";
    if (maxPrice == null) maxPrice = "";
    if (sort == null) sort = "newest";

    boolean isLoggedIn = session.getAttribute("userId") != null;

    String loggedUserName = (String) session.getAttribute("userName");
    if (loggedUserName == null || loggedUserName.trim().isEmpty()) {
        loggedUserName = "NovaFit User";
    }

    int navCartCount = 0;
    Object cartCountObj = session.getAttribute("cartCount");

    if (cartCountObj != null) {
        try {
            navCartCount = Integer.parseInt(cartCountObj.toString());
        } catch (Exception e) {
            navCartCount = 0;
        }
    }

    String pageTitle = "ALL PRODUCTS";
    String pageSubTitle = "Explore the latest NovaFit fashion collection";

    if ("1".equals(categoryId)) {
        pageTitle = "MEN'S COLLECTION";
        pageSubTitle = "Premium styles designed for modern men";
    } else if ("2".equals(categoryId)) {
        pageTitle = "WOMEN'S COLLECTION";
        pageSubTitle = "Elegant fashion crafted for every occasion";
    } else if ("3".equals(categoryId)) {
        pageTitle = "KIDS COLLECTION";
        pageSubTitle = "Comfortable and stylish fashion for kids";
    } else if ("4".equals(categoryId)) {
        pageTitle = "FOOTWEAR COLLECTION";
        pageSubTitle = "Step into comfort, confidence and style";
    } else if ("5".equals(categoryId)) {
        pageTitle = "ACCESSORIES COLLECTION";
        pageSubTitle = "Complete your look with premium accessories";
    }

    List<Product> products = (List<Product>) request.getAttribute("products");
    int productCount = products == null ? 0 : products.size();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= pageTitle %> - NOVAFIT Fashion Store</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/product.css?v=1001">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>

<body>

<!-- TOP OFFER BAR -->
<div class="top-bar">
    <div>
        <i class="fa-solid fa-bolt"></i>
        NEW COLLECTION ALERT! Get 20% OFF on your first order.
        Use code: <span>NOVAFIT20</span>
    </div>

    <div class="top-links">
        <a href="<%= contextPath %>/orders">Track Order</a>
        <span>||</span>
        <a href="mailto:Pramodgowda7377@gmail.com">Help & Support</a>
    </div>
</div>

<!-- NAVBAR -->
<header class="main-navbar">

    <a href="<%= contextPath %>/home" class="logo">
        NOVA<span>FIT</span>
        <small>FASHION STORE</small>
    </a>

    <nav class="nav-menu">
        <a href="<%= contextPath %>/home">HOME</a>

        <a href="<%= contextPath %>/products?categoryId=1"
           class="<%= "1".equals(categoryId) ? "active" : "" %>">
            MEN
        </a>

        <a href="<%= contextPath %>/products?categoryId=2"
           class="<%= "2".equals(categoryId) ? "active" : "" %>">
            WOMEN
        </a>

        <a href="<%= contextPath %>/products?categoryId=3"
           class="<%= "3".equals(categoryId) ? "active" : "" %>">
            KIDS
        </a>

        <a href="<%= contextPath %>/products?categoryId=4"
           class="<%= "4".equals(categoryId) ? "active" : "" %>">
            FOOTWEAR
        </a>

        <a href="<%= contextPath %>/products?categoryId=5"
           class="<%= "5".equals(categoryId) ? "active" : "" %>">
            ACCESSORIES
        </a>

        <a href="<%= contextPath %>/products"
           class="<%= categoryId == null ? "active" : "" %>">
            NEW ARRIVALS
        </a>
    </nav>

    <div class="nav-right">

        <form action="<%= contextPath %>/products" method="get" class="search-box">
            <input type="text" name="keyword" placeholder="Search products..." value="<%= safe(keyword) %>">
            <button type="submit">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
        </form>

        <a href="<%= contextPath %>/<%= isLoggedIn ? "profile" : "login" %>" class="nav-icon">
            <i class="fa-regular fa-user"></i>
        </a>

        <a href="<%= contextPath %>/<%= isLoggedIn ? "profile" : "login" %>" class="nav-icon">
            <i class="fa-regular fa-heart"></i>
        </a>

        <a href="<%= contextPath %>/cart" class="cart-icon">
            <i class="fa-solid fa-cart-shopping"></i>
            <span>${globalCartItemCount != null ? globalCartItemCount : 0}</span>
        </a>

        <% if (isLoggedIn) { %>
            <a href="<%= contextPath %>/profile" class="user-pill">
                Hi, <%= safe(loggedUserName) %>
            </a>

            <a href="<%= contextPath %>/logout" class="logout-btn">
                Logout
            </a>
        <% } else { %>
            <a href="<%= contextPath %>/login" class="logout-btn">
                Login
            </a>
        <% } %>

    </div>

</header>

<!-- HERO -->
<section class="products-hero">

    <div class="products-hero-content">
        <p class="season-text">NOVAFIT COLLECTION</p>

        <h1><%= pageTitle %></h1>

        <p><%= pageSubTitle %></p>

        <div class="hero-mini-actions">
            <a href="<%= contextPath %>/home" class="outline-btn">
                <i class="fa-solid fa-arrow-left"></i>
                BACK HOME
            </a>

            <a href="#productsArea" class="dark-btn">
                EXPLORE NOW
                <i class="fa-solid fa-arrow-down"></i>
            </a>
        </div>
    </div>

</section>

<!-- SERVICE FEATURES -->
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

<!-- PRODUCTS PAGE -->
<section class="products-page" id="productsArea">

    <div class="products-header">
        <p class="small-heading">SHOP THE LOOK</p>
        <h2>DISCOVER PREMIUM FASHION</h2>
        <div class="section-line"></div>
        <p class="header-desc">
            Browse handpicked products from NovaFit's latest collection.
        </p>
    </div>

    <!-- CATEGORY PILLS -->
    <div class="category-pills">

        <a href="<%= contextPath %>/products"
           class="<%= categoryId == null ? "active-pill" : "" %>">
            All
        </a>

        <a href="<%= contextPath %>/products?categoryId=1"
           class="<%= "1".equals(categoryId) ? "active-pill" : "" %>">
            Men
        </a>

        <a href="<%= contextPath %>/products?categoryId=2"
           class="<%= "2".equals(categoryId) ? "active-pill" : "" %>">
            Women
        </a>

        <a href="<%= contextPath %>/products?categoryId=3"
           class="<%= "3".equals(categoryId) ? "active-pill" : "" %>">
            Kids
        </a>

        <a href="<%= contextPath %>/products?categoryId=4"
           class="<%= "4".equals(categoryId) ? "active-pill" : "" %>">
            Footwear
        </a>

        <a href="<%= contextPath %>/products?categoryId=5"
           class="<%= "5".equals(categoryId) ? "active-pill" : "" %>">
            Accessories
        </a>

    </div>

    <div class="products-layout">

        <!-- FILTER SIDEBAR -->
        <aside class="filter-sidebar">

            <div class="filter-title">
                <i class="fa-solid fa-sliders"></i>
                <h3>FILTERS</h3>
            </div>

            <!-- SEARCH FILTER -->
            <form action="<%= contextPath %>/products" method="get" class="filter-form">

                <% if (categoryId != null) { %>
                    <input type="hidden" name="categoryId" value="<%= safe(categoryId) %>">
                <% } %>

                <label>Search Product</label>

                <div class="filter-input-icon">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text"
                           name="keyword"
                           placeholder="T-shirt, shoes, watch..."
                           value="<%= safe(keyword) %>">
                </div>

                <button type="submit">
                    SEARCH PRODUCT
                </button>

            </form>

            <!-- PRICE FILTER -->
            <form action="<%= contextPath %>/products" method="get" class="filter-form">

                <% if (categoryId != null) { %>
                    <input type="hidden" name="categoryId" value="<%= safe(categoryId) %>">
                <% } %>

                <% if (!keyword.trim().isEmpty()) { %>
                    <input type="hidden" name="keyword" value="<%= safe(keyword) %>">
                <% } %>

                <label>Price Range</label>

                <div class="price-row">
                    <input type="number"
                           name="minPrice"
                           placeholder="Min"
                           value="<%= safe(minPrice) %>">

                    <input type="number"
                           name="maxPrice"
                           placeholder="Max"
                           value="<%= safe(maxPrice) %>">
                </div>

                <button type="submit">
                    APPLY PRICE
                </button>

            </form>

            <div class="filter-offer-box">
                <i class="fa-solid fa-gift"></i>
                <h4>Special Offer</h4>
                <p>Order Now <span>UNLOCK</span> The Excited Offers</p>
            </div>

        </aside>

        <!-- PRODUCTS CONTENT -->
        <div class="products-content">

            <div class="products-top">

                <div>
                    <h3>Latest Products</h3>
                    <p>
                        Showing <%= productCount %> product<%= productCount == 1 ? "" : "s" %>
                    </p>
                </div>

                <form action="<%= contextPath %>/products" method="get" class="sort-form">

                    <% if (categoryId != null) { %>
                        <input type="hidden" name="categoryId" value="<%= safe(categoryId) %>">
                    <% } %>

                    <% if (!keyword.trim().isEmpty()) { %>
                        <input type="hidden" name="keyword" value="<%= safe(keyword) %>">
                    <% } %>

                    <% if (!minPrice.trim().isEmpty()) { %>
                        <input type="hidden" name="minPrice" value="<%= safe(minPrice) %>">
                    <% } %>

                    <% if (!maxPrice.trim().isEmpty()) { %>
                        <input type="hidden" name="maxPrice" value="<%= safe(maxPrice) %>">
                    <% } %>

                    <select name="sort" onchange="this.form.submit()">
                        <option value="newest" <%= "newest".equals(sort) ? "selected" : "" %>>Newest First</option>
                        <option value="low-high" <%= "low-high".equals(sort) ? "selected" : "" %>>Price Low to High</option>
                        <option value="high-low" <%= "high-low".equals(sort) ? "selected" : "" %>>Price High to Low</option>
                        <option value="popular" <%= "popular".equals(sort) ? "selected" : "" %>>Most Popular</option>
                    </select>

                </form>

            </div>

            <div class="product-grid">

                <%
                    if (products != null && !products.isEmpty()) {

                        for (Product product : products) {

                            String imagePath = product.getImage();

                            if (imagePath == null || imagePath.trim().isEmpty()) {
                                imagePath = "assets/images/products/default-product.jpg";
                            }

                            if (imagePath.startsWith("/")) {
                                imagePath = contextPath + imagePath;
                            } else {
                                imagePath = contextPath + "/" + imagePath;
                            }
                %>

                <div class="product-card">

                    <div class="product-image">

                        <img src="<%= imagePath %>"
                             alt="<%= safe(product.getName()) %>">

                        <span class="product-badge">NEW</span>

                        <a href="<%= contextPath %>/<%= isLoggedIn ? "profile" : "login" %>" class="wishlist-btn">
                            <i class="fa-regular fa-heart"></i>
                        </a>

                    </div>

                    <div class="product-info">

                        <div class="rating">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-regular fa-star"></i>
                            <span>(24)</span>
                        </div>

                        <h3><%= safe(product.getName()) %></h3>

                        <p class="description">
                            <%= safe(product.getDescription()) %>
                        </p>

                        <div class="price-row-card">
                            <p class="price">₹ <%= product.getPrice() %></p>
                            <span>Inclusive of taxes</span>
                        </div>

                        <div class="product-actions">

                            <a class="view-btn"
                               href="<%= contextPath %>/product-details?id=<%= product.getId() %>">
                                VIEW DETAILS
                            </a>

                            <!-- FIXED ADD TO CART FORM -->
                            <form action="<%= contextPath %>/add-to-cart" method="post">
                                <input type="hidden" name="productId" value="<%= product.getId() %>">
                                <input type="hidden" name="quantity" value="1">
                                <input type="hidden" name="size" value="M">

                                <button type="submit" class="cart-btn">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                </button>
                            </form>

                        </div>

                    </div>

                </div>

                <%
                        }

                    } else {
                %>

                <div class="no-products">

                    <i class="fa-solid fa-box-open"></i>

                    <h2>No Products Found</h2>

                    <p>
                        We could not find products for your selected filter.
                        Try another category or search keyword.
                    </p>

                    <a href="<%= contextPath %>/products" class="dark-btn">
                        VIEW ALL PRODUCTS
                    </a>

                </div>

                <%
                    }
                %>

            </div>

        </div>

    </div>

</section>

<!-- BOTTOM PROMO CARDS -->
<section class="nf-products-benefits">

    <div class="nf-benefit-card">
        <div class="nf-benefit-icon">
            <i class="fa-regular fa-star"></i>
        </div>

        <div>
            <h3>New Arrivals</h3>
            <p>Latest fashion styles added for this season.</p>
        </div>
    </div>

    <div class="nf-benefit-card">
        <div class="nf-benefit-icon">
            <i class="fa-solid fa-crown"></i>
        </div>

        <div>
            <h3>Best Sellers</h3>
            <p>Shop the most loved products by our customers.</p>
        </div>
    </div>

    <div class="nf-benefit-card">
        <div class="nf-benefit-icon">
            <i class="fa-solid fa-gift"></i>
        </div>

        <div>
            <h3>Special Offers</h3>
            <p>Get amazing deals on selected fashion items.</p>
        </div>
    </div>

</section>

<jsp:include page="../partials/footer.jsp"/>

</body>
</html>