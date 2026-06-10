<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.fashionstore.model.Order" %>

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

    private String formatDate(java.sql.Timestamp timestamp) {
        if (timestamp == null) {
            return "Recently";
        }

        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
        return sdf.format(timestamp);
    }

    private String normalizeStatus(String status) {
        if (status == null || status.trim().isEmpty()) {
            return "Placed";
        }

        return status.trim();
    }

    private String statusClass(String status) {
        String s = normalizeStatus(status).toLowerCase();

        if (s.contains("deliver")) {
            return "delivered";
        }

        if (s.contains("ship") || s.contains("transit")) {
            return "shipped";
        }

        if (s.contains("cancel")) {
            return "cancelled";
        }

        if (s.contains("place")) {
            return "placed";
        }

        return "processing";
    }

    private int progressLevel(String status) {
        String s = normalizeStatus(status).toLowerCase();

        if (s.contains("deliver")) {
            return 4;
        }

        if (s.contains("ship") || s.contains("transit")) {
            return 3;
        }

        if (s.contains("process")) {
            return 2;
        }

        if (s.contains("cancel")) {
            return -1;
        }

        return 1;
    }
%>

<%
    String contextPath = request.getContextPath();

    List<Order> orders =
            (List<Order>) request.getAttribute("orders");

    int totalOrders = 0;
    int deliveredOrders = 0;
    int shippedOrders = 0;
    int processingOrders = 0;
    int cancelledOrders = 0;
    double totalSpent = 0;

    DecimalFormat amountFormat = new DecimalFormat("#,##0.00");

    if (orders != null) {
        totalOrders = orders.size();

        for (Order order : orders) {
            String status = normalizeStatus(order.getStatus()).toLowerCase();

            totalSpent += order.getTotalAmount();

            if (status.contains("deliver")) {
                deliveredOrders++;
            } else if (status.contains("ship") || status.contains("transit")) {
                shippedOrders++;
            } else if (status.contains("cancel")) {
                cancelledOrders++;
            } else {
                processingOrders++;
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders - NOVAFIT Fashion Store</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, Helvetica, sans-serif;
}

html{
    scroll-behavior:smooth;
}

body{
    background:#fffaf2;
    color:#111;
    overflow-x:hidden;
}

/* ===============================
   HEADER + NAVBAR CSS FIX
================================ */

.nf-top-offer-bar{
    width:100%;
    min-height:42px;
    background:#111;
    color:#fff;
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:25px;
    padding:0 55px;
    border-bottom:1px solid rgba(200,155,60,0.35);
}

.nf-offer-left{
    display:flex;
    align-items:center;
    gap:34px;
    flex-wrap:wrap;
}

.nf-offer-left span{
    display:inline-flex;
    align-items:center;
    gap:9px;
    font-size:14px;
    font-weight:700;
    color:#f5f5f5;
}

.nf-offer-left i{
    color:#c89b3c;
}

.nf-top-offer-bar a{
    color:#c89b3c;
    text-decoration:none;
    font-size:14px;
    font-weight:900;
    display:inline-flex;
    align-items:center;
    gap:8px;
    white-space:nowrap;
}

.nf-main-header{
    width:100%;
    min-height:92px;
    background:#fff;
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:30px;
    padding:0 55px;
    border-bottom:1px solid #eee;
    position:sticky;
    top:0;
    z-index:999;
    box-shadow:0 8px 25px rgba(0,0,0,0.04);
}

.nf-site-logo{
    text-decoration:none;
    color:#111;
    font-size:34px;
    font-weight:900;
    letter-spacing:4px;
    line-height:1;
    white-space:nowrap;
}

.nf-site-logo span{
    color:#c89b3c;
}

.nf-site-logo small{
    display:block;
    font-size:11px;
    letter-spacing:5px;
    margin-top:8px;
    color:#444;
}

.nf-main-nav{
    display:flex;
    align-items:center;
    gap:28px;
}

.nf-main-nav a{
    color:#111;
    text-decoration:none;
    font-size:14px;
    font-weight:900;
    padding:10px 0;
    position:relative;
    transition:0.3s;
    white-space:nowrap;
}

.nf-main-nav a::after{
    content:"";
    position:absolute;
    left:0;
    bottom:2px;
    width:0;
    height:2px;
    background:#c89b3c;
    transition:0.3s;
}

.nf-main-nav a:hover{
    color:#c89b3c;
}

.nf-main-nav a:hover::after{
    width:100%;
}

.nf-header-actions{
    display:flex;
    align-items:center;
    gap:18px;
}

.nf-nav-search{
    width:260px;
    height:42px;
    border:1px solid #ddd;
    border-radius:30px;
    background:#fff;
    display:flex;
    align-items:center;
    overflow:hidden;
}

.nf-nav-search input{
    flex:1;
    height:100%;
    border:none;
    outline:none;
    padding:0 18px;
    font-size:14px;
    color:#111;
}

.nf-nav-search button{
    width:50px;
    height:100%;
    border:none;
    background:#fff;
    color:#111;
    cursor:pointer;
    font-size:16px;
}

.nf-header-icon,
.nf-cart-link{
    text-decoration:none;
    color:#111;
    font-size:22px;
    position:relative;
}

.nf-cart-link span{
    position:absolute;
    top:-10px;
    right:-12px;
    width:20px;
    height:20px;
    border-radius:50%;
    background:#c89b3c;
    color:#fff;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:11px;
    font-weight:900;
}

.nf-user-pill{
    max-width:180px;
    overflow:hidden;
    text-overflow:ellipsis;
    white-space:nowrap;
    text-decoration:none;
    color:#c89b3c;
    font-size:15px;
    font-weight:900;
}

.nf-login-btn,
.nf-logout-btn{
    text-decoration:none;
    border-radius:30px;
    padding:13px 25px;
    font-size:15px;
    font-weight:900;
    background:#111;
    color:#fff;
    white-space:nowrap;
}

.nf-login-btn:hover,
.nf-logout-btn:hover{
    background:#c89b3c;
    color:#fff;
}

/* Old navbar fallback */
.navbar{
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:24px 55px;
    background:#fff;
    border-bottom:1px solid #eee;
}

.nav-logo a{
    color:#111 !important;
    text-decoration:none;
    font-size:34px;
    font-weight:900;
}

.nav-links{
    display:flex;
    gap:30px;
    list-style:none;
}

.nav-links a{
    color:#111;
    text-decoration:none;
    font-weight:900;
}

.nav-actions{
    display:flex;
    align-items:center;
    gap:16px;
}

.user-name{
    color:#c89b3c !important;
    font-weight:900;
}

.login-btn{
    background:#111 !important;
    color:#fff !important;
    padding:12px 24px;
    border-radius:30px;
    text-decoration:none;
}

/* ===============================
   ORDERS PAGE
================================ */

.orders-page{
    width:100%;
    min-height:100vh;
    background:
        radial-gradient(circle at 90% 12%, rgba(200,155,60,0.13), transparent 25%),
        radial-gradient(circle at 8% 90%, rgba(200,155,60,0.08), transparent 22%),
        linear-gradient(135deg,#fffdf9,#f4eadb);
    padding-bottom:70px;
}

/* HERO */

.orders-hero{
    min-height:300px;
    background:
        radial-gradient(circle at 82% 45%, rgba(200,155,60,0.20), transparent 28%),
        linear-gradient(135deg,#111,#252525);
    color:#fff;
    padding:65px 80px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:40px;
    position:relative;
    overflow:hidden;
}

.orders-hero::before{
    content:"";
    position:absolute;
    inset:0;
    background-image:radial-gradient(rgba(200,155,60,0.25) 1px, transparent 1px);
    background-size:15px 15px;
    opacity:0.18;
}

.orders-hero-content{
    position:relative;
    z-index:3;
    max-width:730px;
}

.orders-mini-title{
    display:flex;
    align-items:center;
    gap:14px;
    color:#c89b3c;
    font-size:15px;
    font-weight:900;
    letter-spacing:2px;
    margin-bottom:16px;
}

.orders-mini-title span{
    width:60px;
    height:2px;
    background:#c89b3c;
}

.orders-hero h1{
    font-size:58px;
    line-height:1.1;
    font-weight:900;
    margin-bottom:18px;
}

.orders-hero h1 span{
    color:#c89b3c;
}

.orders-hero p{
    color:#e4e4e4;
    font-size:18px;
    line-height:1.7;
}

.orders-hero-buttons{
    margin-top:28px;
    display:flex;
    gap:16px;
    flex-wrap:wrap;
}

.gold-btn,
.outline-gold-btn{
    min-height:50px;
    padding:0 26px;
    border-radius:10px;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    justify-content:center;
    gap:10px;
    font-weight:900;
    transition:0.3s;
}

.gold-btn{
    background:linear-gradient(135deg,#d2a33f,#b47a18);
    color:#fff;
}

.outline-gold-btn{
    background:#fff;
    color:#b47a18;
    border:1px solid #c89b3c;
}

.orders-hero-visual{
    width:340px;
    height:210px;
    position:relative;
    z-index:3;
}

.hero-ring{
    position:absolute;
    border:1px solid rgba(200,155,60,0.45);
    border-radius:50%;
}

.ring-one{
    width:260px;
    height:260px;
    right:30px;
    top:-20px;
}

.ring-two{
    width:180px;
    height:180px;
    right:70px;
    top:20px;
}

.hero-bag,
.hero-box,
.hero-location{
    position:absolute;
    background:#c89b3c;
    color:#fff;
    display:flex;
    align-items:center;
    justify-content:center;
    box-shadow:0 16px 35px rgba(0,0,0,0.22);
}

.hero-bag{
    width:96px;
    height:96px;
    border-radius:24px;
    right:105px;
    top:55px;
    font-size:42px;
}

.hero-box{
    width:76px;
    height:76px;
    border-radius:20px;
    right:215px;
    top:25px;
    font-size:32px;
    background:#111;
    border:1px solid #c89b3c;
    color:#c89b3c;
}

.hero-location{
    width:76px;
    height:76px;
    border-radius:50%;
    right:10px;
    top:25px;
    font-size:32px;
    background:#111;
    border:1px solid #c89b3c;
    color:#c89b3c;
}

/* STATS */

.orders-stats{
    max-width:1320px;
    margin:-36px auto 28px;
    padding:0 35px;
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:22px;
    position:relative;
    z-index:5;
}

.stat-card{
    background:#fff;
    border:1px solid rgba(255,255,255,0.95);
    border-radius:18px;
    padding:24px;
    display:flex;
    align-items:center;
    gap:18px;
    box-shadow:0 16px 45px rgba(0,0,0,0.10);
}

.active-stat{
    background:#111;
    color:#fff;
}

.stat-icon{
    width:64px;
    height:64px;
    border-radius:16px;
    background:#f2e4d0;
    color:#c89b3c;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:28px;
}

.active-stat .stat-icon{
    background:#111;
    border:1px solid #c89b3c;
}

.stat-card h2{
    font-size:32px;
    line-height:1;
}

.stat-card p{
    font-size:16px;
    font-weight:900;
    margin:6px 0;
}

.stat-card span{
    color:#666;
    font-size:13px;
}

.active-stat span{
    color:#ddd;
}

/* MAIN */

.orders-main{
    max-width:1320px;
    margin:0 auto;
    padding:0 35px;
    display:grid;
    grid-template-columns:1fr 330px;
    gap:28px;
    align-items:flex-start;
}

.orders-content{
    display:flex;
    flex-direction:column;
    gap:18px;
}

.orders-toolbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:20px;
    flex-wrap:wrap;
}

.order-tabs{
    display:flex;
    gap:12px;
    flex-wrap:wrap;
}

.order-tabs button{
    border:1px solid #eadfcf;
    background:#fff;
    color:#111;
    border-radius:10px;
    padding:12px 18px;
    font-weight:900;
    cursor:pointer;
}

.order-tabs .active-tab,
.order-tabs button:hover{
    background:#111;
    color:#fff;
    border-color:#111;
}

.sort-box{
    display:flex;
    align-items:center;
    gap:10px;
}

.sort-box label{
    font-weight:900;
    color:#555;
}

.sort-box select{
    height:44px;
    border:1px solid #eadfcf;
    border-radius:10px;
    padding:0 14px;
    outline:none;
    background:#fff;
    font-weight:800;
}

/* IMPROVED ORDER CARD */

.order-card{
    background:rgba(255,255,255,0.96);
    border:1px solid #eadfcf;
    border-radius:22px;
    padding:26px;
    display:grid;
    grid-template-columns:minmax(0, 1fr) 210px;
    grid-template-areas:
        "orderInfo orderActions"
        "orderProgress orderActions";
    gap:24px 30px;
    align-items:center;
    box-shadow:0 18px 55px rgba(0,0,0,0.08);
    position:relative;
    overflow:hidden;
    transition:0.3s;
}

.order-card::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    width:6px;
    height:100%;
    background:linear-gradient(180deg,#d2a33f,#b47a18);
}

.order-card:hover{
    transform:translateY(-5px);
    box-shadow:0 25px 70px rgba(0,0,0,0.12);
}

.order-left{
    grid-area:orderInfo;
    display:grid;
    grid-template-columns:115px minmax(0, 1fr);
    gap:22px;
    align-items:center;
    min-width:0;
}

.order-product-icon{
    width:115px;
    height:115px;
    border-radius:22px;
    background:
        radial-gradient(circle at 75% 20%, rgba(200,155,60,0.22), transparent 35%),
        #f2e4d0;
    color:#c89b3c;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:48px;
    box-shadow:0 12px 30px rgba(200,155,60,0.18);
}

.order-basic-info h3{
    font-size:26px;
    line-height:1.2;
    color:#111;
    margin-bottom:8px;
    font-weight:900;
}

.order-id{
    color:#444;
    font-size:15px;
    font-weight:900;
    margin-bottom:14px;
}

.order-meta{
    display:flex;
    align-items:center;
    gap:12px;
    flex-wrap:wrap;
    margin-bottom:12px;
}

.order-meta span{
    background:#fffaf2;
    border:1px solid #eadfcf;
    color:#444;
    padding:8px 12px;
    border-radius:30px;
    font-size:14px;
    font-weight:700;
}

.order-meta i,
.order-address i{
    color:#c89b3c;
    margin-right:6px;
}

.order-address{
    color:#555;
    font-size:14px;
    line-height:1.6;
    max-width:620px;
}

/* PROGRESS */

.order-progress-area{
    grid-area:orderProgress;
    background:#fffaf2;
    border:1px solid #eadfcf;
    border-radius:18px;
    padding:22px 20px;
}

.order-progress{
    display:flex;
    align-items:flex-start;
    justify-content:space-between;
    width:100%;
}

.progress-step{
    width:92px;
    text-align:center;
}

.progress-step span{
    width:42px;
    height:42px;
    border-radius:50%;
    background:#eee;
    color:#aaa;
    display:flex;
    align-items:center;
    justify-content:center;
    margin:0 auto 9px;
    font-size:15px;
    border:3px solid #fff;
    box-shadow:0 6px 18px rgba(0,0,0,0.08);
}

.step-active span{
    background:#c89b3c;
    color:#fff;
}

.progress-step h5{
    font-size:13px;
    color:#111;
    font-weight:900;
    margin-bottom:4px;
}

.progress-step p{
    color:#777;
    font-size:12px;
}

.progress-line{
    flex:1;
    height:3px;
    background:#ddd;
    margin-top:20px;
    border-radius:20px;
}

.line-active{
    background:#c89b3c;
}

/* CANCELLED */

.cancelled-message{
    grid-area:orderProgress;
    background:#fff0f0;
    border:1px solid #ffd1d1;
    border-radius:18px;
    padding:22px;
    display:flex;
    gap:16px;
    align-items:center;
    color:#d63031;
}

.cancelled-message i{
    font-size:34px;
}

.cancelled-message h4{
    color:#111;
    margin-bottom:5px;
    font-size:18px;
}

.cancelled-message p{
    color:#666;
    font-size:14px;
}

/* ACTIONS */

.order-actions-area{
    grid-area:orderActions;
    height:100%;
    display:flex;
    flex-direction:column;
    justify-content:center;
    gap:16px;
    align-items:stretch;
    background:#fff;
    border-left:1px solid #eadfcf;
    padding-left:24px;
}

.status-badge{
    height:44px;
    border-radius:12px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:14px;
    font-weight:900;
    letter-spacing:0.5px;
    text-transform:uppercase;
}

.status-badge.delivered{
    background:#e9f8ec;
    color:#16853a;
}

.status-badge.shipped{
    background:#fff4d8;
    color:#b47a18;
}

.status-badge.processing,
.status-badge.placed{
    background:#eef4ff;
    color:#2956b8;
}

.status-badge.cancelled{
    background:#fff0f0;
    color:#d63031;
}

.order-action-buttons{
    display:flex;
    flex-direction:column;
    gap:12px;
}

.view-order-btn,
.buy-again-btn,
.track-btn{
    width:100%;
    height:46px;
    border-radius:12px;
    text-decoration:none;
    display:flex;
    align-items:center;
    justify-content:center;
    gap:9px;
    font-size:14px;
    font-weight:900;
    transition:0.3s ease;
}

.view-order-btn{
    background:#fff;
    color:#111;
    border:1px solid #ddd;
}

.buy-again-btn,
.track-btn{
    background:#111;
    color:#fff;
}

.view-order-btn:hover{
    border-color:#c89b3c;
    color:#c89b3c;
}

.buy-again-btn:hover,
.track-btn:hover{
    background:#c89b3c;
}

/* EMPTY */

.empty-orders{
    background:#fff;
    border:1px solid #eadfcf;
    border-radius:20px;
    padding:75px 40px;
    text-align:center;
    box-shadow:0 18px 50px rgba(0,0,0,0.08);
}

.empty-orders-icon{
    width:120px;
    height:120px;
    border-radius:50%;
    background:#f2e4d0;
    color:#c89b3c;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:52px;
    margin:0 auto 24px;
}

.empty-orders h2{
    font-size:36px;
    margin-bottom:14px;
}

.empty-orders p{
    color:#555;
    line-height:1.7;
    max-width:520px;
    margin:0 auto 28px;
}

.empty-orders a{
    text-decoration:none;
    background:linear-gradient(135deg,#d2a33f,#b47a18);
    color:#fff;
    padding:15px 28px;
    border-radius:10px;
    font-weight:900;
    display:inline-flex;
    gap:10px;
    align-items:center;
}

/* SIDEBAR */

.orders-sidebar{
    display:flex;
    flex-direction:column;
    gap:18px;
    position:sticky;
    top:115px;
}

.summary-card,
.help-card,
.policy-card{
    background:#fff;
    border:1px solid #eadfcf;
    border-radius:18px;
    padding:24px;
    box-shadow:0 14px 40px rgba(0,0,0,0.07);
}

.sidebar-title{
    display:flex;
    align-items:center;
    gap:12px;
    margin-bottom:20px;
}

.sidebar-title i{
    color:#c89b3c;
    font-size:24px;
}

.sidebar-title h3{
    font-size:20px;
}

.summary-row{
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:12px 0;
    border-bottom:1px solid #f1e5d6;
    color:#444;
}

.summary-row strong{
    color:#111;
}

.total-spent strong{
    color:#c89b3c;
}

.sidebar-dark-btn{
    margin-top:18px;
    height:46px;
    background:#111;
    color:#fff;
    border-radius:9px;
    text-decoration:none;
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:900;
}

.help-icon{
    width:56px;
    height:56px;
    border-radius:50%;
    border:2px solid #c89b3c;
    color:#c89b3c;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:25px;
    margin-bottom:16px;
}

.help-card h3{
    font-size:22px;
    margin-bottom:8px;
}

.help-card > p{
    color:#555;
    line-height:1.6;
    margin-bottom:16px;
}

.help-info{
    display:flex;
    flex-direction:column;
    gap:11px;
}

.help-info span{
    color:#444;
    font-size:14px;
}

.help-info i{
    color:#c89b3c;
    margin-right:8px;
}

.policy-card{
    display:flex;
    flex-direction:column;
    gap:22px;
}

.policy-item{
    display:grid;
    grid-template-columns:48px 1fr;
    gap:14px;
    align-items:center;
}

.policy-item i{
    width:48px;
    height:48px;
    border-radius:13px;
    background:#f2e4d0;
    color:#c89b3c;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:22px;
}

.policy-item h4{
    margin-bottom:5px;
}

.policy-item p{
    color:#666;
    font-size:14px;
}

/* BOTTOM FEATURES */

.orders-bottom-features{
    max-width:1320px;
    margin:28px auto 0;
    padding:26px 35px;
    background:#fff;
    border:1px solid #eadfcf;
    border-radius:18px;
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:24px;
    box-shadow:0 14px 40px rgba(0,0,0,0.07);
}

.bottom-feature{
    display:flex;
    align-items:center;
    gap:16px;
    border-right:1px solid #eadfcf;
}

.bottom-feature:last-child{
    border-right:none;
}

.bottom-feature i{
    font-size:34px;
    color:#c89b3c;
}

.bottom-feature h4{
    font-size:16px;
    margin-bottom:5px;
}

.bottom-feature p{
    color:#666;
    font-size:14px;
}

/* FOOTER CSS FIX */

.nf-main-footer{
    background:#0e0e0e;
    color:#fff;
    padding:60px 55px 0;
    position:relative;
    overflow:hidden;
}

.nf-footer-container{
    max-width:1280px;
    margin:0 auto;
    display:grid;
    grid-template-columns:1.4fr 1fr 1fr 1fr 1.4fr;
    gap:42px;
    padding-bottom:45px;
}

.nf-footer-logo{
    text-decoration:none;
    color:#fff;
    font-size:32px;
    font-weight:900;
    letter-spacing:4px;
    line-height:1;
}

.nf-footer-logo span{
    color:#c89b3c;
}

.nf-footer-logo small{
    display:block;
    font-size:10px;
    letter-spacing:5px;
    margin-top:8px;
    color:#cfcfcf;
}

.nf-footer-brand p{
    color:#cfcfcf;
    line-height:1.8;
    margin:24px 0;
    font-size:15px;
}

.nf-footer-social{
    display:flex;
    gap:12px;
}

.nf-footer-social a{
    width:40px;
    height:40px;
    border-radius:50%;
    border:1px solid rgba(200,155,60,0.45);
    color:#c89b3c;
    text-decoration:none;
    display:flex;
    align-items:center;
    justify-content:center;
}

.nf-footer-column h3,
.nf-footer-contact h3{
    color:#c89b3c;
    font-size:16px;
    letter-spacing:1px;
    margin-bottom:22px;
}

.nf-footer-column a{
    display:block;
    color:#ddd;
    text-decoration:none;
    margin-bottom:13px;
    font-size:15px;
}

.nf-footer-contact p{
    display:flex;
    align-items:flex-start;
    gap:12px;
    color:#ddd;
    margin-bottom:15px;
    font-size:15px;
    line-height:1.6;
}

.nf-footer-contact p i{
    color:#c89b3c;
    margin-top:3px;
}

.nf-newsletter{
    height:44px;
    display:flex;
    border:1px solid rgba(200,155,60,0.45);
    border-radius:8px;
    overflow:hidden;
    margin-top:18px;
}

.nf-newsletter input{
    flex:1;
    border:none;
    outline:none;
    background:#111;
    color:#fff;
    padding:0 14px;
}

.nf-newsletter button{
    width:50px;
    border:none;
    background:#c89b3c;
    color:#fff;
}

.nf-footer-bottom{
    max-width:1280px;
    margin:0 auto;
    border-top:1px solid rgba(255,255,255,0.12);
    padding:22px 0;
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:20px;
    color:#aaa;
    font-size:14px;
}

.nf-footer-bottom a{
    color:#aaa;
    text-decoration:none;
}

.nf-footer-bottom div{
    display:flex;
    gap:12px;
    align-items:center;
}

/* Old footer fallback */
.footer{
    background:#0e0e0e !important;
    color:#fff !important;
    text-align:center;
    padding:40px;
}

.footer h3{
    color:#c89b3c !important;
}

/* RESPONSIVE */

@media(max-width:1250px){

    .nf-main-nav{
        display:none;
    }

    .nf-nav-search{
        width:220px;
    }

    .orders-main{
        grid-template-columns:1fr;
    }

    .orders-sidebar{
        position:static;
        display:grid;
        grid-template-columns:repeat(3,1fr);
    }

    .order-card{
        grid-template-columns:1fr;
        grid-template-areas:
            "orderInfo"
            "orderProgress"
            "orderActions";
    }

    .order-actions-area{
        border-left:none;
        border-top:1px solid #eadfcf;
        padding-left:0;
        padding-top:20px;
    }

    .order-action-buttons{
        flex-direction:row;
    }

    .nf-footer-container{
        grid-template-columns:repeat(3,1fr);
    }
}

@media(max-width:900px){

    .nf-top-offer-bar{
        display:none;
    }

    .nf-main-header{
        min-height:auto;
        padding:22px 25px;
        flex-direction:column;
        align-items:flex-start;
        position:relative;
    }

    .nf-header-actions{
        width:100%;
        flex-wrap:wrap;
    }

    .nf-nav-search{
        width:100%;
        order:1;
    }

    .orders-hero{
        padding:50px 28px;
        flex-direction:column;
        align-items:flex-start;
    }

    .orders-hero h1{
        font-size:40px;
    }

    .orders-hero-visual{
        width:260px;
        height:170px;
    }

    .orders-stats{
        grid-template-columns:1fr 1fr;
        margin:25px auto;
    }

    .orders-main{
        padding:0 20px;
    }

    .orders-sidebar{
        grid-template-columns:1fr;
    }

    .order-left{
        grid-template-columns:1fr;
    }

    .order-product-icon{
        width:100%;
        height:135px;
    }

    .order-progress-area{
        overflow-x:auto;
    }

    .order-progress{
        min-width:620px;
    }

    .order-action-buttons{
        flex-direction:column;
    }

    .orders-bottom-features{
        margin:24px 20px 0;
        grid-template-columns:1fr 1fr;
    }

    .bottom-feature{
        border-right:none;
    }

    .nf-footer-container{
        grid-template-columns:1fr;
    }

    .nf-footer-bottom{
        flex-direction:column;
        text-align:center;
    }
}

@media(max-width:560px){

    .orders-hero{
        padding:42px 20px;
    }

    .orders-hero h1{
        font-size:32px;
    }

    .orders-hero p{
        font-size:15px;
    }

    .orders-hero-buttons{
        flex-direction:column;
    }

    .gold-btn,
    .outline-gold-btn{
        width:100%;
    }

    .orders-stats{
        grid-template-columns:1fr;
        padding:0 18px;
    }

    .orders-main{
        padding:0 14px;
    }

    .orders-toolbar{
        align-items:flex-start;
    }

    .order-tabs{
        width:100%;
        display:grid;
        grid-template-columns:1fr;
    }

    .sort-box{
        width:100%;
    }

    .sort-box select{
        flex:1;
    }

    .order-card{
        padding:20px 16px;
    }

    .orders-bottom-features{
        grid-template-columns:1fr;
        margin:22px 14px 0;
    }

    .nf-site-logo{
        font-size:28px;
    }

    .nf-site-logo small{
        font-size:9px;
        letter-spacing:3px;
    }

    .nf-main-footer{
        padding:45px 25px 0;
    }
}
</style>

</head>

<body>

<jsp:include page="../partials/navbar.jsp"/>

<section class="orders-page">

    <section class="orders-hero">

        <div class="orders-hero-content">

            <p class="orders-mini-title">
                ORDER HISTORY
                <span></span>
            </p>

            <h1>Your <span>NovaFit</span> Orders</h1>

            <p>
                Track, manage and review all your orders in one place.
                We are here to deliver style, every step of the way.
            </p>

            <div class="orders-hero-buttons">
                <a href="<%= contextPath %>/products" class="gold-btn">
                    <i class="fa-solid fa-arrow-left"></i>
                    Continue Shopping
                </a>

                <a href="#ordersListArea" class="outline-gold-btn">
                    View Orders
                    <i class="fa-solid fa-arrow-down"></i>
                </a>
            </div>

        </div>

        <div class="orders-hero-visual">
            <div class="hero-ring ring-one"></div>
            <div class="hero-ring ring-two"></div>

            <div class="hero-bag">
                <i class="fa-solid fa-bag-shopping"></i>
            </div>

            <div class="hero-box">
                <i class="fa-solid fa-box"></i>
            </div>

            <div class="hero-location">
                <i class="fa-solid fa-location-dot"></i>
            </div>
        </div>

    </section>

    <section class="orders-stats">

        <div class="stat-card active-stat">
            <div class="stat-icon">
                <i class="fa-solid fa-bag-shopping"></i>
            </div>
            <div>
                <h2><%= totalOrders %></h2>
                <p>Total Orders</p>
                <span>All time orders</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fa-solid fa-circle-check"></i>
            </div>
            <div>
                <h2><%= deliveredOrders %></h2>
                <p>Delivered</p>
                <span>Successfully delivered</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fa-solid fa-truck-fast"></i>
            </div>
            <div>
                <h2><%= shippedOrders %></h2>
                <p>In Transit</p>
                <span>Orders on the way</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fa-solid fa-clock"></i>
            </div>
            <div>
                <h2><%= processingOrders %></h2>
                <p>Processing</p>
                <span>Being prepared</span>
            </div>
        </div>

    </section>

    <section class="orders-main" id="ordersListArea">

        <div class="orders-content">

            <div class="orders-toolbar">

                <div class="order-tabs">
                    <button class="active-tab">All Orders (<%= totalOrders %>)</button>
                    <button>Processing (<%= processingOrders %>)</button>
                    <button>Shipped (<%= shippedOrders %>)</button>
                    <button>Delivered (<%= deliveredOrders %>)</button>
                    <button>Cancelled (<%= cancelledOrders %>)</button>
                </div>

                <div class="sort-box">
                    <label>Sort by:</label>
                    <select>
                        <option>Most Recent</option>
                        <option>Oldest First</option>
                        <option>Highest Amount</option>
                    </select>
                </div>

            </div>

            <%
                if (orders != null && !orders.isEmpty()) {

                    for (Order order : orders) {

                        String orderStatus = normalizeStatus(order.getStatus());
                        String statusCss = statusClass(orderStatus);
                        int level = progressLevel(orderStatus);
                        boolean isCancelled = level == -1;
            %>

            <div class="order-card">

                <div class="order-left">

                    <div class="order-product-icon">
                        <i class="fa-solid fa-box-open"></i>
                    </div>

                    <div class="order-basic-info">
                        <h3>NovaFit Order #<%= order.getId() %></h3>

                        <p class="order-id">
                            Order ID: #NF<%= order.getId() %>
                        </p>

                        <div class="order-meta">
                            <span>
                                <i class="fa-regular fa-calendar"></i>
                                <%= formatDate(order.getCreatedAt()) %>
                            </span>

                            <span>
                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                ₹<%= amountFormat.format(order.getTotalAmount()) %>
                            </span>

                            <span>
                                <i class="fa-solid fa-credit-card"></i>
                                Paid Online
                            </span>
                        </div>

                        <p class="order-address">
                            <i class="fa-solid fa-location-dot"></i>
                            Delivery address linked with your NovaFit account
                        </p>
                    </div>

                </div>

                <% if (!isCancelled) { %>

                <div class="order-progress-area">

                    <div class="order-progress">

                        <div class="progress-step <%= level >= 1 ? "step-active" : "" %>">
                            <span><i class="fa-solid fa-check"></i></span>
                            <h5>Ordered</h5>
                            <p><%= formatDate(order.getCreatedAt()) %></p>
                        </div>

                        <div class="progress-line <%= level >= 2 ? "line-active" : "" %>"></div>

                        <div class="progress-step <%= level >= 2 ? "step-active" : "" %>">
                            <span><i class="fa-solid fa-box"></i></span>
                            <h5>Packed</h5>
                            <p>Processing</p>
                        </div>

                        <div class="progress-line <%= level >= 3 ? "line-active" : "" %>"></div>

                        <div class="progress-step <%= level >= 3 ? "step-active" : "" %>">
                            <span><i class="fa-solid fa-truck-fast"></i></span>
                            <h5>Shipped</h5>
                            <p>On the way</p>
                        </div>

                        <div class="progress-line <%= level >= 4 ? "line-active" : "" %>"></div>

                        <div class="progress-step <%= level >= 4 ? "step-active" : "" %>">
                            <span><i class="fa-solid fa-house-circle-check"></i></span>
                            <h5>Delivered</h5>
                            <p>Completed</p>
                        </div>

                    </div>

                </div>

                <% } else { %>

                <div class="cancelled-message">
                    <i class="fa-solid fa-circle-xmark"></i>
                    <div>
                        <h4>Order Cancelled</h4>
                        <p>This order was cancelled and is no longer active.</p>
                    </div>
                </div>

                <% } %>

                <div class="order-actions-area">

                    <span class="status-badge <%= statusCss %>">
                        <%= safe(orderStatus) %>
                    </span>

                    <div class="order-action-buttons">

                        <a href="#" class="view-order-btn">
                            <i class="fa-regular fa-eye"></i>
                            View Details
                        </a>

                        <% if (level == 4) { %>

                        <a href="<%= contextPath %>/products" class="buy-again-btn">
                            <i class="fa-solid fa-rotate-right"></i>
                            Buy Again
                        </a>

                        <% } else if (!isCancelled) { %>

                        <a href="#" class="track-btn">
                            <i class="fa-solid fa-location-crosshairs"></i>
                            Track Order
                        </a>

                        <% } else { %>

                        <a href="<%= contextPath %>/products" class="buy-again-btn">
                            <i class="fa-solid fa-bag-shopping"></i>
                            Shop Again
                        </a>

                        <% } %>

                    </div>

                </div>

            </div>

            <%
                    }
                } else {
            %>

            <div class="empty-orders">

                <div class="empty-orders-icon">
                    <i class="fa-solid fa-box-open"></i>
                </div>

                <h2>No orders placed yet</h2>

                <p>
                    You have not placed any orders yet. Explore NovaFit products
                    and start your fashion journey today.
                </p>

                <a href="<%= contextPath %>/products">
                    Shop Now
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

            </div>

            <%
                }
            %>

        </div>

        <aside class="orders-sidebar">

            <div class="summary-card">

                <div class="sidebar-title">
                    <i class="fa-regular fa-clipboard"></i>
                    <h3>Order Summary</h3>
                </div>

                <div class="summary-row">
                    <span>Total Orders</span>
                    <strong><%= totalOrders %></strong>
                </div>

                <div class="summary-row">
                    <span>Delivered</span>
                    <strong><%= deliveredOrders %></strong>
                </div>

                <div class="summary-row">
                    <span>In Transit</span>
                    <strong><%= shippedOrders %></strong>
                </div>

                <div class="summary-row">
                    <span>Processing</span>
                    <strong><%= processingOrders %></strong>
                </div>

                <div class="summary-row">
                    <span>Cancelled</span>
                    <strong><%= cancelledOrders %></strong>
                </div>

                <div class="summary-row total-spent">
                    <span>Total Spent</span>
                    <strong>₹<%= amountFormat.format(totalSpent) %></strong>
                </div>

                <a href="<%= contextPath %>/products" class="sidebar-dark-btn">
                    Shop More
                </a>

            </div>

            <div class="help-card">

                <div class="help-icon">
                    <i class="fa-solid fa-headset"></i>
                </div>

                <h3>Need Help?</h3>
                <p>We are here to assist you with your orders.</p>

                <div class="help-info">
                    <span>
                        <i class="fa-solid fa-phone"></i>
                        +91 98765 43210
                    </span>

                    <span>
                        <i class="fa-regular fa-envelope"></i>
                        support@novafit.com
                    </span>

                    <span>
                        <i class="fa-regular fa-clock"></i>
                        Mon - Sat, 9:00 AM - 8:00 PM
                    </span>
                </div>

            </div>

            <div class="policy-card">

                <div class="policy-item">
                    <i class="fa-solid fa-rotate-left"></i>
                    <div>
                        <h4>Easy Returns</h4>
                        <p>7 days return policy</p>
                    </div>
                </div>

                <div class="policy-item">
                    <i class="fa-solid fa-shield-halved"></i>
                    <div>
                        <h4>Secure Shopping</h4>
                        <p>Your data is protected</p>
                    </div>
                </div>

            </div>

        </aside>

    </section>

    <section class="orders-bottom-features">

        <div class="bottom-feature">
            <i class="fa-solid fa-lock"></i>
            <div>
                <h4>Secure Payments</h4>
                <p>100% secure transactions</p>
            </div>
        </div>

        <div class="bottom-feature">
            <i class="fa-solid fa-rotate-left"></i>
            <div>
                <h4>Easy Returns</h4>
                <p>Hassle-free returns</p>
            </div>
        </div>

        <div class="bottom-feature">
            <i class="fa-solid fa-headset"></i>
            <div>
                <h4>Premium Support</h4>
                <p>Dedicated customer support</p>
            </div>
        </div>

        <div class="bottom-feature">
            <i class="fa-solid fa-award"></i>
            <div>
                <h4>Original Products</h4>
                <p>Authentic & quality assured</p>
            </div>
        </div>

    </section>

</section>

<jsp:include page="../partials/footer.jsp"/>

</body>
</html>