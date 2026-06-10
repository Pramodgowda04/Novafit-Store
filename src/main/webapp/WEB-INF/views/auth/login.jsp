<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("userId") != null) {
        response.sendRedirect(request.getContextPath() + "/profile");
        return;
    }

    String errorMessage = (String) request.getAttribute("error");
    String successMessage = (String) request.getAttribute("success");

    String savedEmail = "";
    String savedPassword = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("rememberEmail".equals(c.getName())) {
                savedEmail = c.getValue();
            }
            if ("rememberPassword".equals(c.getName())) {
                savedPassword = c.getValue();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - NOVAFIT Fashion Store</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/auth.css?v=25">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

</head>

<body>

<section class="nf-auth-page">

    <a href="<%= request.getContextPath() %>/home" class="nf-auth-brand">
        NOVA<span>FIT</span>
        <small>FASHION STORE</small>
    </a>

    <a href="<%= request.getContextPath() %>/home" class="nf-back-home">
        <i class="fa-solid fa-arrow-left"></i>
        Back to Home
    </a>

    <div class="nf-auth-container">

        <div class="nf-auth-left">

            <div class="nf-dot-pattern"></div>
            <div class="nf-gold-ring ring-one"></div>
            <div class="nf-gold-ring ring-two"></div>
            <h2 class="nf-bg-text">STYLE</h2>

            <div class="nf-left-content">

                <p class="nf-mini-title">
                    WELCOME BACK
                    <span></span>
                </p>

                <h1>
                    Welcome Back <br>
                    to <strong>NovaFit</strong>
                </h1>

                <p class="nf-left-desc">
                    Your style, your way. Sign in to explore exclusive collections,
                    premium offers and personalized fashion picks.
                </p>

                <div class="nf-feature">
                    <i class="fa-regular fa-star"></i>
                    <div>
                        <h4>Premium Collections</h4>
                        <p>Handpicked fashion for every you.</p>
                    </div>
                </div>

                <div class="nf-feature">
                    <i class="fa-solid fa-tags"></i>
                    <div>
                        <h4>Exclusive Offers</h4>
                        <p>Enjoy members-only deals and sale access.</p>
                    </div>
                </div>

                <div class="nf-feature">
                    <i class="fa-solid fa-lock"></i>
                    <div>
                        <h4>Secure & Private</h4>
                        <p>Your data is always protected with us.</p>
                    </div>
                </div>

            </div>

            <div class="nf-fashion-showcase">
                <div class="nf-rack-line"></div>
                <div class="nf-hanger h1"></div>
                <div class="nf-hanger h2"></div>
                <div class="nf-hanger h3"></div>

                <div class="nf-cloth cloth-one"></div>
                <div class="nf-cloth cloth-two"></div>
                <div class="nf-cloth cloth-three"></div>

                <div class="nf-bag">
                    <i class="fa-solid fa-bag-shopping"></i>
                </div>

                <div class="nf-shoe">
                    <i class="fa-solid fa-shoe-prints"></i>
                </div>
            </div>

        </div>

        <div class="nf-auth-right">

            <div class="nf-auth-card">

                <div class="nf-card-header">
                    <h2>Login to Your Account</h2>
                    <p>Enter your credentials to continue</p>
                </div>

                <% if (errorMessage != null) { %>
                    <div class="nf-alert nf-error">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <span><%= errorMessage %></span>
                    </div>
                <% } %>

                <% if (successMessage != null) { %>
                    <div class="nf-alert nf-success">
                        <i class="fa-solid fa-circle-check"></i>
                        <span><%= successMessage %></span>
                    </div>
                <% } %>

                <form action="<%= request.getContextPath() %>/login" method="post" class="nf-auth-form">

                    <div class="nf-input-group">
                        <i class="fa-regular fa-envelope"></i>
                        <input type="email" name="email" placeholder="Email Address" value="<%= savedEmail %>" required>
                    </div>

                    <div class="nf-input-group">
                        <i class="fa-solid fa-lock"></i>
                        <input type="password"
                               name="password"
                               id="loginPassword"
                               placeholder="Password"
                               value="<%= savedPassword %>"
                               required>

                        <button type="button"
                                class="nf-eye-btn"
                                onclick="togglePassword('loginPassword', this)">
                            <i class="fa-regular fa-eye"></i>
                        </button>
                    </div>

                    <div class="nf-form-options">
                        <label class="nf-check">
                            <input type="checkbox" name="remember" <%= !savedEmail.isEmpty() ? "checked" : "" %>>
                            <span></span>
                            Remember me
                        </label>
                    </div>

                    <button type="submit" class="nf-main-btn">
                        LOGIN
                    </button>

                    <div class="nf-divider">
                        <span></span>
                        <p>OR</p>
                        <span></span>
                    </div>

                    <div class="nf-social-row">
                        <button type="button" onclick="window.location.href='<%= request.getContextPath() %>/oauth/google'" style="width: 100%;">
                            <i class="fa-brands fa-google"></i>
                            Google
                        </button>
                    </div>

                </form>

                <p class="nf-switch-text">
                    Don't have an account?
                    <a href="<%= request.getContextPath() %>/register">Register</a>
                </p>

            </div>

        </div>

    </div>

</section>

<script>
    function togglePassword(inputId, button) {
        const passwordInput = document.getElementById(inputId);
        const icon = button.querySelector("i");

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            passwordInput.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }
</script>

</body>
</html>