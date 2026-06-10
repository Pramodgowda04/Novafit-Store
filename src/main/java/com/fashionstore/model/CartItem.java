package com.fashionstore.model;

public class CartItem {

    private int id;
    private int cartId;
    private int productId;
    private String size;
    private int quantity;

    // DEFAULT CONSTRUCTOR
    public CartItem() {

    }

    // GET ID
    public int getId() {
        return id;
    }

    // SET ID
    public void setId(int id) {
        this.id = id;
    }

    // GET CART ID
    public int getCartId() {
        return cartId;
    }

    // SET CART ID
    public void setCartId(int cartId) {
        this.cartId = cartId;
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
}