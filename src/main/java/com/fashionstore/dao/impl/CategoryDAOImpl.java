package com.fashionstore.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionstore.dao.CategoryDAO;
import com.fashionstore.model.Category;
import com.fashionstore.util.DBConnection;

public class CategoryDAOImpl implements CategoryDAO {

    private Connection conn = DBConnection.getConnection();

    // ADD CATEGORY
    @Override
    public boolean addCategory(Category category) {

        try {

            String sql = "INSERT INTO categories(category_name) VALUES (?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, category.getCategoryName());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // GET CATEGORY BY ID
    @Override
    public Category getCategoryById(int categoryId) {

        try {

            String sql = "SELECT * FROM categories WHERE category_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Category category = new Category();

                category.setId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));

                return category;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // GET ALL CATEGORIES
    @Override
    public List<Category> getAllCategories() {

        List<Category> categoryList = new ArrayList<>();

        try {

            String sql = "SELECT * FROM categories";

            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Category category = new Category();

                category.setId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));

                categoryList.add(category);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categoryList;
    }

    // UPDATE CATEGORY
    @Override
    public boolean updateCategory(Category category) {

        try {

            String sql = "UPDATE categories SET category_name=? WHERE category_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, category.getCategoryName());
            ps.setInt(2, category.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // DELETE CATEGORY
    @Override
    public boolean deleteCategory(int categoryId) {

        try {

            String sql = "DELETE FROM categories WHERE category_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, categoryId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}