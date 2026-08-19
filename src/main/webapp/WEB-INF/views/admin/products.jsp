<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.fashionstore.model.Product,com.fashionstore.model.Category"%>

<%
    String contextPath = request.getContextPath();
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<Category> categories = (List<Category>) request.getAttribute("categories");

    String adminMessage = (String) session.getAttribute("adminMessage");
    if (adminMessage != null) {
        session.removeAttribute("adminMessage");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Product Inventory - NOVAFIT</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
* { margin:0; padding:0; box-sizing:border-box; font-family: Arial, Helvetica, sans-serif; }

body {
    background: #0f1115;
    color: #e5e5e5;
    min-height: 100vh;
}

.admin-header {
    background: #161920;
    border-bottom: 1px solid rgba(200, 155, 60, 0.3);
    padding: 18px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.admin-logo {
    font-size: 1.6rem;
    font-weight: 900;
    color: #ffffff;
    letter-spacing: 2px;
    text-decoration: none;
}
.admin-logo span { color: #c89b3c; }

.admin-nav {
    display: flex;
    gap: 15px;
    align-items: center;
}
.admin-nav a {
    color: #ddd;
    text-decoration: none;
    font-weight: 700;
    font-size: 0.9rem;
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 8px 16px;
    border-radius: 20px;
    transition: 0.3s ease;
}
.admin-nav a:hover, .admin-nav a.active {
    background: rgba(200, 155, 60, 0.2);
    color: #c89b3c;
}

.admin-container {
    max-width: 1350px;
    margin: 35px auto;
    padding: 0 20px;
}

.title-actions-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.title-actions-bar h2 {
    font-size: 1.8rem;
    font-weight: 900;
    color: #fff;
}
.title-actions-bar h2 span { color: #c89b3c; }

.btn-add-product {
    background: linear-gradient(135deg, #c89b3c, #b47a18);
    color: #fff;
    border: none;
    padding: 12px 26px;
    border-radius: 25px;
    font-weight: 800;
    font-size: 0.95rem;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 10px;
    box-shadow: 0 10px 25px rgba(200, 155, 60, 0.3);
    transition: 0.3s ease;
}
.btn-add-product:hover {
    transform: translateY(-2px);
    box-shadow: 0 15px 35px rgba(200, 155, 60, 0.45);
}

/* FILTER TABS */
.filter-bar {
    display: flex;
    gap: 12px;
    margin-bottom: 30px;
    overflow-x: auto;
    padding-bottom: 8px;
}

.filter-tab {
    background: #161920;
    color: #aaa;
    border: 1px solid rgba(255,255,255,0.08);
    padding: 10px 22px;
    border-radius: 25px;
    font-weight: 700;
    font-size: 0.88rem;
    cursor: pointer;
    text-decoration: none;
    transition: 0.3s ease;
    display: inline-block;
}
.filter-tab:hover, .filter-tab.active {
    background: #c89b3c;
    color: #111;
    border-color: #c89b3c;
}

/* PRODUCTS GRID */
.products-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 25px;
}

.product-card {
    background: #161920;
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    display: flex;
    flex-direction: column;
    transition: all 0.3s ease;
}
.product-card:hover {
    border-color: rgba(200, 155, 60, 0.4);
    transform: translateY(-5px);
}

.product-img-box {
    position: relative;
    width: 100%;
    height: 240px;
    background: #090a0d;
    overflow: hidden;
}
.product-img-box img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.product-id-badge {
    position: absolute;
    top: 12px;
    left: 12px;
    background: rgba(0, 0, 0, 0.7);
    color: #c89b3c;
    padding: 4px 12px;
    border-radius: 15px;
    font-size: 0.78rem;
    font-weight: 800;
    border: 1px solid rgba(200, 155, 60, 0.4);
}

.product-details-body {
    padding: 20px;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
}

.product-title {
    font-size: 1.1rem;
    font-weight: 800;
    color: #fff;
    margin-bottom: 8px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.product-desc {
    color: #888;
    font-size: 0.85rem;
    line-height: 1.4;
    margin-bottom: 15px;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.price-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: auto;
    padding-top: 15px;
    border-top: 1px solid rgba(255, 255, 255, 0.08);
}

.price-val {
    font-size: 1.3rem;
    font-weight: 900;
    color: #c89b3c;
}

.card-action-btns {
    display: flex;
    gap: 10px;
    margin-top: 15px;
}

.btn-edit-item {
    flex: 1;
    background: rgba(200, 155, 60, 0.15);
    color: #c89b3c;
    border: 1px solid rgba(200, 155, 60, 0.4);
    padding: 8px;
    border-radius: 14px;
    font-weight: 800;
    font-size: 0.85rem;
    cursor: pointer;
    transition: 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
}
.btn-edit-item:hover { background: #c89b3c; color: #111; }

.btn-delete-item {
    background: rgba(220, 53, 69, 0.15);
    color: #dc3545;
    border: 1px solid rgba(220, 53, 69, 0.4);
    padding: 8px 14px;
    border-radius: 14px;
    font-weight: 800;
    font-size: 0.85rem;
    cursor: pointer;
    transition: 0.3s ease;
}
.btn-delete-item:hover { background: #dc3545; color: #fff; }

/* MODAL STYLES */
.modal-overlay {
    position: fixed;
    top: 0; left: 0; width: 100%; height: 100%;
    background: rgba(0, 0, 0, 0.8);
    backdrop-filter: blur(8px);
    display: none;
    align-items: center;
    justify-content: center;
    z-index: 10000;
    padding: 20px;
}
.modal-overlay.active { display: flex; }

.modal-box {
    background: #161920;
    border: 1.5px solid rgba(200, 155, 60, 0.4);
    border-radius: 24px;
    width: 100%;
    max-width: 520px;
    padding: 30px;
    box-shadow: 0 25px 80px rgba(0,0,0,0.8);
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 12px;
    border-bottom: 1px solid rgba(255,255,255,0.08);
}
.modal-header h3 { color: #fff; font-size: 1.3rem; font-weight: 900; }
.modal-header h3 span { color: #c89b3c; }
.modal-close { background: none; border: none; color: #888; font-size: 1.4rem; cursor: pointer; }
.modal-close:hover { color: #fff; }

.form-group { margin-bottom: 16px; text-align: left; }
.form-group label { display: block; font-size: 0.82rem; font-weight: 700; color: #c89b3c; margin-bottom: 6px; }
.form-group input, .form-group select, .form-group textarea {
    width: 100%;
    background: #0f1115;
    border: 1px solid rgba(255,255,255,0.12);
    color: #fff;
    padding: 12px 14px;
    border-radius: 12px;
    font-size: 0.9rem;
    outline: none;
}
.form-group input:focus, .form-group select:focus, .form-group textarea:focus { border-color: #c89b3c; }

.btn-modal-submit {
    width: 100%;
    background: linear-gradient(135deg, #c89b3c, #b47a18);
    color: #fff;
    border: none;
    padding: 14px;
    border-radius: 14px;
    font-weight: 900;
    font-size: 0.98rem;
    cursor: pointer;
    margin-top: 10px;
}

/* TOAST */
.admin-toast {
    position: fixed;
    bottom: 30px;
    right: 30px;
    background: #c89b3c;
    color: #111;
    padding: 14px 24px;
    border-radius: 30px;
    font-weight: 900;
    box-shadow: 0 10px 30px rgba(0,0,0,0.5);
    z-index: 9999;
}

</style>
</head>

<body>

<!-- ADMIN HEADER -->
<header class="admin-header">
    <a href="<%= contextPath %>/admin/products" class="admin-logo">
        NOVA<span>FIT</span> <small style="font-size: 0.6rem; letter-spacing: 2px; color:#888;">ADMIN PANEL</small>
    </a>

    <nav class="admin-nav">
        <a href="javascript:history.back()" style="background:rgba(255,255,255,0.08); color:#fff;">
            <i class="fa-solid fa-arrow-left"></i> Back
        </a>
        <a href="<%= contextPath %>/admin/orders">
            <i class="fa-solid fa-boxes-stacked"></i> Orders
        </a>
        <a href="<%= contextPath %>/admin/products" class="active">
            <i class="fa-solid fa-shirt"></i> Product Inventory
        </a>
        <a href="<%= contextPath %>/products">
            <i class="fa-solid fa-store"></i> Storefront
        </a>
        <a href="<%= contextPath %>/admin/logout">
            <i class="fa-solid fa-right-from-bracket"></i> Logout
        </a>
    </nav>
</header>

<div class="admin-container">

    <!-- TITLE & ADD BUTTON -->
    <div class="title-actions-bar">
        <h2>Product Inventory & <span>Price Management</span> 🛍️</h2>
        <button class="btn-add-product" onclick="openAddModal()">
            <i class="fa-solid fa-plus"></i> Add New Product
        </button>
    </div>

    <!-- FILTER TABS BY CATEGORY -->
    <div class="filter-bar">
        <a href="<%= contextPath %>/admin/products" class="filter-tab <%= request.getParameter("categoryId") == null ? "active" : "" %>">ALL PRODUCTS</a>
        <a href="<%= contextPath %>/admin/products?categoryId=1" class="filter-tab <%= "1".equals(request.getParameter("categoryId")) ? "active" : "" %>">MEN</a>
        <a href="<%= contextPath %>/admin/products?categoryId=2" class="filter-tab <%= "2".equals(request.getParameter("categoryId")) ? "active" : "" %>">WOMEN</a>
        <a href="<%= contextPath %>/admin/products?categoryId=3" class="filter-tab <%= "3".equals(request.getParameter("categoryId")) ? "active" : "" %>">KIDS</a>
        <a href="<%= contextPath %>/admin/products?categoryId=4" class="filter-tab <%= "4".equals(request.getParameter("categoryId")) ? "active" : "" %>">FOOTWEAR</a>
        <a href="<%= contextPath %>/admin/products?categoryId=5" class="filter-tab <%= "5".equals(request.getParameter("categoryId")) ? "active" : "" %>">ACCESSORIES</a>
    </div>

    <!-- PRODUCTS GRID -->
    <div class="products-grid">
        <% if (products != null && !products.isEmpty()) {
            for (Product p : products) {
                String imgPath = p.getImage();
                if (imgPath == null || imgPath.trim().isEmpty()) {
                    imgPath = "assets/images/default-product.jpg";
                }
                if (!imgPath.startsWith("http") && !imgPath.startsWith("/")) {
                    imgPath = contextPath + "/" + imgPath;
                }
        %>
            <div class="product-card">
                <div class="product-img-box">
                    <img src="<%= imgPath %>" alt="<%= p.getName() %>" onerror="this.src='https://images.unsplash.com/photo-1523381210434-271e8be1f52b?w=500'">
                    <span class="product-id-badge">ID #<%= p.getId() %></span>
                </div>

                <div class="product-details-body">
                    <h3 class="product-title"><%= p.getName() %></h3>
                    <p class="product-desc"><%= p.getDescription() != null ? p.getDescription() : "High quality premium NovaFit apparel." %></p>

                    <div class="price-row">
                        <span style="font-size:0.8rem; color:#888; text-transform:uppercase;">Price</span>
                        <span class="price-val">₹ <%= String.format("%.2f", p.getPrice()) %></span>
                    </div>

                    <div class="card-action-btns">
                        <button class="btn-edit-item" 
                                onclick="openEditModal(<%= p.getId() %>, '<%= p.getName().replace("'", "\\'") %>', '<%= p.getDescription() != null ? p.getDescription().replace("'", "\\'").replace("\n", " ") : "" %>', <%= p.getPrice() %>, <%= p.getCategoryId() %>, '<%= p.getImage() != null ? p.getImage().replace("'", "\\'") : "" %>')">
                            <i class="fa-solid fa-pen-to-square"></i> Edit Price & Details
                        </button>

                        <form action="<%= contextPath %>/admin/products" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete <%= p.getName() %>?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= p.getId() %>">
                            <button type="submit" class="btn-delete-item" title="Delete Product">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        <% } } else { %>
            <div style="grid-column: 1 / -1; text-align:center; padding:60px; background:#161920; border-radius:20px;">
                <h3>No Products Found in This Category</h3>
            </div>
        <% } %>
    </div>

</div>

<!-- ADD PRODUCT MODAL -->
<div class="modal-overlay" id="addModal">
    <div class="modal-box">
        <div class="modal-header">
            <h3>Add New <span>Product</span> 🛍️</h3>
            <button class="modal-close" onclick="closeModal('addModal')">&times;</button>
        </div>
        <form action="<%= contextPath %>/admin/products" method="post">
            <input type="hidden" name="action" value="add">

            <div class="form-group">
                <label>PRODUCT TITLE</label>
                <input type="text" name="name" placeholder="e.g. Classic Oversized Hoodie" required>
            </div>

            <div class="form-group">
                <label>PRICE (₹)</label>
                <input type="number" step="0.01" name="price" placeholder="1499.00" required>
            </div>

            <div class="form-group">
                <label>CATEGORY</label>
                <select name="categoryId" required>
                    <option value="1">Men's Fashion</option>
                    <option value="2">Women's Fashion</option>
                    <option value="3">Kids Collection</option>
                    <option value="4">Footwear</option>
                    <option value="5">Accessories</option>
                </select>
            </div>

            <div class="form-group">
                <label>IMAGE PATH / URL</label>
                <input type="text" name="image" placeholder="assets/images/products/men1.jpg" required>
            </div>

            <div class="form-group">
                <label>DESCRIPTION</label>
                <textarea name="description" rows="3" placeholder="Enter product description..."></textarea>
            </div>

            <button type="submit" class="btn-modal-submit">ADD PRODUCT TO CATALOG 🚀</button>
        </form>
    </div>
</div>

<!-- EDIT PRODUCT MODAL -->
<div class="modal-overlay" id="editModal">
    <div class="modal-box">
        <div class="modal-header">
            <h3>Edit <span>Product Details</span> ✏️</h3>
            <button class="modal-close" onclick="closeModal('editModal')">&times;</button>
        </div>
        <form action="<%= contextPath %>/admin/products" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" id="editId">

            <div class="form-group">
                <label>PRODUCT TITLE</label>
                <input type="text" name="name" id="editName" required>
            </div>

            <div class="form-group">
                <label>PRICE (₹)</label>
                <input type="number" step="0.01" name="price" id="editPrice" required>
            </div>

            <div class="form-group">
                <label>CATEGORY</label>
                <select name="categoryId" id="editCategory" required>
                    <option value="1">Men's Fashion</option>
                    <option value="2">Women's Fashion</option>
                    <option value="3">Kids Collection</option>
                    <option value="4">Footwear</option>
                    <option value="5">Accessories</option>
                </select>
            </div>

            <div class="form-group">
                <label>IMAGE PATH / URL</label>
                <input type="text" name="image" id="editImage" required>
            </div>

            <div class="form-group">
                <label>DESCRIPTION</label>
                <textarea name="description" id="editDescription" rows="3"></textarea>
            </div>

            <button type="submit" class="btn-modal-submit">SAVE CHANGES 💾</button>
        </form>
    </div>
</div>

<% if (adminMessage != null) { %>
    <div class="admin-toast">
        <i class="fa-solid fa-crown"></i> <%= adminMessage %>
    </div>
    <script>
        setTimeout(() => {
            const toast = document.querySelector('.admin-toast');
            if (toast) toast.style.display = 'none';
        }, 3000);
    </script>
<% } %>

<script>
function openAddModal() {
    document.getElementById('addModal').classList.add('active');
}

function openEditModal(id, name, desc, price, catId, img) {
    document.getElementById('editId').value = id;
    document.getElementById('editName').value = name;
    document.getElementById('editDescription').value = desc;
    document.getElementById('editPrice').value = price;
    document.getElementById('editCategory').value = catId;
    document.getElementById('editImage').value = img;
    document.getElementById('editModal').classList.add('active');
}

function closeModal(modalId) {
    document.getElementById(modalId).classList.remove('active');
}
</script>

</body>
</html>
