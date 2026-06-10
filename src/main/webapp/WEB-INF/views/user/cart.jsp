<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.fashionstore.model.CartItem" %>



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

    List<CartItem> cartItems =
            (List<CartItem>) request.getAttribute("cartItems");

    int cartCount = 0;
    int totalQuantity = 0;

    if (cartItems != null) {
        cartCount = cartItems.size();

        for (CartItem item : cartItems) {
            totalQuantity += item.getQuantity();
        }
        session.setAttribute("cartCount", totalQuantity);
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Cart - NOVAFIT Fashion Store</title>

<link rel="stylesheet" href="<%= contextPath %>/assets/css/style.css">
<link rel="stylesheet" href="<%= contextPath %>/assets/css/cart.css?v=13">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>

<body>

<jsp:include page="../partials/navbar.jsp"/>

<section class="cart-page">

    <!-- HERO SECTION -->
    <section class="cart-hero">

        <div class="cart-hero-content">

            <p class="cart-mini-title">
                SHOPPING BAG
                <span></span>
            </p>

            <h1>
                Your <span>NovaFit</span> Cart
            </h1>

            <p class="cart-hero-desc">
                Review your selected products, check quantities, remove unwanted items,
                and continue to secure checkout.
            </p>

            <div class="cart-hero-buttons">
                <a href="<%= contextPath %>/products" class="gold-btn">
                    <i class="fa-solid fa-arrow-left"></i>
                    Continue Shopping
                </a>

                <a href="#cartItemsArea" class="outline-gold-btn">
                    View Cart Items
                    <i class="fa-solid fa-arrow-down"></i>
                </a>
            </div>

        </div>

        <div class="cart-hero-icon">
            <div class="cart-ring ring-one"></div>
            <div class="cart-icon">
              <i class="fa-solid fa-cart-shopping"></i>
              <span>${globalCartItemCount != null ? globalCartItemCount : 0}</span>
          </div>

        <div class="cart-dot-pattern"></div>

    </section>

    <!-- SERVICE STRIP -->
    <section class="cart-service-strip">

        <div class="cart-service-box">
            <div class="service-icon">
                <i class="fa-solid fa-truck"></i>
            </div>
            <div>
                <h4>FREE SHIPPING</h4>
                <p>On orders above ₹999</p>
            </div>
        </div>

        <div class="cart-service-box">
            <div class="service-icon">
                <i class="fa-solid fa-rotate-left"></i>
            </div>
            <div>
                <h4>EASY RETURNS</h4>
                <p>Within 7 days</p>
            </div>
        </div>

        <div class="cart-service-box">
            <div class="service-icon">
                <i class="fa-solid fa-shield-halved"></i>
            </div>
            <div>
                <h4>SECURE CHECKOUT</h4>
                <p>Safe & protected payments</p>
            </div>
        </div>

    </section>

    <!-- CART MAIN AREA -->
    <section class="cart-main" id="cartItemsArea">

        <%
            if (cartItems != null && !cartItems.isEmpty()) {
        %>

        <div class="cart-layout">

            <!-- LEFT CART ITEMS -->
            <div class="cart-items-card">

                <div class="section-title-row">
                    <div>
                        <p class="small-gold-text">MY BAG</p>
                        <h2>
                            Cart Items
                            <span>(<%= cartCount %> item<%= cartCount == 1 ? "" : "s" %>)</span>
                        </h2>
                    </div>

                    <div class="bag-icon">
                        <i class="fa-solid fa-bag-shopping"></i>
                    </div>
                </div>

                <div class="cart-items-list">

                    <%
                        int slNo = 1;

                        for (CartItem item : cartItems) {
                    %>

                    <div class="cart-item">

                        <div class="item-image-box">
                            <div class="item-number"><%= slNo %></div>
                            <i class="fa-solid fa-shirt"></i>
                        </div>

                        <div class="item-details">

                            <h3>Product ID: <%= item.getProductId() %></h3>

                            <div class="item-meta">
                                <span>
                                    Size:
                                    <strong><%= safe(item.getSize()) %></strong>
                                </span>

                                <span>
                                    Quantity:
                                    <strong><%= item.getQuantity() %></strong>
                                </span>
                            </div>

                            <p>
                                Premium NovaFit product added to your shopping bag.
                                Review this item before checkout.
                            </p>

                        </div>

                        <div class="item-actions">

                            <a href="<%= contextPath %>/product-details?id=<%= item.getProductId() %>"
                               class="view-btn">
                                <i class="fa-regular fa-eye"></i>
                                View Product
                            </a>

                            <a href="<%= contextPath %>/remove-cart-item?id=<%= item.getId() %>"
                               class="remove-btn"
                               onclick="return confirm('Are you sure you want to remove this item from cart?');">
                                <i class="fa-solid fa-trash"></i>
                                Remove
                            </a>

                        </div>

                    </div>

                    <%
                            slNo++;
                        }
                    %>

                </div>

                <div class="cart-good-box">
                    <div class="cart-good-icon">
                        <i class="fa-solid fa-cart-plus"></i>
                    </div>

                    <div>
                        <h3>Your cart is looking good!</h3>
                        <p>Add more premium pieces to complete your NovaFit look.</p>
                    </div>

                    <a href="<%= contextPath %>/products">
                        Explore Collection
                        <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>

            </div>

            <!-- RIGHT SUMMARY -->

            <aside class="cart-summary-card">

                <div class="summary-title">
                    <i class="fa-regular fa-rectangle-list"></i>
                    <h2>Cart Summary</h2>
                </div>

                <div class="summary-line"></div>

                <div class="summary-row">
                    <span>Total Cart Items</span>
                    <strong><%= cartCount %></strong>
                </div>

                <div class="summary-row">
                    <span>Total Quantity</span>
                    <strong><%= totalQuantity %></strong>
                </div>

                <div class="summary-row">
                    <span>Delivery</span>
                    <strong class="available-text">Available</strong>
                </div>

                <%
                    java.math.BigDecimal cartTotalVal =
                        (java.math.BigDecimal) request.getAttribute("cartTotal");

                    java.math.BigDecimal discountAmount =
                        (java.math.BigDecimal) session.getAttribute("discountAmount");

                    java.math.BigDecimal finalAmount =
                        (java.math.BigDecimal) session.getAttribute("finalAmount");

                    String appliedCouponCode =
                        (String) session.getAttribute("appliedCouponCode");

                    if (cartTotalVal == null) {
                        cartTotalVal = java.math.BigDecimal.ZERO;
                    }

                    if (discountAmount == null) {
                        discountAmount = java.math.BigDecimal.ZERO;
                    }

                    boolean isAboveMinimum =
                        cartTotalVal.compareTo(new java.math.BigDecimal("2000")) >= 0;
                %>

                <div class="summary-line"></div>

                <div class="summary-row">
                    <span>Subtotal</span>
                    <strong>₹<%= cartTotalVal %></strong>
                </div>

                <!-- COUPON SECTION -->
                <div class="coupon-section">

                    <% if (isAboveMinimum) { %>

                        <% if (appliedCouponCode != null && discountAmount.compareTo(java.math.BigDecimal.ZERO) > 0) { %>

                            <!-- Applied Coupon Display -->
                            <div class="applied-coupon-box">
                                <div class="applied-coupon-info">
                                    <i class="fa-solid fa-ticket"></i>
                                    <div>
                                        <strong><%= safe(appliedCouponCode) %></strong>
                                        <span>Coupon Applied</span>
                                    </div>
                                </div>
                                <form action="<%= contextPath %>/remove-coupon" method="post" class="remove-coupon-form">
                                    <button type="submit" title="Remove Coupon">
                                        <i class="fa-solid fa-xmark"></i>
                                    </button>
                                </form>
                            </div>

                        <% } else { %>

                            <!-- Coupon Input Form -->
                            <form action="<%= contextPath %>/apply-coupon" method="post" class="coupon-form">
                                <input type="text"
                                       name="couponCode"
                                       placeholder="Enter coupon code"
                                       autocomplete="off"
                                       value="<%= appliedCouponCode != null ? safe(appliedCouponCode) : "" %>">
                                <button type="submit">
                                    <i class="fa-solid fa-tag"></i>
                                    Apply
                                </button>
                            </form>

                        <% } %>

                    <% } else { %>

                        <!-- Below ₹2000 Message -->
                        <div class="coupon-min-box">
                            <i class="fa-solid fa-circle-info"></i>
                            <div>
                                <p>Add <strong>₹<%= new java.math.BigDecimal("2000").subtract(cartTotalVal) %></strong> more to unlock coupon discounts!</p>
                                <small>Coupons available on orders above ₹2,000</small>
                            </div>
                        </div>

                        <div class="coupon-progress-bar">
                            <%
                                double progressPercent = cartTotalVal.doubleValue() / 2000.0 * 100;
                                if (progressPercent > 100) progressPercent = 100;
                            %>
                            <div class="coupon-progress-fill" style="width: <%= String.format("%.0f", progressPercent) %>%"></div>
                        </div>

                    <% } %>

                    <% if (request.getAttribute("couponSuccess") != null) { %>
                        <p class="coupon-success">
                            <i class="fa-solid fa-circle-check"></i>
                            <%= request.getAttribute("couponSuccess") %>
                        </p>
                    <% } %>

                    <% if (request.getAttribute("couponError") != null) { %>
                        <p class="coupon-error">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            <%= request.getAttribute("couponError") %>
                        </p>
                    <% } %>

                </div>

                <!-- Discount & Total -->
                <% if (discountAmount.compareTo(java.math.BigDecimal.ZERO) > 0) { %>
                    <div class="summary-row discount-row">
                        <span>Discount</span>
                        <strong class="discount-text">- ₹<%= discountAmount %></strong>
                    </div>
                <% } %>

                <div class="summary-line"></div>

                <div class="summary-row total-row">
                    <span>Total Amount</span>
                    <% if (finalAmount != null && discountAmount.compareTo(java.math.BigDecimal.ZERO) > 0) { %>
                        <strong>₹<%= finalAmount %></strong>
                    <% } else { %>
                        <strong>₹<%= cartTotalVal %></strong>
                    <% } %>
                </div>

                <!-- Offer Hint -->
                <div class="offer-summary-box">
                    <div class="offer-icon">
                        <i class="fa-solid fa-gift"></i>
                    </div>
                    <div>
                        <h4>Special Offer</h4>
                        <p>Use code <strong>NOVAFIT20</strong> on orders above ₹2,000 and get 20% OFF (max ₹500).</p>
                    </div>
                </div>

                <a href="<%= contextPath %>/checkout" class="checkout-btn">
                    Proceed to Checkout
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

                <a href="<%= contextPath %>/products" class="continue-btn">
                    <i class="fa-solid fa-arrow-left"></i>
                    Continue Shopping
                </a>

                <p class="secure-note">
                    <i class="fa-solid fa-shield-halved"></i>
                    Safe & Secure Checkout
                </p>

            </aside>

        </div>

        <%
            } else {
        %>

        <!-- EMPTY CART -->
        <div class="empty-cart">

            <div class="empty-cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>

            <h2>Your cart is empty</h2>

            <p>
                Looks like you have not added anything to your cart yet.
                Explore NovaFit collections and find your perfect style.
            </p>

            <a href="<%= contextPath %>/products">
                Shop Now
                <i class="fa-solid fa-arrow-right"></i>
            </a>

        </div>

        <%
            }
        %>

    </section>

    <!-- BOTTOM FEATURES -->
    <section class="cart-bottom-features">

        <div class="bottom-feature">
            <i class="fa-solid fa-award"></i>
            <div>
                <h4>100% Original Products</h4>
                <p>Sourced from trusted brands</p>
            </div>
        </div>

        <div class="bottom-feature">
            <i class="fa-solid fa-shield-heart"></i>
            <div>
                <h4>Quality Assured</h4>
                <p>We never compromise</p>
            </div>
        </div>

        <div class="bottom-feature">
            <i class="fa-regular fa-credit-card"></i>
            <div>
                <h4>Secure Payments</h4>
                <p>Multiple safe payment options</p>
            </div>
        </div>

        <div class="bottom-feature">
            <i class="fa-solid fa-headset"></i>
            <div>
                <h4>Customer Support</h4>
                <p>We are here to help you</p>
            </div>
        </div>

    </section>

</section>

<jsp:include page="../partials/footer.jsp"/>

</body>
</html>