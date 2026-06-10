<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<footer class="nf-main-footer">

    <div class="nf-footer-container">

        <div class="nf-footer-brand">

            <a href="<%= request.getContextPath() %>/home" class="nf-footer-logo">
                NOVA<span>FIT</span>
                <small>FASHION STORE</small>
            </a>

            <p>
                NovaFit brings premium fashion, stylish collections,
                secure shopping and smooth online experience for every customer.
            </p>

            <div class="nf-footer-social">
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
                <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                <a href="#"><i class="fa-brands fa-linkedin-in"></i></a>
            </div>

        </div>

        <div class="nf-footer-column">
            <h3>SHOP</h3>
            <a href="<%= request.getContextPath() %>/products">All Products</a>
            <a href="<%= request.getContextPath() %>/products?categoryId=1">Men</a>
            <a href="<%= request.getContextPath() %>/products?categoryId=2">Women</a>
            <a href="<%= request.getContextPath() %>/products?categoryId=4">Footwear</a>
            <a href="<%= request.getContextPath() %>/products?categoryId=5">Accessories</a>
        </div>

        <div class="nf-footer-column">
            <h3>CUSTOMER CARE</h3>
            <a href="<%= request.getContextPath() %>/orders">Track Order</a>
            <a href="#">Shipping Policy</a>
            <a href="#">Returns & Exchanges</a>
            <a href="#">Size Guide</a>
            <a href="#">Help & Support</a>
        </div>

        <div class="nf-footer-column">
            <h3>ACCOUNT</h3>
            <a href="<%= request.getContextPath() %>/profile">My Profile</a>
            <a href="<%= request.getContextPath() %>/cart">My Cart</a>
            <a href="<%= request.getContextPath() %>/orders">My Orders</a>
            <a href="<%= request.getContextPath() %>/login">Login</a>
            <a href="<%= request.getContextPath() %>/register">Register</a>
        </div>

        <div class="nf-footer-contact">

            <h3>CONTACT</h3>

            <p>
                <i class="fa-regular fa-envelope"></i>
                support@novafit.com
            </p>

            <p>
                <i class="fa-solid fa-phone"></i>
                +91 98765 43210
            </p>

            <p>
                <i class="fa-solid fa-location-dot"></i>
                Bengaluru, Karnataka, India
            </p>

            <form action="#" class="nf-newsletter">
                <input type="email" placeholder="Enter your email">
                <button type="button">
                    <i class="fa-solid fa-paper-plane"></i>
                </button>
            </form>

        </div>

    </div>

    <div class="nf-footer-bottom">

        <p>© 2026 NOVAFIT. All Rights Reserved.</p>

        <div>
            <a href="#">Privacy Policy</a>
            <span>|</span>
            <a href="#">Terms of Service</a>
            <span>|</span>
            <a href="#">Cookie Policy</a>
        </div>

    </div>

</footer>