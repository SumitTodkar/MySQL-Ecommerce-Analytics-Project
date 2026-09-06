USE ecommerce_analytics;

-- Q1. Orders with customer names
SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date,
    o.status
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id;

-- Q2. Customers with addresses
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ca.city,
    ca.state,
    ca.address_type
FROM customers c
INNER JOIN customer_addresses ca
    ON c.customer_id = ca.customer_id;

-- Q3. All customers including those without an address
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ca.city,
    ca.state
FROM customers c
LEFT JOIN customer_addresses ca
    ON c.customer_id = ca.customer_id;

-- Q4. Orders with products
SELECT
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_total
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id;

-- Q5. Products with categories
SELECT
    p.product_name,
    p.price,
    c.category_name
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id;

-- Q6. Multiple-table JOIN
SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_total
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id;

-- Q7. Products purchased in delivered orders
SELECT
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM orders o
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
WHERE o.status = 'Delivered';

-- Q8. RIGHT JOIN - all categories
SELECT
    c.category_name,
    p.product_name,
    p.price
FROM products p
RIGHT JOIN categories c
    ON p.category_id = c.category_id;

-- Q9. CROSS JOIN
SELECT
    c.category_name,
    p.product_name
FROM categories c
CROSS JOIN products p;
