package com.fashionstore.model;

import java.sql.Timestamp;

public class Cart {

    private int id;
    private int userId;
    private Timestamp createdAt;

    // DEFAULT CONSTRUCTOR
    public Cart() {

    }

    // GET ID
    public int getId() {
        return id;
    }

    // SET ID
    public void setId(int id) {
        this.id = id;
    }

    // GET USER ID
    public int getUserId() {
        return userId;
    }

    // SET USER ID
    public void setUserId(int userId) {
        this.userId = userId;
    }

    // GET CREATED AT
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    // SET CREATED AT
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}