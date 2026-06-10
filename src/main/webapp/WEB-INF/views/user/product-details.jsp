<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.fashionstore.model.Product" %>
<%@ page import="com.fashionstore.model.ProductSize" %>

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

    private String imagePath(String contextPath, String image) {
        if (image == null || image.trim().isEmpty()) {
            return contextPath + "/assets/images/products/default-product.jpg";
        }

        image = image.trim();

        if (image.startsWith("/")) {
            return contextPath + image;
        }

        if (image.startsWith("assets/")) {
            return contextPath + "/" + image;
        }

        return contextPath + "/assets/images/products/" + image;
    }
%>

<%
    String contextPath = request.getContextPath();

    Product product = (Product) request.getAttribute("product");
    List<ProductSize> sizes = (List<ProductSize>) request.getAttribute("sizes");

    if (product == null) {
        response.sendRedirect(contextPath + "/products");
        return;
    }

    String productImage = imagePath(contextPath, product.getImage());
    boolean hasSizes = sizes != null && !sizes.isEmpty();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= safe(product.getName()) %> - NOVAFIT Fashion Store</title>

<link rel="stylesheet" href="<%= contextPath %>/assets/css/product-details.css?v=10">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>

<body>

<jsp:include page="../partials/navbar.jsp"/>

<section class="product-details-page">

    <!-- BREADCRUMB -->
    <div class="details-breadcrumb">
        <a href="<%= contextPath %>/home">
            <i class="fa-solid fa-house"></i>
            Home
        </a>
        <span>/</span>
        <a href="<%= contextPath %>/products">Products</a>
        <span>/</span>
        <p><%= safe(product.getName()) %></p>
    </div>

    <!-- MAIN PRODUCT DETAILS -->
    <section class="details-shell">

        <!-- LEFT IMAGE GALLERY -->
        <div class="details-gallery">

            <div class="thumb-column">

                <div class="thumb-box active-thumb">
                    <img src="<%= productImage %>" alt="<%= safe(product.getName()) %>">
                </div>

                <div class="thumb-box">
                    <img src="<%= productImage %>" alt="<%= safe(product.getName()) %>">
                </div>

                <div class="thumb-box dark-thumb">
                    <i class="fa-solid fa-shirt"></i>
                    <span>NOVAFIT</span>
                </div>

                <div class="thumb-box fabric-thumb">
                    <i class="fa-solid fa-layer-group"></i>
                    <span>FABRIC</span>
                </div>

            </div>

            <div class="main-image-box">

                <img src="<%= productImage %>" alt="<%= safe(product.getName()) %>">

                <button type="button" class="expand-btn">
                    <i class="fa-solid fa-expand"></i>
                </button>

            </div>

        </div>

        <!-- RIGHT PRODUCT INFO -->
        <div class="details-info-card">

            <div class="product-category-line">
                <span>NovaFit Premium Collection</span>
                <p>In Stock</p>
            </div>

            <h1><%= safe(product.getName()) %></h1>

            <div class="rating-row">
                <div class="stars">
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star-half-stroke"></i>
                </div>
                <span>(24 Reviews)</span>
            </div>

            <p class="details-description">
                <%= safe(product.getDescription()) %>
            </p>

            <div class="details-divider"></div>

            <div class="price-row">
                <h2>₹<%= product.getPrice() %></h2>
                <span>Inclusive of all taxes</span>
            </div>

            <div class="details-divider"></div>

            <form action="<%= contextPath %>/add-to-cart" method="post" class="details-form">

                <input type="hidden" name="productId" value="<%= product.getId() %>">

                <div class="form-label-row">
                    <label>Select Size</label>
                    <a href="#">Size Guide <i class="fa-solid fa-ruler-horizontal"></i></a>
                </div>

                <div class="size-options">

                    <%
                        if (hasSizes) {
                            int index = 0;

                            for (ProductSize size : sizes) {
                    %>

                    <label class="size-box">
                        <input type="radio"
                               name="size"
                               value="<%= safe(size.getSize()) %>"
                               <%= index == 0 ? "checked" : "" %>
                               required>
                        <span><%= safe(size.getSize()) %></span>
                    </label>

                    <%
                                index++;
                            }
                        } else {
                    %>

                    <p class="no-size-text">
                        No size available for this product.
                    </p>

                    <%
                        }
                    %>

                </div>

                <label class="quantity-label">Quantity</label>

                <div class="quantity-control">
                    <button type="button" onclick="decreaseQty()">−</button>

                    <input type="number"
                           name="quantity"
                           id="quantityInput"
                           value="1"
                           min="1"
                           readonly>

                    <button type="button" onclick="increaseQty()">+</button>
                </div>

                <div class="details-actions">

                    <button type="submit"
                            class="add-cart-btn"
                            <%= hasSizes ? "" : "disabled" %>>
                        <i class="fa-solid fa-cart-shopping"></i>
                        Add to Cart
                    </button>

                    <a href="#" class="wishlist-btn">
                        <i class="fa-regular fa-heart"></i>
                        Add to Wishlist
                    </a>

                </div>

            </form>

            <div class="trust-row">

                <div class="trust-box">
                    <i class="fa-solid fa-shield-halved"></i>
                    <div>
                        <h4>100% Original</h4>
                        <p>Authentic Products</p>
                    </div>
                </div>

                <div class="trust-box">
                    <i class="fa-solid fa-rotate-left"></i>
                    <div>
                        <h4>Easy Returns</h4>
                        <p>Within 7 days</p>
                    </div>
                </div>

                <div class="trust-box">
                    <i class="fa-solid fa-truck"></i>
                    <div>
                        <h4>Free Shipping</h4>
                        <p>Orders above ₹999</p>
                    </div>
                </div>

            </div>

        </div>

    </section>

    <!-- PRODUCT EXTRA DETAILS -->
    <section class="product-extra-card">

        <div class="extra-tabs">
            <button class="active-tab">Description</button>
            <button>Product Details</button>
            <button>Reviews </button>
            <button>Delivery & Returns</button>
        </div>

        <div class="extra-content">

            <p>
                <%= safe(product.getDescription()) %>
            </p>

            <div class="extra-grid">

                <div class="extra-box">
                    <i class="fa-solid fa-shirt"></i>
                    <h4>Premium Fabric</h4>
                    <p>Designed for comfort, durability and everyday style.</p>
                </div>

                <div class="extra-box">
                    <i class="fa-solid fa-award"></i>
                    <h4>Quality Checked</h4>
                    <p>Every product is verified before listing.</p>
                </div>

                <div class="extra-box">
                    <i class="fa-solid fa-lock"></i>
                    <h4>Secure Checkout</h4>
                    <p>Your payment and account details are safe.</p>
                </div>

            </div>

        </div>

    </section>

</section>

<jsp:include page="../partials/footer.jsp"/>

<script>
    function increaseQty() {
        const qtyInput = document.getElementById("quantityInput");
        qtyInput.value = parseInt(qtyInput.value) + 1;
    }

    function decreaseQty() {
        const qtyInput = document.getElementById("quantityInput");
        const currentValue = parseInt(qtyInput.value);

        if (currentValue > 1) {
            qtyInput.value = currentValue - 1;
        }
    }
</script>

</body>
</html>