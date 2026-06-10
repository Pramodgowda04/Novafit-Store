USE fashion_store;

-- Coupons table for discount codes
CREATE TABLE IF NOT EXISTS coupons (
    coupon_id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    discount_type ENUM('PERCENTAGE', 'FIXED') NOT NULL DEFAULT 'PERCENTAGE',
    discount_value DECIMAL(10,2) NOT NULL,
    min_order_amount DECIMAL(10,2) NOT NULL DEFAULT 2000.00,
    max_discount DECIMAL(10,2) DEFAULT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    usage_limit INT NOT NULL DEFAULT 100,
    used_count INT NOT NULL DEFAULT 0
);

-- Insert sample coupons (only valid for orders above ₹2000)
INSERT INTO coupons (code, discount_type, discount_value, min_order_amount, max_discount, start_date, end_date, is_active, usage_limit, used_count)
VALUES
    ('NOVAFIT20', 'PERCENTAGE', 20.00, 2000.00, 500.00, '2025-01-01', '2026-12-31', 1, 1000, 0),
    ('FLAT200', 'FIXED', 200.00, 2000.00, NULL, '2025-01-01', '2026-12-31', 1, 500, 0),
    ('SAVE10', 'PERCENTAGE', 10.00, 2000.00, 300.00, '2025-01-01', '2026-12-31', 1, 500, 0)
ON DUPLICATE KEY UPDATE is_active = 1;
