CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    registration_date DATE NOT NULL
);


CREATE TABLE customer_addresses(
address_id INT primary KEY,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
address_line VARCHAR(250),
city varchar(50),
state VARCHAR(50),
pincode INT NOT NULL
)


CREATE TABLE categories(
 category_id INT primary KEY,
 category_name VARCHAR(40)
)


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0
    
);



CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) DEFAULT 'Pending'

    
);




CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL


);




CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(30),
    amount DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(30) DEFAULT 'Pending'


);


CREATE TABLE product_returns (
    return_id INT NOT NULL AUTO_INCREMENT,
    order_item_id INT NOT NULL,
    return_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(30) NOT NULL DEFAULT 'Pending',
    PRIMARY KEY (return_id),
    FOREIGN KEY (order_item_id) REFERENCES order_items(order_item_id),
    CHECK (quantity > 0)
);