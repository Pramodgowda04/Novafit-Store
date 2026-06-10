package com.fashionstore.model;

public class Category {

    private int id;
    private String categoryName;

    // DEFAULT CONSTRUCTOR
    public Category() {

    }

    // PARAMETERIZED CONSTRUCTOR
    public Category(int id, String categoryName) {

        this.id = id;
        this.categoryName = categoryName;
    }

    // GET ID
    public int getId() {
        return id;
    }

    // SET ID
    public void setId(int id) {
        this.id = id;
    }

    // GET CATEGORY NAME
    public String getCategoryName() {
        return categoryName;
    }

    // SET CATEGORY NAME
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}