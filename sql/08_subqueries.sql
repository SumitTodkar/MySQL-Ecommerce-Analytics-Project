-- Q1. Products priced above average
SELECT
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
)
ORDER BY price DESC;

-- Q2. Most expensive product
SELECT
    product_name,
    price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);

-- Q3. Products more expensive than the cheapest product
SELECT
    product_name,
    price
FROM products
WHERE price > (
    SELECT MIN(price)
    FROM products
)
ORDER BY price;

-- Q4. Customers who have placed at least one order
SELECT
    customer_id,
    first_name,
    last_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);

-- Q5. Customers who have never placed an order
SELECT
    customer_id,
    first_name,
    last_name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

-- Q6. Customers who have placed an order using EXISTS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Q7. Customers who have never placed an order using NOT EXISTS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- Q8. Subquery in SELECT
SELECT
    product_name,
    price,
    (
        SELECT AVG(price)
        FROM products
    ) AS average_price
FROM products;

-- Q9. Subquery in FROM / derived table
SELECT
    customer_name,
    total_spending
FROM (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_spending
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.first_name, c.last_name
) AS customer_sales
WHERE total_spending > 5000
ORDER BY total_spending DESC;

-- Q10. Correlated subquery:
-- Products priced above the average price of their category
SELECT
    p.product_name,
    p.price,
    p.category_id
FROM products p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);

-- Q11. Customers whose order count is above average
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > (
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM orders
        GROUP BY customer_id
    ) AS customer_order_counts
);
