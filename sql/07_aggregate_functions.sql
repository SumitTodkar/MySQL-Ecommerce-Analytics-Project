USE ecommerce_analytics;

-- Q1. Count total customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Q2. Count total orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Q3. Count delivered orders
SELECT COUNT(*) AS delivered_orders
FROM orders
WHERE status = 'Delivered';

-- Q4. Total quantity sold
SELECT SUM(quantity) AS total_quantity_sold
FROM order_items;

-- Q5. Total sales value
SELECT
    SUM(quantity * unit_price) AS total_sales
FROM order_items;

-- Q6. Average product price
SELECT
    AVG(price) AS average_product_price
FROM products;

-- Q7. Average order item value
SELECT
    AVG(quantity * unit_price) AS average_item_value
FROM order_items;

-- Q8. Cheapest and most expensive product
SELECT
    MIN(price) AS cheapest_price,
    MAX(price) AS highest_price
FROM products;

-- Q9. Count orders by status
SELECT
    status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY status;

-- Q10. Count products in each category
SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;

-- Q11. Total sales for each product
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC;

-- Q12. Total sales by category
SELECT
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
INNER JOIN categories c
    ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_sales DESC;

-- Q13. Total spending by customer
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
ORDER BY total_spending DESC;

-- Q14. Customers who spent more than 5,000
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
HAVING SUM(oi.quantity * oi.unit_price) > 5000
ORDER BY total_spending DESC;

-- Q15. Customers with more than one order
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;

-- Q16. Monthly sales from delivered orders
SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(oi.quantity * oi.unit_price) AS monthly_sales
FROM orders o
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Delivered'
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY order_year, order_month;

-- Q17. Payment amount by payment method
SELECT
    payment_method,
    SUM(amount) AS total_amount
FROM payments
WHERE payment_status = 'Paid'
GROUP BY payment_method
ORDER BY total_amount DESC;

-- Q18. Count payments by status
SELECT
    payment_status,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_status;
