DELIMITER $$

-- Procedure 1. Get orders for a customer
DROP PROCEDURE IF EXISTS GetCustomerOrders $$

CREATE PROCEDURE GetCustomerOrders(IN p_customer_id INT)
BEGIN
    SELECT
        o.order_id,
        o.order_date,
        o.status
    FROM orders o
    WHERE o.customer_id = p_customer_id
    ORDER BY o.order_date DESC;
END $$

DELIMITER ;

CALL GetCustomerOrders(1);


DELIMITER $$

-- Procedure 2. Get products by category
DROP PROCEDURE IF EXISTS GetProductsByCategory $$

CREATE PROCEDURE GetProductsByCategory(IN p_category_id INT)
BEGIN
    SELECT
        product_id,
        product_name,
        price,
        stock_quantity
    FROM products
    WHERE category_id = p_category_id
    ORDER BY price DESC;
END $$

DELIMITER ;

CALL GetProductsByCategory(1);


DELIMITER $$

-- Procedure 3. Customer spending summary
DROP PROCEDURE IF EXISTS GetCustomerSpending $$

CREATE PROCEDURE GetCustomerSpending(IN p_customer_id INT)
BEGIN
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COALESCE(
            SUM(
                CASE
                    WHEN o.status = 'Delivered'
                    THEN oi.quantity * oi.unit_price
                    ELSE 0
                END
            ),
            0
        ) AS total_spending
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE c.customer_id = p_customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name;
END $$

DELIMITER ;

CALL GetCustomerSpending(1);