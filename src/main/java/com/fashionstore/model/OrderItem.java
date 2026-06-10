package com.fashionstore.model;

public class OrderItem {

    private int id;
    private int orderId;
    private int productId;
    private String size;
    private int quantity;
    private double price;

    // DEFAULT CONSTRUCTOR
    public OrderItem() {

    }

    // GET ID
    public int getId() {
        return id;
    }

    // SET ID
    public void setId(int id) {
        this.id = id;
    }

    // GET ORDER ID
    public int getOrderId() {
        return orderId;
    }

    // SET ORDER ID
    public void setOrderId(int orderId) {
        this.orderId = orderId;
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

    // GET QUANTITY
    public int getQuantity() {
        return quantity;
    }

    // SET QUANTITY
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // GET PRICE
    public double getPrice() {
        return price;
    }

    // SET PRICE
    public void setPrice(double price) {
        this.price = price;
    }
}