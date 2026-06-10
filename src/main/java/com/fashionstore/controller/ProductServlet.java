package com.fashionstore.controller;

import java.io.IOException;
import java.util.List;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String categoryIdParam = request.getParameter("categoryId");
        String minPriceParam = request.getParameter("minPrice");
        String maxPriceParam = request.getParameter("maxPrice");

        List<Product> products;

        if (keyword != null && !keyword.trim().isEmpty()) {

            products = productDAO.searchProducts(keyword);

        } else if (categoryIdParam != null && !categoryIdParam.trim().isEmpty()) {

            int categoryId = Integer.parseInt(categoryIdParam);
            products = productDAO.getProductsByCategory(categoryId);

        } else if (minPriceParam != null && maxPriceParam != null
                && !minPriceParam.trim().isEmpty()
                && !maxPriceParam.trim().isEmpty()) {

            double minPrice = Double.parseDouble(minPriceParam);
            double maxPrice = Double.parseDouble(maxPriceParam);

            products = productDAO.getProductsByPriceRange(minPrice, maxPrice);

        } else {

            products = productDAO.getAllProducts();
        }

        request.setAttribute("products", products);

        request.getRequestDispatcher("/WEB-INF/views/user/products.jsp")
               .forward(request, response);
    }
}