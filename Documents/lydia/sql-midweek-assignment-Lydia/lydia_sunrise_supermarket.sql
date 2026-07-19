-- ============================================================
-- Sunrise Supermarket - Practice Project
-- Name: Lydia
-- Date: 19/07/2026
-- Database: PostgreSQL
-- ============================================================

-- ============================================================
-- PART 1 - Creating & Altering Tables
-- ============================================================

CREATE SCHEMA IF NOT EXISTS sunrise_supermarket;

-- Task 1: customers table
-- customer_id is primary key; email and phone_number must be unique
CREATE TABLE sunrise_supermarket.customers (
    customer_id     SERIAL PRIMARY KEY,
    full_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(100) UNIQUE NOT NULL,
    phone_number    VARCHAR(15) UNIQUE NOT NULL,
    city            VARCHAR(50) NOT NULL
);

-- Task 2: products table
-- unit_price can never be zero or negative; stock defaults to 0
CREATE TABLE sunrise_supermarket.products (
    product_id      SERIAL PRIMARY KEY,
    product_name    VARCHAR(100) NOT NULL,
    category        VARCHAR(100) NOT NULL,
    unit_price      DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    stock           INT DEFAULT 0
);

-- Task 3: orders table
-- references customers; status defaults to 'Pending'
CREATE TABLE sunrise_supermarket.orders (
    order_id        SERIAL PRIMARY KEY,
    customer_id     INT NOT NULL,
    order_date      DATE NOT NULL,
    status          VARCHAR(20) DEFAULT 'Pending',
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
        REFERENCES sunrise_supermarket.customers(customer_id)
);

-- Task 4: order_items table
-- references BOTH orders and products; quantity must be greater than 0
CREATE TABLE sunrise_supermarket.order_items (
    order_item_id   SERIAL PRIMARY KEY,
    order_id        INT NOT NULL,
    product_id      INT NOT NULL,
    quantity        INT NOT NULL CHECK (quantity > 0),
    CONSTRAINT fk_order FOREIGN KEY (order_id)
        REFERENCES sunrise_supermarket.orders(order_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id)
        REFERENCES sunrise_supermarket.products(product_id)
);

-- Task 5: rename stock column in products to stock_quantity
ALTER TABLE sunrise_supermarket.products
RENAME COLUMN stock TO stock_quantity;

-- Task 6: add loyalty_points column to customers, defaulting to 0
ALTER TABLE sunrise_supermarket.customers
ADD COLUMN loyalty_points INT DEFAULT 0;

-- Task 7: widen product_name to VARCHAR(150)
ALTER TABLE sunrise_supermarket.products
ALTER COLUMN product_name TYPE VARCHAR(150);


-- ============================================================
-- PART 2 - Inserting & Changing Data
-- ============================================================

-- Task 8: insert all 4 customers
INSERT INTO sunrise_supermarket.customers (full_name, email, phone_number, city)
VALUES
    ('Grace Wambui', 'grace.wambui@gmail.com', '0711223344', 'Nairobi'),
    ('Kevin Mutiso', 'kevin.mutiso@gmail.com', '0722334455', 'Nakuru'),
    ('Faith Chebet', 'faith.chebet@gmail.com', '0733445566', 'Eldoret'),
    ('Ibrahim Noor', 'ibrahim.noor@gmail.com', '0744556677', 'Mombasa');

-- Task 9: insert all 4 products (using stock_quantity, the renamed column)
INSERT INTO sunrise_supermarket.products (product_name, category, unit_price, stock_quantity)
VALUES
    ('Maize Flour 2kg', 'Groceries',  180.00, 50),
    ('Cooking Oil 1L',  'Groceries',  320.00, 30),
    ('Bathing Soap',    'Toiletries',  85.00, 100),
    ('Notebook A4',     'Stationery',  60.00, 200);

-- Task 10: insert all 4 orders
INSERT INTO sunrise_supermarket.orders (customer_id, order_date, status)
VALUES
    (1, '2024-03-01', 'Delivered'),
    (2, '2024-03-02', 'Pending'),
    (1, '2024-03-03', 'Delivered'),
    (3, '2024-03-04', 'Cancelled');

-- Task 11: insert all 4 order_items
INSERT INTO sunrise_supermarket.order_items (order_id, product_id, quantity)
VALUES
    (1, 1, 2),
    (1, 3, 1),
    (2, 2, 1),
    (3, 4, 5);

