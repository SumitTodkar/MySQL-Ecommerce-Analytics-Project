-- ============================================================
-- 15_business_analytics.sql
-- E-Commerce Business Analytics
-- MySQL 8.0+
-- Database: ecommerce_analytics
-- ============================================================

USE ecommerce_analytics;

-- 1. Total Revenue from Delivered Orders
SELECT
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Delivered';


-- 2. Total Profit from Delivered Orders
SELECT
    ROUND(
        SUM(oi.quantity * (oi.unit_price - p.cost)),
        2
    ) AS total_profit
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'Delivered';


-- 3. Average Order Value
SELECT
    ROUND(
        SUM(oi.quantity * oi.unit_price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Delivered';


-- 4. Monthly Revenue Trend
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;


-- 5. Revenue by Category
SELECT
    c.category_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY c.category_name
ORDER BY total_revenue DESC;


-- 6. Top 10 Products by Revenue
SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 10;


-- 7. Top 10 Customers by Revenue
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_revenue DESC
LIMIT 10;


-- 8. Repeat Customers
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY total_orders DESC;


-- 9. Customer Segmentation
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(
        COALESCE(
            SUM(
                CASE
                    WHEN o.status = 'Delivered'
                    THEN oi.quantity * oi.unit_price
                    ELSE 0
                END
            ),
            0
        ),
        2
    ) AS total_spending,
    CASE
        WHEN COALESCE(SUM(
            CASE
                WHEN o.status = 'Delivered'
                THEN oi.quantity * oi.unit_price
                ELSE 0
            END
        ), 0) >= 100000 THEN 'VIP'
        WHEN COALESCE(SUM(
            CASE
                WHEN o.status = 'Delivered'
                THEN oi.quantity * oi.unit_price
                ELSE 0
            END
        ), 0) >= 50000 THEN 'High Value'
        WHEN COALESCE(SUM(
            CASE
                WHEN o.status = 'Delivered'
                THEN oi.quantity * oi.unit_price
                ELSE 0
            END
        ), 0) >= 20000 THEN 'Medium Value'
        WHEN COALESCE(SUM(
            CASE
                WHEN o.status = 'Delivered'
                THEN oi.quantity * oi.unit_price
                ELSE 0
            END
        ), 0) > 0 THEN 'Low Value'
        ELSE 'No Purchase'
    END AS customer_segment
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spending DESC;


-- 10. Total Profit by Product
SELECT
    p.product_id,
    p.product_name,
    ROUND(
        SUM(oi.quantity * (oi.unit_price - p.cost)),
        2
    ) AS total_profit
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY total_profit DESC
LIMIT 10;


-- 11. Profit Margin by Category
SELECT
    c.category_name,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue,
    ROUND(
        SUM(oi.quantity * (oi.unit_price - p.cost)),
        2
    ) AS profit,
    ROUND(
        SUM(oi.quantity * (oi.unit_price - p.cost))
        / NULLIF(SUM(oi.quantity * oi.unit_price), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY c.category_name
ORDER BY profit_margin_percentage DESC;


-- 12. Order Status Distribution
SELECT
    status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders),
        2
    ) AS percentage
FROM orders
GROUP BY status
ORDER BY total_orders DESC;


-- 13. Cancellation Rate
SELECT
    COUNT(*) AS total_orders,
    SUM(status = 'Cancelled') AS cancelled_orders,
    ROUND(
        SUM(status = 'Cancelled') * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_percentage
FROM orders;


-- 14. Payment Success Rate
SELECT
    COUNT(*) AS total_payments,
    SUM(payment_status = 'Success') AS successful_payments,
    ROUND(
        SUM(payment_status = 'Success') * 100.0 / COUNT(*),
        2
    ) AS payment_success_rate
FROM payments;


-- 15. Return Reasons
SELECT
    reason,
    COUNT(*) AS return_count
FROM product_returns
GROUP BY reason
ORDER BY return_count DESC;


-- 16. Total Returned Quantity
SELECT
    SUM(quantity) AS total_returned_quantity
FROM product_returns;


-- 17. Products with Low Stock
SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity < 20
ORDER BY stock_quantity;


-- 18. Products Never Ordered
SELECT
    p.product_id,
    p.product_name
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;


-- 19. Customers with No Orders
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;


-- 20. Executive KPI Summary
SELECT
    ROUND(
        SUM(
            CASE
                WHEN o.status = 'Delivered'
                THEN oi.quantity * oi.unit_price
                ELSE 0
            END
        ),
        2
    ) AS total_revenue,
    ROUND(
        SUM(
            CASE
                WHEN o.status = 'Delivered'
                THEN oi.quantity * (oi.unit_price - p.cost)
                ELSE 0
            END
        ),
        2
    ) AS total_profit,
    COUNT(DISTINCT CASE
        WHEN o.status = 'Delivered'
        THEN o.order_id
    END) AS delivered_orders,
    COUNT(DISTINCT c.customer_id) AS total_customers
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id;
