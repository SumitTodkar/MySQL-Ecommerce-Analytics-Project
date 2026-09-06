DELIMITER $$

-- Function 1. Calculate order total
DROP FUNCTION IF EXISTS GetOrderTotal $$

CREATE FUNCTION GetOrderTotal(p_order_id INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(12,2);

    SELECT COALESCE(
        SUM(quantity * unit_price),
        0
    )
    INTO v_total
    FROM order_items
    WHERE order_id = p_order_id;

    RETURN v_total;
END $$

DELIMITER ;

SELECT
    order_id,
    GetOrderTotal(order_id) AS order_total
FROM orders;


DELIMITER $$

-- Function 2. Calculate product profit per unit
DROP FUNCTION IF EXISTS GetProductProfit $$

CREATE FUNCTION GetProductProfit(p_product_id INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_profit DECIMAL(12,2);

    SELECT
        price - cost
    INTO v_profit
    FROM products
    WHERE product_id = p_product_id;

    RETURN COALESCE(v_profit, 0);
END $$

DELIMITER ;

SELECT
    product_id,
    product_name,
    GetProductProfit(product_id) AS profit_per_unit
FROM products;


DELIMITER $$

-- Function 3. Customer segment based on spending
DROP FUNCTION IF EXISTS GetCustomerSegment $$

CREATE FUNCTION GetCustomerSegment(p_total_spending DECIMAL(12,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF p_total_spending >= 10000 THEN
        RETURN 'High Value';
    ELSEIF p_total_spending >= 5000 THEN
        RETURN 'Medium Value';
    ELSE
        RETURN 'Low Value';
    END IF;
END $$

DELIMITER ;

SELECT
    customer_name,
    total_spending,
    GetCustomerSegment(total_spending) AS customer_segment
FROM vw_customer_sales;

