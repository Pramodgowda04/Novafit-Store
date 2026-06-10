<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="assets/css/checkout.css">
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
                    <li><a href="#">HOME</a></li>
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
                <a href="#"><i class="fa-regular fa-user"></i></a>
                <a href="#"><i class="fa-regular fa-heart"></i></a>
                <a href="#" class="cart-icon">
                    <i class="fa-solid fa-bag-shopping"></i>
                    <span class="cart-badge">3</span>
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
                    <span>Home</span> <i class="fa-solid fa-angle-right"></i> 
                    <span>Cart</span> <i class="fa-solid fa-angle-right"></i> 
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

        <!-- 3 Column Layout -->
        <div class="checkout-grid">
            
            <!-- Column 1: Order Summary -->
            <div class="card order-summary">
                <div class="card-header">
                    <h3><i class="fa-solid fa-bag-shopping"></i> ORDER SUMMARY</h3>
                </div>
                <div class="card-body">
                    
                    <div class="cart-items">
                        <div class="cart-item">
                            <div class="item-image" style="background-color: #f1f1f1;"></div>
                            <div class="item-details">
                                <h4>NovaFit Performance T-Shirt</h4>
                                <p>Size: M &nbsp;&bull;&nbsp; Qty: 1</p>
                            </div>
                            <div class="item-price">₹899</div>
                        </div>
                        
                        <div class="cart-item">
                            <div class="item-image" style="background-color: #f4eee6;"></div>
                            <div class="item-details">
                                <h4>NovaFit Oversized Hoodie</h4>
                                <p>Size: L &nbsp;&bull;&nbsp; Qty: 1</p>
                            </div>
                            <div class="item-price">₹1,299</div>
                        </div>
                        
                        <div class="cart-item">
                            <div class="item-image" style="background-color: #eaeaea;"></div>
                            <div class="item-details">
                                <h4>NovaFit Air Sneakers</h4>
                                <p>Size: 42 &nbsp;&bull;&nbsp; Qty: 1</p>
                            </div>
                            <div class="item-price">₹2,499</div>
                        </div>
                    </div>
                    
                    <div class="summary-totals">
                        <div class="summary-row">
                            <span>Subtotal (3 Items)</span>
                            <strong>₹4,697</strong>
                        </div>
                        <div class="summary-row">
                            <span>Shipping</span>
                            <strong class="text-green">FREE</strong>
                        </div>
                        <div class="summary-row discount-row">
                            <span>Discount (NOVAFIT20)</span>
                            <strong class="text-green">-₹939</strong>
                        </div>
                        
                        <div class="summary-row total-row">
                            <span>TOTAL</span>
                            <strong>₹3,758</strong>
                        </div>
                    </div>
                    
                    <div class="savings-alert">
                        <i class="fa-solid fa-tag"></i>
                        <span>You saved <strong>₹939</strong> on this order!</span>
                    </div>
                    
                </div>
            </div>

            <!-- Column 2: Shipping Details Form -->
            <div class="card shipping-details">
                <div class="card-header">
                    <h3><i class="fa-solid fa-location-dot"></i> SHIPPING DETAILS</h3>
                </div>
                <div class="card-body">
                    <form action="#" method="POST" class="shipping-form">
                        
                        <div class="form-row">
                            <div class="form-group half">
                                <label>Full Name <span class="required">*</span></label>
                                <input type="text" placeholder="Enter your full name" required>
                            </div>
                            <div class="form-group half">
                                <label>Phone Number <span class="required">*</span></label>
                                <input type="tel" placeholder="Enter your phone number" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Email Address <span class="required">*</span></label>
                            <input type="email" placeholder="Enter your email address" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Address Line 1 <span class="required">*</span></label>
                            <input type="text" placeholder="House No., Building, Street, Area" required>
                        </div>
                        
                        <div class="form-group">
                            <label>Address Line 2 <span class="optional">(Optional)</span></label>
                            <input type="text" placeholder="Apartment, Suite, Landmark, etc.">
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group third">
                                <label>Country <span class="required">*</span></label>
                                <select required>
                                    <option value="India" selected>India</option>
                                </select>
                            </div>
                            <div class="form-group third">
                                <label>State <span class="required">*</span></label>
                                <select required>
                                    <option value="Karnataka" selected>Karnataka</option>
                                    <option value="Maharashtra">Maharashtra</option>
                                    <option value="Delhi">Delhi</option>
                                </select>
                            </div>
                            <div class="form-group third">
                                <label>City <span class="required">*</span></label>
                                <select required>
                                    <option value="Bangalore" selected>Bangalore</option>
                                    <option value="Mumbai">Mumbai</option>
                                    <option value="New Delhi">New Delhi</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-group half">
                            <label>Pincode <span class="required">*</span></label>
                            <input type="text" placeholder="Enter pincode" required>
                        </div>
                        
                        <div class="checkbox-group">
                            <input type="checkbox" id="save-address" checked>
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
                                <input type="radio" name="delivery" checked>
                                <div class="radio-text">
                                    <strong>Standard Delivery</strong>
                                    <span>Delivered in 3-5 working days</span>
                                </div>
                            </div>
                            <div class="radio-right text-green fw-bold">FREE</div>
                        </label>
                        
                        <label class="radio-card">
                            <div class="radio-left">
                                <input type="radio" name="delivery">
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
                                <input type="radio" name="payment" checked>
                                <strong>Credit / Debit Card</strong>
                            </div>
                            <div class="payment-icons">
                                <i class="fa-brands fa-cc-visa text-blue"></i>
                                <i class="fa-brands fa-cc-mastercard text-red"></i>
                            </div>
                        </label>
                        
                        <label class="radio-card payment-option">
                            <div class="radio-left">
                                <input type="radio" name="payment">
                                <strong>UPI</strong>
                            </div>
                            <div class="payment-icons text-icons">
                                <span class="upi-icon gpay">G Pay</span>
                                <span class="upi-icon phonepe">PhonePe</span>
                            </div>
                        </label>
                        
                        <label class="radio-card payment-option">
                            <div class="radio-left">
                                <input type="radio" name="payment">
                                <strong>Net Banking</strong>
                            </div>
                            <div class="payment-icons">
                                <i class="fa-solid fa-building-columns"></i>
                            </div>
                        </label>
                        
                        <label class="radio-card payment-option">
                            <div class="radio-left">
                                <input type="radio" name="payment">
                                <div class="radio-text">
                                    <strong>Cash on Delivery</strong>
                                    <span>Pay when you receive</span>
                                </div>
                            </div>
                            <div class="payment-icons">
                                <i class="fa-solid fa-money-bill-1-wave text-green"></i>
                            </div>
                        </label>
                        
                        <button class="btn-primary w-100 mt-4">
                            PROCEED TO PAYMENT <i class="fa-solid fa-arrow-right"></i>
                        </button>
                        
                    </div>
                </div>
                
            </div>

        </div>

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

</body>
</html>
