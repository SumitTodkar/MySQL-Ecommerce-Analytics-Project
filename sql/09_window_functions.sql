
-- Q1. ROW_NUMBER by product price
SELECT
    product_name,
    price,
    ROW_NUMBER() OVER (
        ORDER BY price DESC
    ) AS row_num
FROM products;

-- Q2. RANK products by price
SELECT
    product_name,
    price,
    RANK() OVER (
        ORDER BY price DESC
    ) AS price_rank
FROM products;

-- Q3. DENSE_RANK products by price
SELECT
    product_name,
    price,
    DENSE_RANK() OVER (
        ORDER BY price DESC
    ) AS price_rank
FROM products;

-- Q4. Rank products within each category
SELECT
    c.category_name,
    p.product_name,
    p.price,
    RANK() OVER (
        PARTITION BY p.category_id
        ORDER BY p.price DESC
    ) AS category_rank
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id;

-- Q5. Highest-priced product in each category
WITH ranked_products AS (
    SELECT
        c.category_name,
        p.product_name,
        p.price,
        RANK() OVER (
            PARTITION BY p.category_id
            ORDER BY p.price DESC
        ) AS category_rank
    FROM products p
    INNER JOIN categories c
        ON p.category_id = c.category_id
)
SELECT
    category_name,
    product_name,
    price
FROM ranked_products
WHERE category_rank = 1;

-- Q6. Rank customers by total spending
WITH customer_sales AS (
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
)
SELECT
    customer_name,
    total_spending,
    RANK() OVER (
        ORDER BY total_spending DESC
    ) AS customer_rank
FROM customer_sales;

-- Q7. Number each customer's orders
SELECT
    o.customer_id,
    o.order_id,
    o.order_date,
    ROW_NUMBER() OVER (
        PARTITION BY o.customer_id
        ORDER BY o.order_date
    ) AS order_number
FROM orders o;

-- Q8. Previous order date using LAG
SELECT
    order_id,
    customer_id,
    order_date,
    LAG(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date
FROM orders;

-- Q9. Next order date using LEAD
SELECT
    order_id,
    customer_id,
    order_date,
    LEAD(order_date) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order_date
FROM orders;

-- Q10. Running total of delivered daily sales
WITH daily_sales AS (
    SELECT
        DATE(o.order_date) AS order_date,
        SUM(oi.quantity * oi.unit_price) AS daily_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY DATE(o.order_date)
)
SELECT
    order_date,
    daily_sales,
    SUM(daily_sales) OVER (
        ORDER BY order_date
    ) AS running_sales
FROM daily_sales
ORDER BY order_date;

-- Q11. Monthly sales and previous month sales
WITH monthly_sales AS (
    SELECT
        YEAR(o.order_date) AS order_year,
        MONTH(o.order_date) AS order_month,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY YEAR(o.order_date), MONTH(o.order_date)
)
SELECT
    order_year,
    order_month,
    total_sales,
    LAG(total_sales) OVER (
        ORDER BY order_year, order_month
    ) AS previous_month_sales
FROM monthly_sales
ORDER BY order_year, order_month;

-- Q12. Month-over-month growth
WITH monthly_sales AS (
    SELECT
        YEAR(o.order_date) AS order_year,
        MONTH(o.order_date) AS order_month,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Delivered'
    GROUP BY YEAR(o.order_date), MONTH(o.order_date)
),
sales_comparison AS (
    SELECT
        order_year,
        order_month,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY order_year, order_month
        ) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    order_year,
    order_month,
    total_sales,
    previous_month_sales,
    ROUND(
        (total_sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0) * 100,
        2
    ) AS growth_percentage
FROM sales_comparison
ORDER BY order_year, order_month;