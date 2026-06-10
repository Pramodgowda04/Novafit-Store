<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.fashionstore.model.CartItem" %>
<%@ page import="com.fashionstore.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | NovaFit</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@700;800&display=swap" rel="stylesheet">
    
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/checkout.css">
</head>
<body>

    <!-- Top Alert Bar -->
    <div class="top-bar">
        <div class="top-bar-container">
            <div class="top-bar-left">
                <i class="fa-solid fa-star text-gold"></i>
                <span class="alert-text">NEW COLLECTION ALERT!</span>
                <span class="promo-text">Get 20% OFF on your first order. Use code: <strong>NOVAFIT20</strong></span>
            </div>
            <div class="top-bar-right">
                <a href="#"><i class="fa-solid fa-truck-fast text-gold"></i> Track Order</a>
                <span class="divider">|</span>
                <a href="#"><i class="fa-solid fa-headset text-gold"></i> Help & Support</a>
            </div>
        </div>
    </div>

    <!-- Main Header -->
    <header class="main-header">
        <div class="header-container">
            <div class="logo">
                <h1>NOVA<span>FIT</span></h1>
                <span class="tagline">FASHION STORE</span>
            </div>
            
            <nav class="main-nav">
                <ul>
                    <li><a href="<%= request.getContextPath() %>/">HOME</a></li>
                    <li><a href="#">MEN</a></li>
                    <li><a href="#">WOMEN</a></li>
                    <li><a href="#">FOOTWEAR</a></li>
                    <li><a href="#">ACCESSORIES</a></li>
                    <li><a href="#">NEW ARRIVALS</a></li>
                    <li><a href="#">SALE</a></li>
                </ul>
            </nav>
            
            <div class="header-icons">
                <a href="#"><i class="fa-solid fa-magnifying-glass"></i></a>
                <a href="<%= request.getContextPath() %>/profile"><i class="fa-regular fa-user"></i></a>
                <a href="#"><i class="fa-regular fa-heart"></i></a>
                <a href="<%= request.getContextPath() %>/cart" class="cart-icon">
                    <i class="fa-solid fa-bag-shopping"></i>
                    <% 
                        List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
                        int count = (cartItems != null) ? cartItems.size() : 0;
                    %>
                    <span class="cart-badge"><%= count %></span>
                </a>
            </div>
        </div>
    </header>

    <!-- Page Title Section -->
    <div class="page-title-section">
        <div class="page-title-container">
            <div class="title-left">
                <h2>CHECKOUT</h2>
                <div class="breadcrumbs">
                    <span><a href="<%= request.getContextPath() %>/">Home</a></span> <i class="fa-solid fa-angle-right"></i> 
                    <span><a href="<%= request.getContextPath() %>/cart">Cart</a></span> <i class="fa-solid fa-angle-right"></i> 
                    <span class="current">Checkout</span>
                </div>
            </div>
            <div class="title-right">
                <div class="secure-badge">
                    <i class="fa-solid fa-shield-check shield-icon"></i>
                    <div class="secure-text">
                        <strong>100% SECURE</strong>
                        <span>Safe & Protected Payments</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content Area -->
    <main class="checkout-main">
        
        <!-- Progress Steps -->
        <div class="progress-container">
            <div class="step completed">
                <div class="step-icon">1</div>
                <div class="step-label"><i class="fa-solid fa-bag-shopping"></i> SHOPPING CART</div>
            </div>
            <div class="step-divider"></div>
            
            <div class="step active">
                <div class="step-icon">2</div>
                <div class="step-label"><i class="fa-solid fa-location-dot"></i> SHIPPING DETAILS</div>
            </div>
            <div class="step-divider"></div>
            
            <div class="step">
                <div class="step-icon">3</div>
                <div class="step-label"><i class="fa-regular fa-credit-card"></i> PAYMENT</div>
            </div>
            <div class="step-divider"></div>
            
            <div class="step">
                <div class="step-icon">4</div>
                <div class="step-label"><i class="fa-regular fa-circle-check"></i> ORDER CONFIRMATION</div>
            </div>
        </div>

        <%
            Map<Integer, Product> productMap = (Map<Integer, Product>) request.getAttribute("productMap");
            Double totalAmount = (Double) request.getAttribute("totalAmount");
            Double discountAmount = (Double) request.getAttribute("discountAmount");
            Double finalAmount = (Double) request.getAttribute("finalAmount");

            if (cartItems != null && !cartItems.isEmpty()) {
        %>

        <!-- 3 Column Layout -->
        <div class="checkout-grid">
            
            <!-- Column 1: Order Summary -->
            <div class="card order-summary">
                <div class="card-header">
                    <h3><i class="fa-solid fa-bag-shopping"></i> ORDER SUMMARY</h3>
                </div>
                <div class="card-body">
                    
                    <div class="cart-items">
                        <%
                            for (CartItem item : cartItems) {
                                Product product = productMap.get(item.getProductId());
                        %>
                        <div class="cart-item">
                            <div class="item-image" style="background-color: #f1f1f1;"></div>
                            <div class="item-details">
                                <h4><%= product.getName() %></h4>
                                <p>Size: <%= item.getSize() %> &nbsp;&bull;&nbsp; Qty: <%= item.getQuantity() %></p>
                            </div>
                            <div class="item-price">₹<%= String.format("%.0f", product.getPrice()) %></div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    
                    <div class="summary-totals">
                        <div class="summary-row">
                            <span>Subtotal (<%= count %> Items)</span>
                            <strong>₹<%= totalAmount != null ? String.format("%.0f", totalAmount) : "0" %></strong>
                        </div>
                        <div class="summary-row">
                            <span>Shipping</span>
                            <strong class="text-green" id="shipping-cost-display">FREE</strong>
                        </div>
                        
                        <% if (discountAmount != null && discountAmount > 0) { %>
                        <div class="summary-row discount-row">
                            <span>Discount</span>
                            <strong class="text-green">-₹<%= String.format("%.0f", discountAmount) %></strong>
                        </div>
                        <% } %>
                        
                        <div class="summary-row total-row">
                            <span>TOTAL</span>
                            <strong id="final-total-display">₹<%= finalAmount != null ? String.format("%.0f", finalAmount) : "0" %></strong>
                        </div>
                    </div>
                    
                    <% if (discountAmount != null && discountAmount > 0) { %>
                    <div class="savings-alert">
                        <i class="fa-solid fa-tag"></i>
                        <span>You saved <strong>₹<%= String.format("%.0f", discountAmount) %></strong> on this order!</span>
                    </div>
                    <% } %>
                    
                </div>
            </div>

            <!-- Column 2: Shipping Details Form -->
            <div class="card shipping-details">
                <div class="card-header">
                    <h3><i class="fa-solid fa-location-dot"></i> SHIPPING DETAILS</h3>
                </div>
                <div class="card-body">
                    <form action="<%= request.getContextPath() %>/place-order" method="POST" class="shipping-form" id="checkout-form">
                        
                        <!-- Added hidden input for delivery cost -->
                        <input type="hidden" name="deliveryCost" id="hidden-delivery-cost" value="0">
                        
                        <div class="form-row">
                            <div class="form-group half">
                                <label>Full Name <span class="required">*</span></label>
                                <input type="text" name="fullName" placeholder="Enter your full name" pattern="[A-Za-z\s]+" title="Name should only contain letters and spaces" oninput="this.value = this.value.replace(/[^A-Za-z\s]/g, '');" required>
                            </div>
                            <div class="form-group half">
                                <label>Phone Number <span class="required">*</span></label>
                                <input type="tel" name="phone" placeholder="Enter your 10-digit phone number" pattern="[0-9]{10}" maxlength="10" title="Please enter a valid 10-digit phone number" oninput="this.value = this.value.replace(/[^0-9]/g, '');" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Email Address <span class="required">*</span></label>
                            <input type="email" name="email" placeholder="Enter your email address" oninput="this.value = this.value.replace(/\s/g, '');" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Address Line 1 <span class="required">*</span></label>
                            <input type="text" name="addressLine1" placeholder="House No., Building, Street, Area" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Address Line 2 <span class="optional">(Optional)</span></label>
                            <input type="text" name="addressLine2" placeholder="Apartment, Suite, Landmark, etc.">
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group third">
                                <label>Country <span class="required">*</span></label>
                                <select name="country" required>
                                    <option value="India" selected>India</option>
                                </select>
                            </div>
                            <div class="form-group third">
                                <label>State <span class="required">*</span></label>
                                <select name="state" required>
                                    <option value="Karnataka" selected>Karnataka</option>
                                    <option value="Maharashtra">Maharashtra</option>
                                    <option value="Delhi">Delhi</option>
                                </select>
                            </div>
                            <div class="form-group third">
                                <label>City <span class="required">*</span></label>
                                <select name="city" required>
                                    <option value="Bangalore" selected>Bangalore</option>
                                    <option value="Mumbai">Mumbai</option>
                                    <option value="New Delhi">New Delhi</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-group half">
                            <label>Pincode <span class="required">*</span></label>
                            <input type="text" name="pincode" placeholder="Enter pincode" pattern="[0-9]{6}" maxlength="6" title="Please enter a valid 6-digit pincode" oninput="this.value = this.value.replace(/[^0-9]/g, '');" required>
                        </div>
                        
                        <div class="checkbox-group">
                            <input type="checkbox" name="saveAddress" id="save-address" checked>
                            <label for="save-address">Save this address for future orders</label>
                        </div>
                        
                    </form>
                </div>
            </div>

            <!-- Column 3: Delivery Options & Payment -->
            <div class="right-col">
                
                <!-- Delivery Options -->
                <div class="card delivery-options">
                    <div class="card-header">
                        <h3><i class="fa-solid fa-truck"></i> DELIVERY OPTIONS</h3>
                    </div>
                    <div class="card-body">
                        
                        <label class="radio-card active">
                            <div class="radio-left">
                                <input type="radio" name="delivery" value="0" checked>
                                <div class="radio-text">
                                    <strong>Standard Delivery</strong>
                                    <span>Delivered in 3-5 working days</span>
                                </div>
                            </div>
                            <div class="radio-right text-green fw-bold">FREE</div>
                        </label>
                        
                        <label class="radio-card">
                            <div class="radio-left">
                                <input type="radio" name="delivery" value="149">
                                <div class="radio-text">
                                    <strong>Express Delivery</strong>
                                    <span>Delivered in 1-2 working days</span>
                                </div>
                            </div>
                            <div class="radio-right fw-bold">₹149</div>
                        </label>
                        
                    </div>
                </div>
                
                <!-- Payment Method -->
                <div class="card payment-method">
                    <div class="card-header">
                        <h3><i class="fa-regular fa-credit-card"></i> PAYMENT METHOD</h3>
                        <p class="subtitle">Choose a payment method</p>
                    </div>
                    <div class="card-body">
                        
                        <label class="radio-card active payment-option">
                            <div class="radio-left">
                                <input type="radio" name="payment" value="cod" checked>
                                <div class="radio-text">
                                    <strong>Cash on Delivery</strong>
                                    <span>Pay when you receive</span>
                                </div>
                            </div>
                            <div class="payment-icons">
                                <i class="fa-solid fa-money-bill-1-wave text-green"></i>
                            </div>
                        </label>
                        
                        <button type="submit" form="checkout-form" class="btn-primary w-100 mt-4">
                            PLACE ORDER <i class="fa-solid fa-arrow-right"></i>
                        </button>
                        
                    </div>
                </div>
                
            </div>

        </div>

        <%
            } else {
        %>
        
        <div class="card" style="padding: 40px; text-align: center;">
            <i class="fa-solid fa-bag-shopping" style="font-size: 3rem; color: #ccc; margin-bottom: 20px;"></i>
            <h2>Your cart is empty</h2>
            <p style="color: #666; margin: 10px 0 20px;">Add some items to your cart before proceeding to checkout.</p>
            <a href="<%= request.getContextPath() %>/" class="btn-primary" style="display: inline-block; width: auto; padding: 12px 30px; text-decoration:none;">Shop Now</a>
        </div>
        
        <%
            }
        %>

    </main>

    <!-- Footer Features -->
    <div class="footer-features">
        <div class="feature-container">
            <div class="feature-item">
                <div class="feature-icon"><i class="fa-solid fa-truck-fast"></i></div>
                <div class="feature-text">
                    <h4>FREE SHIPPING</h4>
                    <p>On orders above ₹999</p>
                </div>
            </div>
            <div class="feature-item">
                <div class="feature-icon"><i class="fa-solid fa-rotate-left"></i></div>
                <div class="feature-text">
                    <h4>EASY RETURNS</h4>
                    <p>Within 7 days</p>
                </div>
            </div>
            <div class="feature-item">
                <div class="feature-icon"><i class="fa-solid fa-shield-check"></i></div>
                <div class="feature-text">
                    <h4>SECURE PAYMENT</h4>
                    <p>100% protected</p>
                </div>
            </div>
            <div class="feature-item">
                <div class="feature-icon"><i class="fa-solid fa-headset"></i></div>
                <div class="feature-text">
                    <h4>24/7 SUPPORT</h4>
                    <p>We're here to help you</p>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript for dynamic total calculation and active states -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const deliveryRadios = document.querySelectorAll('input[name="delivery"]');
            const shippingDisplay = document.getElementById('shipping-cost-display');
            const totalDisplay = document.getElementById('final-total-display');
            
            // Get base final amount from JSP
            const baseTotal = <%= finalAmount != null ? finalAmount : 0 %>;
            
            // Delivery selection logic
            deliveryRadios.forEach(radio => {
                radio.addEventListener('change', function() {
                    // Update active styling
                    document.querySelectorAll('.delivery-options .radio-card').forEach(card => {
                        card.classList.remove('active');
                    });
                    this.closest('.radio-card').classList.add('active');
                    
                    // Update totals
                    const shippingCost = parseInt(this.value);
                    
                    if (shippingCost === 0) {
                        shippingDisplay.textContent = 'FREE';
                        shippingDisplay.classList.add('text-green');
                    } else {
                        shippingDisplay.textContent = '₹' + shippingCost;
                        shippingDisplay.classList.remove('text-green');
                    }
                    
                    const newTotal = baseTotal + shippingCost;
                    totalDisplay.textContent = '₹' + newTotal;
                    
                    const hiddenDeliveryCost = document.getElementById('hidden-delivery-cost');
                    if (hiddenDeliveryCost) {
                        hiddenDeliveryCost.value = shippingCost;
                    }
                });
            });

            // Payment selection logic
            const paymentRadios = document.querySelectorAll('input[name="payment"]');
            paymentRadios.forEach(radio => {
                radio.addEventListener('change', function() {
                    document.querySelectorAll('.payment-method .radio-card').forEach(card => {
                        card.classList.remove('active');
                    });
                    this.closest('.radio-card').classList.add('active');
                });
            });
        });
    </script>
</body>
</html>