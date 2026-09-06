-- ============================================================
-- 17_query_optimization.sql
-- Query Optimization and Execution Plan Analysis
-- MySQL 8.0+
-- Database: ecommerce_analytics
-- ============================================================

USE ecommerce_analytics;


-- ============================================================
-- 1. Basic EXPLAIN
-- ============================================================

EXPLAIN
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status
FROM orders o
WHERE o.customer_id = 100;


-- ============================================================
-- 2. EXPLAIN ANALYZE
-- ============================================================

EXPLAIN ANALYZE
SELECT
    o.customer_id,
    COUNT(*) AS total_orders
FROM orders o
WHERE o.status = 'Delivered'
GROUP BY o.customer_id;


-- ============================================================
-- 3. Optimized Multi-table Sales Query
-- ============================================================

EXPLAIN ANALYZE
SELECT
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY c.category_name
ORDER BY total_revenue DESC;


-- ============================================================
-- 4. Customer Revenue Analysis
-- ============================================================

EXPLAIN ANALYZE
SELECT
    o.customer_id,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY o.customer_id
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================
-- 5. Monthly Revenue Analysis
-- ============================================================

EXPLAIN ANALYZE
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;


-- ============================================================
-- 6. Product Profit Analysis
-- ============================================================

EXPLAIN ANALYZE
SELECT
    p.product_id,
    p.product_name,
    SUM(
        oi.quantity * (oi.unit_price - p.cost)
    ) AS total_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY total_profit DESC
LIMIT 10;


-- ============================================================
-- 7. Avoid SELECT *
-- ============================================================

-- Less efficient when only specific columns are required:
-- SELECT * FROM orders WHERE customer_id = 100;

-- Preferred:
EXPLAIN
SELECT
    order_id,
    customer_id,
    order_date,
    status
FROM orders
WHERE customer_id = 100;


-- ============================================================
-- 8. Use SARGable Date Conditions
-- ============================================================

-- Preferred approach:
EXPLAIN
SELECT
    order_id,
    customer_id,
    order_date
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2026-02-01';


-- ============================================================
-- 9. Analyze Table Statistics
-- ============================================================

ANALYZE TABLE orders;
ANALYZE TABLE order_items;
ANALYZE TABLE products;
ANALYZE TABLE customers;


-- ============================================================
-- 10. Check Table Status
-- ============================================================

SHOW TABLE STATUS LIKE 'orders';
SHOW TABLE STATUS LIKE 'order_items';
SHOW TABLE STATUS LIKE 'products';


-- ============================================================
-- Optimization Checklist
-- ============================================================
-- 1. Use EXPLAIN / EXPLAIN ANALYZE.
-- 2. Select only required columns.
-- 3. Index columns used frequently in JOIN and WHERE clauses.
-- 4. Use composite indexes when multiple columns are filtered.
-- 5. Avoid unnecessary functions on indexed columns in WHERE.
-- 6. Filter data as early as practical.
-- 7. Avoid unnecessary subqueries and repeated calculations.
-- 8. Use LIMIT when only a small number of rows is required.
-- 9. Keep table statistics updated using ANALYZE TABLE.
-- 10. Validate optimization by comparing execution plans.
