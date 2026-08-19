<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Portal Login - NOVAFIT</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
* { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, Helvetica, sans-serif; }

body {
    background: 
        radial-gradient(circle at 15% 15%, rgba(200, 155, 60, 0.18), transparent 40%),
        radial-gradient(circle at 85% 85%, rgba(13, 110, 253, 0.12), transparent 45%),
        #0c0e12;
    color: #ffffff;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.admin-login-card {
    width: 100%;
    max-width: 440px;
    background: rgba(22, 25, 32, 0.85);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1.5px solid rgba(200, 155, 60, 0.3);
    border-radius: 24px;
    padding: 40px 35px;
    box-shadow: 
        0 25px 80px rgba(0, 0, 0, 0.6),
        0 0 40px rgba(200, 155, 60, 0.15);
    text-align: center;
}

.admin-shield-icon {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    background: linear-gradient(135deg, rgba(200, 155, 60, 0.2), rgba(200, 155, 60, 0.05));
    border: 1px solid rgba(200, 155, 60, 0.5);
    color: #c89b3c;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
    margin: 0 auto 20px;
    box-shadow: 0 10px 25px rgba(200, 155, 60, 0.2);
}

.admin-login-card h2 {
    font-size: 1.8rem;
    font-weight: 900;
    letter-spacing: 1px;
    margin-bottom: 8px;
    color: #ffffff;
}
.admin-login-card h2 span { color: #c89b3c; }

.admin-login-card p {
    color: #8a8f9d;
    font-size: 0.9rem;
    margin-bottom: 30px;
    line-height: 1.5;
}

.input-group {
    margin-bottom: 20px;
    text-align: left;
}

.input-group label {
    display: block;
    font-size: 0.82rem;
    font-weight: 700;
    color: #c89b3c;
    margin-bottom: 8px;
    letter-spacing: 0.5px;
}

.input-field-wrapper {
    position: relative;
    display: flex;
    align-items: center;
}

.input-field-wrapper i {
    position: absolute;
    left: 16px;
    color: #666;
    font-size: 1.1rem;
}

.input-field-wrapper input {
    width: 100%;
    background: #090a0d;
    border: 1px solid rgba(255, 255, 255, 0.12);
    color: #fff;
    padding: 14px 16px 14px 46px;
    border-radius: 14px;
    font-size: 0.95rem;
    outline: none;
    transition: all 0.3s ease;
}

.input-field-wrapper input:focus {
    border-color: #c89b3c;
    box-shadow: 0 0 15px rgba(200, 155, 60, 0.25);
}

.btn-admin-submit {
    width: 100%;
    background: linear-gradient(135deg, #c89b3c, #b47a18);
    color: #ffffff;
    border: none;
    padding: 15px;
    border-radius: 14px;
    font-weight: 900;
    font-size: 1rem;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 10px 25px rgba(200, 155, 60, 0.3);
    margin-top: 10px;
    letter-spacing: 1px;
}

.btn-admin-submit:hover {
    transform: translateY(-2px);
    box-shadow: 0 15px 35px rgba(200, 155, 60, 0.45);
}

.error-alert {
    background: rgba(220, 53, 69, 0.15);
    border: 1px solid rgba(220, 53, 69, 0.4);
    color: #ff6b6b;
    padding: 12px;
    border-radius: 12px;
    font-size: 0.88rem;
    font-weight: 700;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 8px;
    justify-content: center;
}

.credentials-box {
    margin-top: 25px;
    background: rgba(200, 155, 60, 0.08);
    border: 1px dashed rgba(200, 155, 60, 0.3);
    padding: 12px;
    border-radius: 12px;
    font-size: 0.8rem;
    color: #c89b3c;
}
.credentials-box span { color: #fff; font-weight: 800; }

.back-link {
    display: inline-block;
    margin-top: 20px;
    color: #666;
    text-decoration: none;
    font-size: 0.85rem;
    transition: color 0.3s ease;
}
.back-link:hover { color: #fff; }
</style>

</head>

<body>

<div class="admin-login-card">

    <div class="admin-shield-icon">
        <i class="fa-solid fa-shield-halved"></i>
    </div>

    <h2>ADMIN <span>PORTAL</span> 🔒</h2>
    <p>Sign in with your master admin credentials to access store order management.</p>

    <% if (errorMessage != null) { %>
        <div class="error-alert">
            <i class="fa-solid fa-triangle-exclamation"></i>
            <%= errorMessage %>
        </div>
    <% } %>

    <form action="<%= contextPath %>/admin/login" method="post">

        <div class="input-group">
            <label>ADMIN EMAIL / USERNAME</label>
            <div class="input-field-wrapper">
                <i class="fa-solid fa-user-shield"></i>
                <input type="text" name="email" placeholder="admin@domain.com" required autocomplete="off">
            </div>
        </div>

        <div class="input-group">
            <label>PASSWORD</label>
            <div class="input-field-wrapper">
                <i class="fa-solid fa-lock"></i>
                <input type="password" name="password" placeholder="••••••••" required>
            </div>
        </div>

        <button type="submit" class="btn-admin-submit">
            LOG IN TO ADMIN PANEL 👑
        </button>

    </form>

    <a href="<%= contextPath %>/home" class="back-link">
        <i class="fa-solid fa-arrow-left"></i> Back to Storefront
    </a>

</div>

</body>
</html>
