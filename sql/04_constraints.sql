-- Primary keys and AUTO_INCREMENT are defined during table creation.
-- Foreign keys maintain relationships between tables.
-- UNIQUE constraints prevent duplicate emails/category names.
-- NOT NULL prevents missing required values.
-- CHECK constraints validate business rules.

-- View table structures and constraints
SHOW CREATE TABLE customers;
SHOW CREATE TABLE customer_addresses;
SHOW CREATE TABLE categories;
SHOW CREATE TABLE products;
SHOW CREATE TABLE orders;
SHOW CREATE TABLE order_items;
SHOW CREATE TABLE payments;
SHOW CREATE TABLE product_returns;

-- Example constraint tests (run only if you want to test errors)

-- Duplicate email test:
-- INSERT INTO customers
-- (first_name, last_name, email, phone, registration_date)
-- VALUES ('Test', 'User', 'rahul.sharma@gmail.com', '9999999999', '2026-01-01');

-- Invalid product price/cost test:
-- INSERT INTO products
-- (category_id, product_name, price, cost, stock_quantity)
-- VALUES (1, 'Invalid Product', 500, 800, 10);

-- Invalid quantity test:
-- INSERT INTO order_items
-- (order_id, product_id, quantity, unit_price)
-- VALUES (1, 1, 0, 2499.00);