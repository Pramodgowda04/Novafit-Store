package com.fashionstore.dao;

import java.util.List;

import com.fashionstore.model.Product;

public interface ProductDAO {

    boolean addProduct(Product product);

    Product getProductById(int productId);

    List<Product> getAllProducts();

    List<Product> getProductsByCategory(int categoryId);

    List<Product> searchProducts(String keyword);
    
    List<Product> getProductsByPriceRange(double minPrice, double maxPrice);

    boolean updateProduct(Product product);

    boolean deleteProduct(int productId);
}