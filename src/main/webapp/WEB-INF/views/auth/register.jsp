<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("userId") != null) {
        response.sendRedirect(request.getContextPath() + "/profile");
        return;
    }
%>
<%
    String errorMessage = (String) request.getAttribute("error");
    String successMessage = (String) request.getAttribute("success");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register - NOVAFIT Fashion Store</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/auth.css?v=20">
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
            <h2 class="nf-bg-text">FASHION</h2>

            <div class="nf-left-content">

                <p class="nf-mini-title">
                    WELCOME TO NOVAFIT
                    <span></span>
                </p>

                <h1>
                    Join the <br>
                    <strong>NovaFit</strong> <br>
                    Experience
                </h1>

                <p class="nf-left-desc">
                    Create an account and unlock premium fashion,
                    exclusive offers and personalized style.
                </p>

                <div class="nf-feature">
                    <i class="fa-regular fa-star"></i>
                    <div>
                        <h4>Exclusive Benefits</h4>
                        <p>Access members-only offers and early sale access.</p>
                    </div>
                </div>

                <div class="nf-feature">
                    <i class="fa-solid fa-tags"></i>
                    <div>
                        <h4>Personalized for You</h4>
                        <p>Get style recommendations that match your vibe.</p>
                    </div>
                </div>

                <div class="nf-feature">
                    <i class="fa-solid fa-lock"></i>
                    <div>
                        <h4>Secure & Trusted</h4>
                        <p>Your data is always safe with us.</p>
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

            <div class="nf-auth-card nf-register-card">

                <div class="nf-card-header">
                    <h2>Create Your Account</h2>
                    <p>Sign up and start your fashion journey with NovaFit.</p>
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

                <form action="<%= request.getContextPath() %>/register"
                      method="post"
                      class="nf-auth-form"
                      onsubmit="return validateRegisterForm()">

                    <div class="nf-input-group">
                        <i class="fa-regular fa-user"></i>
                        <input type="text" name="name" placeholder="Full Name" required>
                    </div>

                    <div class="nf-input-group">
                        <i class="fa-regular fa-envelope"></i>
                        <input type="email" name="email" placeholder="Email Address" required>
                    </div>

                    <div class="nf-input-group">
                        <i class="fa-solid fa-phone"></i>
                        <input type="text" name="phone" placeholder="Phone Number" required>
                    </div>

                    <div class="nf-input-group">
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" name="password" id="registerPassword" placeholder="Password" required>

                        <button type="button" class="nf-eye-btn" onclick="togglePassword('registerPassword', this)">
                            <i class="fa-regular fa-eye"></i>
                        </button>
                    </div>

                    <div class="nf-input-group">
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm Password" required>

                        <button type="button" class="nf-eye-btn" onclick="togglePassword('confirmPassword', this)">
                            <i class="fa-regular fa-eye"></i>
                        </button>
                    </div>

                    <div class="nf-textarea-group">
                        <i class="fa-solid fa-location-dot"></i>
                        <textarea name="address" placeholder="Permanent Address" required></textarea>
                    </div>

                    <p id="passwordError" class="nf-password-error"></p>

                    <label class="nf-check nf-terms">
                        <input type="checkbox" required>
                        <span></span>
                        I agree to the <a href="#">Terms & Privacy Policy</a>
                    </label>

                    <button type="submit" class="nf-main-btn">
                        CREATE ACCOUNT
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
                    Already have an account?
                    <a href="<%= request.getContextPath() %>/login">Login</a>
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

    function validateRegisterForm() {
        const password = document.getElementById("registerPassword").value;
        const confirmPassword = document.getElementById("confirmPassword").value;
        const errorText = document.getElementById("passwordError");

        if (password !== confirmPassword) {
            errorText.innerText = "Password and Confirm Password do not match.";
            return false;
        }

        errorText.innerText = "";
        return true;
    }
</script>

</body>
</html>