-- Task 12: update order_id 2 so its status becomes 'Delivered'
UPDATE sunrise_supermarket.orders
SET status = 'Delivered'
WHERE order_id = 2;

-- Task 13: delete the cancelled order (order_id 4)
-- order_id 4 has no matching rows in order_items, so no child rows need deleting first
DELETE FROM sunrise_supermarket.orders
WHERE order_id = 4;

SELECT * FROM sunrise_supermarket.customers;
SELECT * FROM sunrise_supermarket.products;
SELECT * FROM sunrise_supermarket.orders;
SELECT * FROM sunrise_supermarket.order_items;


-- ============================================================
-- PART 3 - Filtering & Operators
-- ============================================================

-- Task 14: every product priced above 100
SELECT product_name, unit_price
FROM sunrise_supermarket.products
WHERE unit_price > 100;

-- Task 15: every customer NOT based in Nairobi
SELECT full_name, city
FROM sunrise_supermarket.customers
WHERE city != 'Nairobi';

-- Task 16: every product priced between 60 and 200, inclusive
SELECT product_name, unit_price
FROM sunrise_supermarket.products
WHERE unit_price BETWEEN 60 AND 200;

-- Task 17: every customer in Nairobi, Nakuru, or Mombasa, using IN
SELECT full_name, city
FROM sunrise_supermarket.customers
WHERE city IN ('Nairobi', 'Nakuru', 'Mombasa');

-- Task 18: every product whose name contains 'Oil', using LIKE
SELECT product_name
FROM sunrise_supermarket.products
WHERE product_name LIKE '%Oil%';

-- Task 19: every 'Pending' order, sorted by order_date, earliest first
SELECT order_id, order_date, status
FROM sunrise_supermarket.orders
WHERE status = 'Pending'
ORDER BY order_date;

-- Task 20 (Challenge): the 2 most expensive products, using ORDER BY and LIMIT
SELECT product_name, unit_price
FROM sunrise_supermarket.products
ORDER BY unit_price DESC
LIMIT 2;


-- ============================================================
-- PART 4 - Grouping & Aggregates
-- ============================================================

-- Task 21: how many orders each customer_id has placed
SELECT customer_id, COUNT(*) AS order_count
FROM sunrise_supermarket.orders
GROUP BY customer_id
ORDER BY customer_id;

-- Task 22 (Challenge): customer_id values with more than 1 order, using HAVING
SELECT customer_id, COUNT(*) AS order_count
FROM sunrise_supermarket.orders
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY customer_id;


-- ============================================================
-- PART 5 - JOINS
-- ============================================================

-- Task 23: INNER JOIN customers with orders - full_name next to order_id and status
SELECT c.full_name, o.order_id, o.status
FROM sunrise_supermarket.customers AS c
INNER JOIN sunrise_supermarket.orders AS o
    ON c.customer_id = o.customer_id
ORDER BY o.order_id;

-- Task 24: LEFT JOIN orders with order_items so every order shows, even with no items
-- Note: before order_id 4 was deleted in Task 13, this JOIN would have shown it
-- with a NULL quantity, since it had no matching rows in order_items.
SELECT o.order_id, o.status, oi.quantity
FROM sunrise_supermarket.orders AS o
LEFT JOIN sunrise_supermarket.order_items AS oi
    ON o.order_id = oi.order_id
ORDER BY o.order_id;

-- Task 25: JOIN order_items with products - product_name and quantity together
SELECT p.product_name, oi.quantity
FROM sunrise_supermarket.order_items AS oi
INNER JOIN sunrise_supermarket.products AS p
    ON oi.product_id = p.product_id
ORDER BY oi.order_item_id;

-- Task 26 (Challenge): join all four tables - full_name, order_id, product_name, quantity
SELECT c.full_name, o.order_id, p.product_name, oi.quantity
FROM sunrise_supermarket.customers AS c
INNER JOIN sunrise_supermarket.orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN sunrise_supermarket.order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN sunrise_supermarket.products AS p
    ON oi.product_id = p.product_id
ORDER BY o.order_id;

-- Task 27 (Challenge): total quantity ordered per product_name, using the 4-table JOIN
SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM sunrise_supermarket.customers AS c
INNER JOIN sunrise_supermarket.orders AS o
    ON c.customer_id = o.customer_id
INNER JOIN sunrise_supermarket.order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN sunrise_supermarket.products AS p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC;
