package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.model.Product;
import com.fashionstore.util.DBConnection;
import com.fashionstore.util.ProductCache;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public List<Product> getProductsByPriceRange(double minPrice, double maxPrice) {
        List<Product> productList = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        if (conn == null) return productList;

        try {
            String sql = "SELECT * FROM products WHERE price BETWEEN ? AND ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDouble(1, minPrice);
            ps.setDouble(2, maxPrice);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setImage(rs.getString("image_url"));
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    @Override
    public boolean addProduct(Product product) {
        Connection conn = DBConnection.getConnection();
        if (conn == null) return false;

        try {
            String sql = "INSERT INTO products(name, description, price, category_id, image_url) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getCategoryId());
            ps.setString(5, product.getImage());

            boolean success = ps.executeUpdate() > 0;
            if (success) {
                ProductCache.clear();
            }
            return success;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Product getProductById(int productId) {
        Product cached = ProductCache.getSingle(productId);
        if (cached != null) {
            return cached;
        }

        Connection conn = DBConnection.getConnection();
        if (conn == null) return null;

        try {
            String sql = "SELECT * FROM products WHERE product_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setImage(rs.getString("image_url"));
                return product;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Product> getAllProducts() {
        List<Product> cached = ProductCache.get("all");
        if (cached != null && !cached.isEmpty()) {
            return cached;
        }

        List<Product> productList = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        if (conn == null) return productList;

        try {
            String sql = "SELECT * FROM products";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setImage(rs.getString("image_url"));
                productList.add(product);
            }
            ProductCache.put("all", productList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    @Override
    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> cached = ProductCache.get("cat_" + categoryId);
        if (cached != null && !cached.isEmpty()) {
            return cached;
        }

        List<Product> productList = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        if (conn == null) return productList;

        try {
            String sql = "SELECT * FROM products WHERE category_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setImage(rs.getString("image_url"));
                productList.add(product);
            }
            ProductCache.put("cat_" + categoryId, productList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    @Override
    public List<Product> searchProducts(String keyword) {
        List<Product> productList = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        if (conn == null) return productList;

        try {
            String sql = "SELECT * FROM products WHERE name LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setImage(rs.getString("image_url"));
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    @Override
    public boolean updateProduct(Product product) {
        Connection conn = DBConnection.getConnection();
        if (conn == null) return false;

        try {
            String sql = "UPDATE products SET name=?, description=?, price=?, category_id=?, image_url=? WHERE product_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getCategoryId());
            ps.setString(5, product.getImage());
            ps.setInt(6, product.getId());

            boolean success = ps.executeUpdate() > 0;
            if (success) {
                ProductCache.clear();
            }
            return success;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteProduct(int productId) {
        Connection conn = DBConnection.getConnection();
        if (conn == null) return false;

        try {
            String sql = "DELETE FROM products WHERE product_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);

            boolean success = ps.executeUpdate() > 0;
            if (success) {
                ProductCache.clear();
            }
            return success;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}