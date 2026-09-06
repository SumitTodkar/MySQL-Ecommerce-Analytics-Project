-- ============================================
-- 1. PRODUCT RETURNS
-- ============================================

INSERT INTO customers
(first_name, last_name, email, phone, registration_date)
VALUES
('Rahul', 'Sharma', 'rahul.sharma@gmail.com', '9876543210', '2025-01-15'),
('Priya', 'Patil', 'priya.patil@gmail.com', '9876543211', '2025-02-10'),
('Amit', 'Verma', 'amit.verma@gmail.com', '9876543212', '2025-03-05'),
('Sneha', 'Kulkarni', 'sneha.kulkarni@gmail.com', '9876543213', '2025-03-20'),
('Rohan', 'Mehta', 'rohan.mehta@gmail.com', '9876543214', '2025-04-12'),
('Neha', 'Joshi', 'neha.joshi@gmail.com', '9876543215', '2025-05-18'),
('Vikram', 'Desai', 'vikram.desai@gmail.com', '9876543216', '2025-06-01'),
('Anjali', 'Nair', 'anjali.nair@gmail.com', '9876543217', '2025-06-25'),
('Karan', 'Singh', 'karan.singh@gmail.com', '9876543218', '2025-07-10'),
('Pooja', 'Gupta', 'pooja.gupta@gmail.com', '9876543219', '2025-08-05');



-- ============================================
-- 2. CUSTOMER ADDRESSES
-- ============================================

INSERT INTO customer_addresses
(customer_id, address_type, address_line, city, state, pincode)
VALUES
(1, 'Home', '12 MG Road', 'Mumbai', 'Maharashtra', '400001'),
(1, 'Office', '45 Andheri East', 'Mumbai', 'Maharashtra', '400069'),
(2, 'Home', '21 FC Road', 'Pune', 'Maharashtra', '411004'),
(3, 'Home', '18 Connaught Place', 'Delhi', 'Delhi', '110001'),
(4, 'Home', '25 Koramangala', 'Bengaluru', 'Karnataka', '560034'),
(5, 'Home', '17 Banjara Hills', 'Hyderabad', 'Telangana', '500034'),
(6, 'Home', '10 Anna Nagar', 'Chennai', 'Tamil Nadu', '600040'),
(7, 'Home', '33 Viman Nagar', 'Pune', 'Maharashtra', '411014'),
(8, 'Home', '14 Powai Road', 'Mumbai', 'Maharashtra', '400076'),
(9, 'Home', '50 Sector 17', 'Chandigarh', 'Chandigarh', '160017'),
(10, 'Home', '8 Salt Lake', 'Kolkata', 'West Bengal', '700091');


-- ============================================
-- 3. CATEGORIES
-- ============================================

INSERT INTO categories
(category_name)
VALUES
('Electronics'),
('Mobile Accessories'),
('Clothing'),
('Footwear'),
('Home & Kitchen'),
('Beauty'),
('Sports'),
('Books'),
('Grocery'),
('Office Supplies');


-- ============================================
-- 4. PRODUCTS
-- ============================================

INSERT INTO products
(category_id, product_name, price, cost, stock_quantity)
VALUES
(1, 'Wireless Headphones', 2499.00, 1600.00, 100),
(1, 'Bluetooth Speaker', 1999.00, 1200.00, 80),
(1, 'Smart LED TV 43 Inch', 32999.00, 26000.00, 30),
(2, 'USB-C Fast Charger', 999.00, 550.00, 150),
(2, 'Wireless Mouse', 799.00, 400.00, 200),
(3, 'Men Cotton T-Shirt', 699.00, 350.00, 250),
(3, 'Women Casual Kurti', 1199.00, 600.00, 180),
(4, 'Running Shoes', 2999.00, 1800.00, 120),
(4, 'Casual Sneakers', 2499.00, 1500.00, 100),
(5, 'Non-Stick Cookware Set', 3499.00, 2200.00, 60),
(5, 'Electric Kettle', 1499.00, 850.00, 90),
(6, 'Face Wash', 399.00, 200.00, 300),
(6, 'Moisturizer', 599.00, 300.00, 250),
(7, 'Yoga Mat', 899.00, 450.00, 140),
(7, 'Cricket Bat', 2499.00, 1500.00, 70),
(8, 'SQL Programming Book', 799.00, 450.00, 100),
(8, 'Data Analytics Handbook', 999.00, 550.00, 80),
(9, 'Premium Basmati Rice 5kg', 699.00, 500.00, 200),
(9, 'Organic Green Tea', 349.00, 200.00, 180),
(10, 'A4 Notebook Pack', 299.00, 150.00, 300);


-- ============================================
-- 5. ORDERS
-- ============================================

