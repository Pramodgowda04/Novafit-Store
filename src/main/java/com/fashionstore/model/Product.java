package com.fashionstore.model;

public class Product {

    private int id;
    private String name;
    private String description;
    private double price;
    private int categoryId;
    private String image;

    // DEFAULT CONSTRUCTOR
    public Product() {

    }

    // PARAMETERIZED CONSTRUCTOR
    public Product(int id, String name, String description,
                   double price, int categoryId, String image) {

        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.categoryId = categoryId;
        this.image = image;
    }

    // GET ID
    public int getId() {
        return id;
    }

    // SET ID
    public void setId(int id) {
        this.id = id;
    }

    // GET NAME
    public String getName() {
        return name;
    }

    // SET NAME
    public void setName(String name) {
        this.name = name;
    }

    // GET DESCRIPTION
    public String getDescription() {
        return description;
    }

    // SET DESCRIPTION
    public void setDescription(String description) {
        this.description = description;
    }

    // GET PRICE
    public double getPrice() {
        return price;
    }

    // SET PRICE
    public void setPrice(double price) {
        this.price = price;
    }

    // GET CATEGORY ID
    public int getCategoryId() {
        return categoryId;
    }

    // SET CATEGORY ID
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    // GET IMAGE
    public String getImage() {
        return image;
    }

    // SET IMAGE
    public void setImage(String image) {
        this.image = image;
    }
}