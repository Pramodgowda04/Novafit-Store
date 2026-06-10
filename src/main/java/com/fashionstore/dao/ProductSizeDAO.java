package com.fashionstore.dao;

import java.util.List;

import com.fashionstore.model.ProductSize;

public interface ProductSizeDAO {

    boolean addProductSize(ProductSize productSize);

    List<ProductSize> getSizesByProductId(int productId);

    boolean updateStock(int productSizeId, int stock);

    boolean deleteProductSize(int productSizeId);
}