INSERT INTO orders
(customer_id, order_date, status)
VALUES
(1, '2026-01-05 10:30:00', 'Delivered'),
(2, '2026-01-08 14:20:00', 'Delivered'),
(3, '2026-01-12 16:45:00', 'Delivered'),
(1, '2026-01-18 11:15:00', 'Delivered'),
(4, '2026-01-25 09:40:00', 'Delivered'),
(5, '2026-02-03 13:10:00', 'Delivered'),
(2, '2026-02-08 17:30:00', 'Delivered'),
(6, '2026-02-14 12:00:00', 'Shipped'),
(7, '2026-02-20 15:25:00', 'Delivered'),
(8, '2026-02-28 18:10:00', 'Delivered'),
(9, '2026-03-04 10:05:00', 'Delivered'),
(10, '2026-03-10 14:50:00', 'Cancelled'),
(3, '2026-03-15 11:35:00', 'Delivered'),
(1, '2026-03-20 16:20:00', 'Delivered'),
(5, '2026-03-25 19:00:00', 'Shipped'),
(4, '2026-04-02 09:15:00', 'Delivered'),
(6, '2026-04-10 13:40:00', 'Delivered'),
(7, '2026-04-15 17:05:00', 'Cancelled'),
(8, '2026-04-20 12:30:00', 'Delivered'),
(9, '2026-04-28 15:45:00', 'Delivered');


-- ============================================
-- 6. ORDER ITEMS
-- ============================================

INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 2499.00),
(1, 4, 2, 999.00),
(2, 8, 1, 2999.00),
(2, 12, 2, 399.00),
(3, 3, 1, 32999.00),
(4, 5, 1, 799.00),
(4, 16, 1, 799.00),
(5, 7, 2, 1199.00),
(5, 13, 1, 599.00),
(6, 10, 1, 3499.00),
(6, 11, 1, 1499.00),
(7, 2, 1, 1999.00),
(7, 5, 2, 799.00),
(8, 14, 2, 899.00),
(9, 15, 1, 2499.00),
(9, 8, 1, 2999.00),
(10, 6, 3, 699.00),
(10, 7, 1, 1199.00),
(11, 18, 2, 699.00),
(11, 19, 2, 349.00),
(12, 1, 1, 2499.00),
(13, 17, 1, 999.00),
(13, 16, 1, 799.00),
(14, 1, 1, 2499.00),
(14, 2, 1, 1999.00),
(14, 4, 1, 999.00),
(15, 20, 3, 299.00),
(16, 9, 1, 2499.00),
(16, 10, 1, 3499.00),
(17, 3, 1, 32999.00),
(18, 12, 2, 399.00),
(18, 13, 1, 599.00),
(19, 1, 1, 2499.00),
(19, 5, 1, 799.00),
(20, 8, 1, 2999.00),
(20, 14, 1, 899.00);


-- ============================================
-- 7. PAYMENTS
-- ============================================

INSERT INTO payments
(order_id, payment_date, payment_method, amount, payment_status)
VALUES
(1, '2026-01-05 10:35:00', 'UPI', 4497.00, 'Paid'),
(2, '2026-01-08 14:25:00', 'Credit Card', 3797.00, 'Paid'),
(3, '2026-01-12 16:50:00', 'UPI', 32999.00, 'Paid'),
(4, '2026-01-18 11:20:00', 'Debit Card', 1598.00, 'Paid'),
(5, '2026-01-25 09:45:00', 'UPI', 2997.00, 'Paid'),
(6, '2026-02-03 13:15:00', 'Credit Card', 4998.00, 'Paid'),
(7, '2026-02-08 17:35:00', 'UPI', 3597.00, 'Paid'),
(8, '2026-02-14 12:05:00', 'Debit Card', 1798.00, 'Paid'),
(9, '2026-02-20 15:30:00', 'UPI', 5498.00, 'Paid'),
(10, '2026-02-28 18:15:00', 'Credit Card', 3296.00, 'Paid'),
(11, '2026-03-04 10:10:00', 'UPI', 2096.00, 'Paid'),
(12, '2026-03-10 14:55:00', 'UPI', 2499.00, 'Failed'),
(13, '2026-03-15 11:40:00', 'Net Banking', 1798.00, 'Paid'),
(14, '2026-03-20 16:25:00', 'UPI', 5497.00, 'Paid'),
(15, '2026-03-25 19:05:00', 'Cash on Delivery', 897.00, 'Pending'),
(16, '2026-04-02 09:20:00', 'Credit Card', 5998.00, 'Paid'),
(17, '2026-04-10 13:45:00', 'UPI', 1397.00, 'Paid'),
(18, '2026-04-15 17:10:00', 'UPI', 32999.00, 'Failed'),
(19, '2026-04-20 12:35:00', 'Debit Card', 3298.00, 'Paid'),
(20, '2026-04-28 15:50:00', 'UPI', 3898.00, 'Paid');


-- ============================================
-- 8. PRODUCT RETURNS
-- ============================================

INSERT INTO product_returns
(order_item_id, return_date, quantity, reason, status)
VALUES
(4, '2026-01-15 10:00:00', 1, 'Damaged', 'Approved'),
(9, '2026-02-02 14:30:00', 1, 'Wrong Product', 'Approved'),
(14, '2026-02-25 11:15:00', 1, 'Poor Quality', 'Approved'),
(18, '2026-03-12 16:40:00', 1, 'Size Issue', 'Approved'),
(25, '2026-04-05 13:20:00', 1, 'Changed Mind', 'Pending');