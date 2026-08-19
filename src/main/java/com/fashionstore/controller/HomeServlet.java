package com.fashionstore.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> allProducts = null;
        try {
            allProducts = productDAO.getAllProducts();
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<Product> carouselProducts = new ArrayList<>();
        if (allProducts != null && !allProducts.isEmpty()) {
            List<Product> temp = new ArrayList<>(allProducts);
            Collections.shuffle(temp);
            int count = Math.min(15, temp.size());
            carouselProducts = temp.subList(0, count);
        }

        // Fallback sample 15 items if DB is empty or disconnected
        if (carouselProducts.isEmpty()) {
            carouselProducts.add(new Product(1, "Casual Shirt", "Stylish cotton shirt", 1299.0, 1, "assets/images/mens.png"));
            carouselProducts.add(new Product(2, "Floral Dress", "Summer floral print dress", 1899.0, 2, "assets/images/women.png"));
            carouselProducts.add(new Product(3, "Sneakers", "Comfortable sport sneakers", 2499.0, 4, "assets/images/footwear.png"));
            carouselProducts.add(new Product(4, "Leather Belt", "Classic genuine leather belt", 799.0, 5, "assets/images/accessories.png"));
            carouselProducts.add(new Product(5, "Denim Jacket", "Classic blue denim jacket", 2999.0, 1, "assets/images/mens.png"));
            carouselProducts.add(new Product(6, "Stylish Sunglasses", "UV protected trendy sunglasses", 999.0, 5, "assets/images/accessories.png"));
            carouselProducts.add(new Product(7, "Formal Trousers", "Slim fit formal trousers", 1599.0, 1, "assets/images/mens.png"));
            carouselProducts.add(new Product(8, "Graphic Hoodie", "Cozy winter fleece hoodie", 1999.0, 1, "assets/images/mens.png"));
            carouselProducts.add(new Product(9, "Elegant Handbag", "Premium leather shoulder bag", 2799.0, 5, "assets/images/accessories.png"));
            carouselProducts.add(new Product(10, "Running Shoes", "Lightweight mesh athletic shoes", 2199.0, 4, "assets/images/footwear.png"));
            carouselProducts.add(new Product(11, "Silk Saree", "Traditional ethnic silk saree", 3499.0, 2, "assets/images/women.png"));
            carouselProducts.add(new Product(12, "Leather Boots", "Rugged outdoor leather boots", 3999.0, 4, "assets/images/footwear.png"));
            carouselProducts.add(new Product(13, "Polo T-Shirt", "Classic solid polo t-shirt", 899.0, 1, "assets/images/mens.png"));
            carouselProducts.add(new Product(14, "Designer Watch", "Analog stainless steel watch", 4499.0, 5, "assets/images/accessories.png"));
            carouselProducts.add(new Product(15, "Kids Denim Jeans", "Durable stretch kids denim", 999.0, 3, "assets/images/footwear.png"));
        }

        request.setAttribute("carouselProducts", carouselProducts);

        request.getRequestDispatcher("/WEB-INF/views/user/home.jsp")
               .forward(request, response);
    }
}