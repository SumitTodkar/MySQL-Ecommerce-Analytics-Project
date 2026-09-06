-- ============================================================
-- 16_indexing.sql
-- Indexing and Performance Analysis
-- MySQL 8.0+
-- Database: ecommerce_analytics
-- ============================================================

USE ecommerce_analytics;

-- View existing indexes
SHOW INDEX FROM customers;
SHOW INDEX FROM customer_addresses;
SHOW INDEX FROM products;
SHOW INDEX FROM orders;
SHOW INDEX FROM order_items;
SHOW INDEX FROM payments;
SHOW INDEX FROM product_returns;


-- ============================================================
-- 1. Create Indexes for Frequently Used Columns
-- ============================================================

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX idx_orders_order_date
ON orders(order_date);

CREATE INDEX idx_orders_status
ON orders(status);

CREATE INDEX idx_order_items_order_id
ON order_items(order_id);

CREATE INDEX idx_order_items_product_id
ON order_items(product_id);

CREATE INDEX idx_payments_order_id
ON payments(order_id);

CREATE INDEX idx_payments_status
ON payments(payment_status);

CREATE INDEX idx_product_returns_order_item_id
ON product_returns(order_item_id);

CREATE INDEX idx_products_category_id
ON products(category_id);


-- ============================================================
-- 2. Composite Indexes for Common Filters
-- ============================================================

CREATE INDEX idx_orders_customer_status
ON orders(customer_id, status);

CREATE INDEX idx_orders_status_date
ON orders(status, order_date);

CREATE INDEX idx_order_items_product_order
ON order_items(product_id, order_id);


-- ============================================================
-- 3. Verify Created Indexes
-- ============================================================

SHOW INDEX FROM orders;
SHOW INDEX FROM order_items;
SHOW INDEX FROM payments;
SHOW INDEX FROM product_returns;
SHOW INDEX FROM products;


-- ============================================================
-- 4. Analyze Orders by Customer
-- ============================================================

EXPLAIN
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM orders
WHERE customer_id = 100
GROUP BY customer_id;


-- ============================================================
-- 5. Analyze Delivered Orders by Date
-- ============================================================

EXPLAIN
SELECT
    order_id,
    customer_id,
    order_date,
    status
FROM orders
WHERE status = 'Delivered'
AND order_date >= '2026-01-01';


-- ============================================================
-- 6. Analyze Product Order Items
-- ============================================================

EXPLAIN
SELECT
    product_id,
    SUM(quantity) AS total_quantity
FROM order_items
WHERE product_id = 10
GROUP BY product_id;


-- ============================================================
-- 7. Index Usage Information
-- ============================================================

ANALYZE TABLE orders;
ANALYZE TABLE order_items;
ANALYZE TABLE payments;
ANALYZE TABLE products;
ANALYZE TABLE product_returns;


-- ============================================================
-- Notes
-- ============================================================
-- Indexes improve data retrieval for frequently filtered,
-- joined, grouped, or sorted columns.
--
-- Avoid creating unnecessary indexes because indexes consume
-- storage and can increase INSERT, UPDATE, and DELETE cost.
