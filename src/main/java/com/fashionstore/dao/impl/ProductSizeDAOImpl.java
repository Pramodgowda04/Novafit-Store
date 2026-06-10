package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.ProductSizeDAO;
import com.fashionstore.model.ProductSize;
import com.fashionstore.util.DBConnection;

public class ProductSizeDAOImpl implements ProductSizeDAO {

    private Connection conn = DBConnection.getConnection();

    // ADD PRODUCT SIZE
    @Override
    public boolean addProductSize(ProductSize productSize) {

        try {

            String sql = "INSERT INTO product_sizes(product_id, size, stock) VALUES (?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, productSize.getProductId());
            ps.setString(2, productSize.getSize());
            ps.setInt(3, productSize.getStock());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // GET SIZES BY PRODUCT ID
    @Override
    public List<ProductSize> getSizesByProductId(int productId) {

        List<ProductSize> sizeList = new ArrayList<>();

        try {

            String sql = "SELECT * FROM product_sizes WHERE product_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                ProductSize productSize = new ProductSize();

                productSize.setId(rs.getInt("product_size_id"));
                productSize.setProductId(rs.getInt("product_id"));
                productSize.setSize(rs.getString("size"));
                productSize.setStock(rs.getInt("stock"));

                sizeList.add(productSize);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return sizeList;
    }

    // UPDATE STOCK
    @Override
    public boolean updateStock(int productSizeId, int stock) {

        try {

            String sql = "UPDATE product_sizes SET stock=? WHERE product_size_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, stock);
            ps.setInt(2, productSizeId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // DELETE PRODUCT SIZE
    @Override
    public boolean deleteProductSize(int productSizeId) {

        try {

            String sql = "DELETE FROM product_sizes WHERE product_size_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, productSizeId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}