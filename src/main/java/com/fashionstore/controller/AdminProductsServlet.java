package com.fashionstore.controller;

import java.io.IOException;
import java.util.List;

import com.fashionstore.dao.CategoryDAO;
import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.CategoryDAOImpl;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Category;
import com.fashionstore.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/products")
public class AdminProductsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String catParam = request.getParameter("categoryId");
        List<Product> products;

        if (catParam != null && !catParam.trim().isEmpty()) {
            try {
                int catId = Integer.parseInt(catParam.trim());
                products = productDAO.getProductsByCategory(catId);
            } catch (Exception e) {
                products = productDAO.getAllProducts();
            }
        } else {
            products = productDAO.getAllProducts();
        }

        List<Category> categories = categoryDAO.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/WEB-INF/views/admin/products.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("add".equalsIgnoreCase(action)) {
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                String image = request.getParameter("image");

                if (image == null || image.trim().isEmpty()) {
                    image = "assets/images/default-product.jpg";
                }

                Product p = new Product();
                p.setName(name);
                p.setDescription(description);
                p.setPrice(price);
                p.setCategoryId(categoryId);
                p.setImage(image);

                boolean added = productDAO.addProduct(p);
                if (added) {
                    request.getSession().setAttribute("adminMessage", "Product '" + name + "' added successfully! 🛍️");
                }
            } else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                String image = request.getParameter("image");

                Product p = new Product();
                p.setId(id);
                p.setName(name);
                p.setDescription(description);
                p.setPrice(price);
                p.setCategoryId(categoryId);
                p.setImage(image);

                boolean updated = productDAO.updateProduct(p);
                if (updated) {
                    request.getSession().setAttribute("adminMessage", "Product #" + id + " updated successfully! ✏️");
                }
            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = productDAO.deleteProduct(id);
                if (deleted) {
                    request.getSession().setAttribute("adminMessage", "Product #" + id + " deleted! 🗑️");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("adminMessage", "Error processing request: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
