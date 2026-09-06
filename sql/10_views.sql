-- View 1. Customer order details
CREATE OR REPLACE VIEW vw_customer_orders AS
SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id;

SELECT *
FROM vw_customer_orders;

-- View 2. Product details with category
CREATE OR REPLACE VIEW vw_product_category AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.cost,
    p.stock_quantity
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id;

SELECT *
FROM vw_product_category;

-- View 3. Order item sales details
CREATE OR REPLACE VIEW vw_order_item_sales AS
SELECT
    oi.order_item_id,
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_total
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id;

SELECT *
FROM vw_order_item_sales;

-- View 4. Customer sales summary
CREATE OR REPLACE VIEW vw_customer_sales AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.first_name, c.last_name;

SELECT *
FROM vw_customer_sales
ORDER BY total_spending DESC;

-- View 5. Monthly sales
CREATE OR REPLACE VIEW vw_monthly_sales AS
SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders o
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY YEAR(o.order_date), MONTH(o.order_date);

SELECT *
FROM vw_monthly_sales
ORDER BY order_year, order_month;

-- List views
SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';