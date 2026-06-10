package com.fashionstore.model;

import java.sql.Timestamp;

public class Order {

    private int id;
    private int userId;
    private double totalAmount;
    private String status;
    private Timestamp createdAt;

    // DEFAULT CONSTRUCTOR
    public Order() {

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

    // GET TOTAL AMOUNT
    public double getTotalAmount() {
        return totalAmount;
    }

    // SET TOTAL AMOUNT
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    // GET STATUS
    public String getStatus() {
        return status;
    }

    // SET STATUS
    public void setStatus(String status) {
        this.status = status;
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