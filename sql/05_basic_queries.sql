-- Q1. Display all customers
SELECT *
FROM customers;

-- Q2. Display customer names and email
SELECT first_name, last_name, email
FROM customers;

-- Q3. Find customers registered after April 1, 2025
SELECT *
FROM customers
WHERE registration_date > '2025-04-01';

-- Q4. Find products costing more than 2,000
SELECT product_name, price
FROM products
WHERE price > 2000;

-- Q5. Find the 5 most expensive products
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- Q6. Find products priced between 500 and 2,000
SELECT product_name, price
FROM products
WHERE price BETWEEN 500 AND 2000;

-- Q7. Find delivered or shipped orders
SELECT *
FROM orders
WHERE status IN ('Delivered', 'Shipped');

-- Q8. Find products containing "Wireless"
SELECT *
FROM products
WHERE product_name LIKE '%Wireless%';

-- Q9. Display unique payment methods
SELECT DISTINCT payment_method
FROM payments;

-- Q10. Find returns without a reason
SELECT *
FROM product_returns
WHERE reason IS NULL;

-- Q11. Find returns with a reason
SELECT *
FROM product_returns
WHERE reason IS NOT NULL;

-- Q12. Categorize products by price
SELECT
    product_name,
    price,
    CASE
        WHEN price >= 10000 THEN 'High'
        WHEN price >= 2000 THEN 'Medium'
        ELSE 'Low'
    END AS price_category
FROM products;

-- Q13. Extract year from order date
SELECT
    order_id,
    order_date,
    YEAR(order_date) AS order_year
FROM orders;

-- Q14. Extract month from order date
SELECT
    order_id,
    order_date,
    MONTH(order_date) AS order_month
FROM orders;

-- Q15. Find orders from March 2026
SELECT *
FROM orders
WHERE order_date >= '2026-03-01'
  AND order_date < '2026-04-01';

-- Q16. Combine first and last name
SELECT
    CONCAT(first_name, ' ', last_name) AS customer_name,
    email
FROM customers;

-- Q17. Convert product names to uppercase
SELECT UPPER(product_name) AS product_name
FROM products;

-- Q18. Find length of product names
SELECT
    product_name,
    LENGTH(product_name) AS name_length
FROM products;