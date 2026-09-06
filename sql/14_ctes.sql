-- 14_ctes.sql
-- Common Table Expressions (CTEs)
-- MySQL 8.0+

USE ecommerce_analytics;

-- 1. Total Revenue by Category
WITH category_sales AS (
    SELECT c.category_id, c.category_name,
           SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM categories c
    JOIN products p ON c.category_id = p.category_id
    JOIN order_items oi ON p.product_id = oi.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.status = 'Delivered'
    GROUP BY c.category_id, c.category_name
)
SELECT category_id, category_name, total_revenue
FROM category_sales
ORDER BY total_revenue DESC;

-- 2. Top 10 Products by Revenue
WITH product_sales AS (
    SELECT p.product_id, p.product_name,
           SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.status = 'Delivered'
    GROUP BY p.product_id, p.product_name
)
SELECT product_id, product_name, total_revenue
FROM product_sales
ORDER BY total_revenue DESC
LIMIT 10;

-- 3. Customer Total Spending
WITH customer_spending AS (
    SELECT c.customer_id,
           CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
           SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT customer_id, customer_name, total_spending
FROM customer_spending
ORDER BY total_spending DESC;

-- 4. Multiple CTEs - Customer Order Analysis
WITH customer_orders AS (
    SELECT customer_id, COUNT(*) AS total_orders
    FROM orders
    GROUP BY customer_id
),
customer_sales AS (
    SELECT o.customer_id,
           SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY o.customer_id
)
SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       COALESCE(co.total_orders, 0) AS total_orders,
       COALESCE(cs.total_revenue, 0) AS total_revenue
FROM customers c
LEFT JOIN customer_orders co ON c.customer_id = co.customer_id
LEFT JOIN customer_sales cs ON c.customer_id = cs.customer_id
ORDER BY total_revenue DESC;

-- 5. Customers with Spending Above Average
WITH customer_spending AS (
    SELECT o.customer_id,
           SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY o.customer_id
),
average_spending AS (
    SELECT AVG(total_spending) AS avg_spending
    FROM customer_spending
)
SELECT cs.customer_id, cs.total_spending
FROM customer_spending cs
CROSS JOIN average_spending av
WHERE cs.total_spending > av.avg_spending
ORDER BY cs.total_spending DESC;

-- 6. Monthly Revenue
WITH monthly_sales AS (
    SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
           SUM(oi.quantity * oi.unit_price) AS monthly_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT sales_month, monthly_revenue
FROM monthly_sales
ORDER BY sales_month;

-- 7. Product Profit Analysis
WITH product_profit AS (
    SELECT p.product_id, p.product_name,
           SUM(oi.quantity * (oi.unit_price - p.cost)) AS total_profit
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.status = 'Delivered'
    GROUP BY p.product_id, p.product_name
)
SELECT product_id, product_name, total_profit
FROM product_profit
ORDER BY total_profit DESC;

-- 8. Customer Segmentation
WITH customer_spending AS (
    SELECT c.customer_id,
           CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
           COALESCE(SUM(CASE WHEN o.status = 'Delivered'
                             THEN oi.quantity * oi.unit_price ELSE 0 END), 0) AS total_spending
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT customer_id, customer_name, total_spending,
       CASE
           WHEN total_spending >= 100000 THEN 'VIP'
           WHEN total_spending >= 50000 THEN 'High Value'
           WHEN total_spending >= 20000 THEN 'Medium Value'
           WHEN total_spending > 0 THEN 'Low Value'
           ELSE 'No Purchase'
       END AS customer_segment
FROM customer_spending
ORDER BY total_spending DESC;

-- 9. Category Revenue and Profit
WITH category_performance AS (
    SELECT c.category_id, c.category_name,
           SUM(oi.quantity * oi.unit_price) AS total_revenue,
           SUM(oi.quantity * (oi.unit_price - p.cost)) AS total_profit
    FROM categories c
    JOIN products p ON c.category_id = p.category_id
    JOIN order_items oi ON p.product_id = oi.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.status = 'Delivered'
    GROUP BY c.category_id, c.category_name
)
SELECT category_id, category_name, total_revenue, total_profit,
       ROUND((total_profit / NULLIF(total_revenue, 0)) * 100, 2) AS profit_margin_percentage
FROM category_performance
ORDER BY total_revenue DESC;

-- 10. Latest Order for Each Customer
WITH latest_orders AS (
    SELECT o.customer_id, o.order_id, o.order_date, o.status,
           ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date DESC) AS rn
    FROM orders o
)
SELECT customer_id, order_id, order_date, status
FROM latest_orders
WHERE rn = 1
ORDER BY customer_id;

-- 11. Repeat Customers
WITH customer_order_count AS (
    SELECT customer_id, COUNT(*) AS total_orders
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id, total_orders
FROM customer_order_count
WHERE total_orders > 1
ORDER BY total_orders DESC;

-- 12. Order Value Analysis
WITH order_totals AS (
    SELECT o.order_id, o.customer_id, o.order_date, o.status,
           SUM(oi.quantity * oi.unit_price) AS order_value
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, o.customer_id, o.order_date, o.status
)
SELECT order_id, customer_id, order_date, order_value
FROM order_totals
WHERE status = 'Delivered'
ORDER BY order_value DESC;

-- 13. Executive KPI Summary
WITH delivered_sales AS (
    SELECT SUM(oi.quantity * oi.unit_price) AS total_revenue,
           SUM(oi.quantity * (oi.unit_price - p.cost)) AS total_profit
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE o.status = 'Delivered'
),
order_metrics AS (
    SELECT COUNT(*) AS total_orders,
           COUNT(CASE WHEN status = 'Delivered' THEN 1 END) AS delivered_orders
    FROM orders
)
SELECT ds.total_revenue, ds.total_profit,
       om.total_orders, om.delivered_orders,
       ROUND(ds.total_revenue / NULLIF(om.delivered_orders, 0), 2) AS average_order_value,
       ROUND(ds.total_profit / NULLIF(ds.total_revenue, 0) * 100, 2) AS profit_margin_percentage
FROM delivered_sales ds
CROSS JOIN order_metrics om;
