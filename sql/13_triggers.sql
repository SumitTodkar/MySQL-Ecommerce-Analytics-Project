-- Trigger 1. Automatically reduce stock when an order item is inserted.
-- This trigger is useful for future orders after the initial dataset is loaded.

DELIMITER $$

DROP TRIGGER IF EXISTS trg_reduce_stock $$

CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END $$

DELIMITER ;


-- Trigger 2. Prevent return quantity from exceeding ordered quantity.

DELIMITER $$

DROP TRIGGER IF EXISTS trg_validate_return_quantity $$

CREATE TRIGGER trg_validate_return_quantity
BEFORE INSERT ON product_returns
FOR EACH ROW
BEGIN
    DECLARE v_ordered_quantity INT;

    SELECT quantity
    INTO v_ordered_quantity
    FROM order_items
    WHERE order_item_id = NEW.order_item_id;

    IF NEW.quantity > v_ordered_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Return quantity cannot exceed ordered quantity';
    END IF;
END $$

DELIMITER ;


-- Trigger 3. Automatically set return status to Pending when NULL is supplied.

DELIMITER $$

DROP TRIGGER IF EXISTS trg_default_return_status $$

CREATE TRIGGER trg_default_return_status
BEFORE INSERT ON product_returns
FOR EACH ROW
BEGIN
    IF NEW.status IS NULL OR NEW.status = '' THEN
        SET NEW.status = 'Pending';
    END IF;
END $$

DELIMITER ;


-- View all triggers
SHOW TRIGGERS;

