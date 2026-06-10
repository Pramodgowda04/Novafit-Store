package com.fashionstore.model;

public class ProductSize {

    private int id;
    private int productId;
    private String size;
    private int stock;

    // DEFAULT CONSTRUCTOR
    public ProductSize() {

    }

    // PARAMETERIZED CONSTRUCTOR
    public ProductSize(int id, int productId, String size, int stock) {

        this.id = id;
        this.productId = productId;
        this.size = size;
        this.stock = stock;
    }

    // GET ID
    public int getId() {
        return id;
    }

    // SET ID
    public void setId(int id) {
        this.id = id;
    }

    // GET PRODUCT ID
    public int getProductId() {
        return productId;
    }

    // SET PRODUCT ID
    public void setProductId(int productId) {
        this.productId = productId;
    }

    // GET SIZE
    public String getSize() {
        return size;
    }

    // SET SIZE
    public void setSize(String size) {
        this.size = size;
    }

    // GET STOCK
    public int getStock() {
        return stock;
    }

    // SET STOCK
    public void setStock(int stock) {
        this.stock = stock;
    }
}