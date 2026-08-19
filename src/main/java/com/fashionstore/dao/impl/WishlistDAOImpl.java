package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.WishlistDAO;
import com.fashionstore.model.Product;
import com.fashionstore.util.DBConnection;

public class WishlistDAOImpl implements WishlistDAO {

    private Connection conn = DBConnection.getConnection();
    private ProductDAO productDAO = new ProductDAOImpl();

    // In-memory fallback map for offline/disconnected DB mode: userId -> List<productId>
    private static final Map<Integer, List<Integer>> memoryWishlists = new ConcurrentHashMap<>();

    @Override
    public boolean addToWishlist(int userId, int productId) {
        if (conn != null) {
            try {
                // Ensure table exists
                createWishlistTableIfNotExists();

                String sql = "INSERT INTO wishlist (user_id, product_id) VALUES (?, ?) ON DUPLICATE KEY UPDATE added_at=CURRENT_TIMESTAMP";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                if (ps.executeUpdate() > 0) {
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Memory fallback
        List<Integer> list = memoryWishlists.computeIfAbsent(userId, k -> new ArrayList<>());
        if (!list.contains(productId)) {
            list.add(productId);
        }
        return true;
    }

    @Override
    public boolean removeFromWishlist(int userId, int productId) {
        if (conn != null) {
            try {
                String sql = "DELETE FROM wishlist WHERE user_id=? AND product_id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                if (ps.executeUpdate() > 0) {
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Memory fallback
        List<Integer> list = memoryWishlists.get(userId);
        if (list != null) {
            list.remove(Integer.valueOf(productId));
        }
        return true;
    }

    @Override
    public List<Product> getWishlistByUserId(int userId) {
        List<Product> wishlistProducts = new ArrayList<>();
        if (conn != null) {
            try {
                String sql = "SELECT p.* FROM products p JOIN wishlist w ON p.product_id = w.product_id WHERE w.user_id = ? ORDER BY w.added_at DESC";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getDouble("price"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setImage(rs.getString("image_url"));
                    wishlistProducts.add(p);
                }
                if (!wishlistProducts.isEmpty()) {
                    return wishlistProducts;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Memory fallback
        List<Integer> list = memoryWishlists.get(userId);
        if (list != null) {
            for (int pid : list) {
                Product p = productDAO.getProductById(pid);
                if (p != null) {
                    wishlistProducts.add(p);
                }
            }
        }
        return wishlistProducts;
    }

    @Override
    public boolean isInWishlist(int userId, int productId) {
        if (conn != null) {
            try {
                String sql = "SELECT 1 FROM wishlist WHERE user_id=? AND product_id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        List<Integer> list = memoryWishlists.get(userId);
        return list != null && list.contains(productId);
    }

    @Override
    public int getWishlistCount(int userId) {
        if (conn != null) {
            try {
                String sql = "SELECT COUNT(*) FROM wishlist WHERE user_id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        List<Integer> list = memoryWishlists.get(userId);
        return list == null ? 0 : list.size();
    }

    private void createWishlistTableIfNotExists() {
        if (conn != null) {
            try {
                String sql = "CREATE TABLE IF NOT EXISTS wishlist ("
                        + "wishlist_id INT AUTO_INCREMENT PRIMARY KEY, "
                        + "user_id INT NOT NULL, "
                        + "product_id INT NOT NULL, "
                        + "added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                        + "UNIQUE KEY unique_user_product (user_id, product_id)"
                        + ")";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.executeUpdate();
            } catch (Exception e) {
                // Ignore table creation error if already exists
            }
        }
    }
}
