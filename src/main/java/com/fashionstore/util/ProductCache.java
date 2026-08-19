package com.fashionstore.util;

import com.fashionstore.model.Product;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class ProductCache {

    private static final Map<String, List<Product>> CACHE = new ConcurrentHashMap<>();
    private static final Map<Integer, Product> SINGLE_CACHE = new ConcurrentHashMap<>();
    private static long lastCacheTime = 0;
    private static final long CACHE_DURATION_MS = 60000; // 60 seconds cache

    public static List<Product> get(String key) {
        if (System.currentTimeMillis() - lastCacheTime > CACHE_DURATION_MS) {
            clear();
            return null;
        }
        return CACHE.get(key);
    }

    public static void put(String key, List<Product> products) {
        CACHE.put(key, products);
        if (products != null) {
            for (Product p : products) {
                if (p != null) {
                    SINGLE_CACHE.put(p.getId(), p);
                }
            }
        }
        lastCacheTime = System.currentTimeMillis();
    }

    public static Product getSingle(int id) {
        if (System.currentTimeMillis() - lastCacheTime > CACHE_DURATION_MS) {
            clear();
            return null;
        }
        return SINGLE_CACHE.get(id);
    }

    public static void clear() {
        CACHE.clear();
        SINGLE_CACHE.clear();
        lastCacheTime = System.currentTimeMillis();
    }
}
