package com.fashionstore.dao;

import java.util.List;

import com.fashionstore.model.CartItem;

public interface CartItemDAO {

    boolean addCartItem(CartItem cartItem);

    List<CartItem> getCartItemsByCartId(int cartId);

    boolean updateQuantity(int cartItemId, int quantity);

    boolean removeCartItem(int cartItemId);
    
}