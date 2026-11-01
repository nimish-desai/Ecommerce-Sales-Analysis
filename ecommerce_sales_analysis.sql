-- ============================================================
-- PROJECT: E-COMMERCE SALES ANALYSIS
-- Author: Nimish Desai
-- Database: ecommerce_sales
-- Description: SQL analysis of a fictional e-commerce business.
-- Note: All data is fictional and created for learning purposes.
-- ============================================================

-- 1. DATABASE SETUP
CREATE DATABASE IF NOT EXISTS ecommerce_sales;
USE ecommerce_sales;

-- 2. TABLE CREATION
-- IF NOT EXISTS prevents errors if the tables already exist.

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    email VARCHAR(100),
    signup_date DATE
);

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 3. SAMPLE DATA
-- INSERT IGNORE avoids duplicate-key errors if this section is run again.

INSERT IGNORE INTO customers
(customer_id, customer_name, city, email, signup_date)
VALUES
(101, 'Rahul Sharma', 'Mumbai', 'rahul@gmail.com', '2026-01-05'),
(102, 'Priya Patel', 'Pune', 'priya@gmail.com', '2026-01-08'),
(103, 'Amit Verma', 'Delhi', 'amit@gmail.com', '2026-01-12'),
(104, 'Sneha Desai', 'Bengaluru', 'sneha@gmail.com', '2026-01-15'),
(105, 'Karan Mehta', 'Mumbai', 'karan@gmail.com', '2026-01-20'),
(106, 'Neha Shah', 'Navi Mumbai', 'neha@gmail.com', '2026-02-02'),
(107, 'Arjun Rao', 'Bengaluru', 'arjun@gmail.com', '2026-02-05'),
(108, 'Pooja Singh', 'Delhi', 'pooja@gmail.com', '2026-02-10'),
(109, 'Vikram Joshi', 'Pune', 'vikram@gmail.com', '2026-02-14'),
(110, 'Ananya Iyer', 'Mumbai', 'ananya@gmail.com', '2026-02-18');

INSERT IGNORE INTO products
(product_id, product_name, category, price)
VALUES
(201, 'Laptop', 'Electronics', 55000),
(202, 'Smartphone', 'Electronics', 25000),
(203, 'Monitor', 'Electronics', 12000),
(204, 'Headphones', 'Accessories', 2500),
(205, 'Keyboard', 'Accessories', 1500),
(206, 'Mouse', 'Accessories', 800),
(207, 'Office Chair', 'Furniture', 8000),
(208, 'Study Desk', 'Furniture', 6000);

INSERT IGNORE INTO orders
(order_id, customer_id, order_date, order_status)
VALUES
(5001, 101, '2026-01-10', 'Delivered'),
(5002, 102, '2026-01-12', 'Delivered'),
(5003, 103, '2026-01-18', 'Delivered'),
(5004, 104, '2026-01-22', 'Delivered'),
(5005, 105, '2026-01-25', 'Cancelled'),
(5006, 101, '2026-02-03', 'Delivered'),
(5007, 106, '2026-02-06', 'Delivered'),
(5008, 107, '2026-02-10', 'Shipped'),
(5009, 108, '2026-02-15', 'Delivered'),
(5010, 109, '2026-02-20', 'Delivered'),
(5011, 110, '2026-02-23', 'Processing'),
(5012, 102, '2026-02-26', 'Delivered');

INSERT IGNORE INTO order_details
(order_detail_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 5001, 201, 1, 55000),
(2, 5001, 204, 2, 2500),
(3, 5002, 202, 1, 25000),
(4, 5002, 206, 1, 800),
(5, 5003, 201, 1, 55000),
(6, 5004, 203, 2, 12000),
(7, 5005, 207, 1, 8000),
(8, 5006, 202, 1, 25000),
(9, 5006, 204, 1, 2500),
(10, 5007, 208, 1, 6000),
(11, 5007, 205, 2, 1500),
(12, 5008, 201, 1, 55000),
(13, 5009, 206, 3, 800),
(14, 5010, 207, 1, 8000),
(15, 5010, 204, 1, 2500),
(16, 5011, 202, 1, 25000),
(17, 5012, 203, 1, 12000),
(18, 5012, 205, 1, 1500);

-- 4. DATA VALIDATION
SELECT 'customers' AS table_name, COUNT(*) AS total_records FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_details', COUNT(*) FROM order_details;

-- 5. BUSINESS ANALYSIS QUERIES

-- Q1. Total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Q2. Total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Q3. Total order-line value across all order statuses.
-- This includes cancelled, shipped and processing orders.
SELECT SUM(quantity * unit_price) AS total_order_value
FROM order_details;

-- Q4. Revenue by product across all order statuses.
SELECT
    p.product_name,
    SUM(od.quantity * od.unit_price) AS total_order_value
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_order_value DESC;

-- Q5. List products in the Electronics category.
SELECT *
FROM products
WHERE category = 'Electronics';

-- Q6. Order-line value by customer city across all statuses.
SELECT
    c.city,
    SUM(od.quantity * od.unit_price) AS total_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.city
ORDER BY total_order_value DESC;

-- Q7. Top five customers by total order value across all statuses.
SELECT
    c.customer_name,
    c.city,
    SUM(od.quantity * od.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC
LIMIT 5;

-- Q8. Monthly order value across all statuses.
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(od.quantity * od.unit_price) AS monthly_order_value
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;

-- Q9. Revenue from delivered orders only.
SELECT
    SUM(od.quantity * od.unit_price) AS delivered_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
WHERE o.order_status = 'Delivered';

-- Q10. Products with order value greater than 10,000 across all statuses.
SELECT
    p.product_name,
    SUM(od.quantity * od.unit_price) AS total_order_value
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(od.quantity * od.unit_price) > 10000
ORDER BY total_order_value DESC;

-- Q11. Number of orders by status.
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Q12. Product revenue from delivered orders only.
SELECT
    p.product_name,
    SUM(od.quantity * od.unit_price) AS delivered_revenue
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY delivered_revenue DESC;

-- Q13. Units sold by product from delivered orders only.
SELECT
    p.product_name,
    SUM(od.quantity) AS total_units_sold
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name
ORDER BY total_units_sold DESC;

-- Q14. Delivered revenue by product category.
SELECT
    p.category,
    SUM(od.quantity * od.unit_price) AS total_revenue
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Q15. Customers who placed more than one order.
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;

-- Q16. Customers who have never placed an order.
SELECT
    c.customer_id,
    c.customer_name,
    c.city
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Q17. Latest order date for each customer.
SELECT
    c.customer_name,
    MAX(o.order_date) AS latest_order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY latest_order_date DESC;

-- Q18. Customers spending above the average customer spending.
-- The calculation includes all order statuses.
SELECT
    c.customer_name,
    SUM(od.quantity * od.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(od.quantity * od.unit_price) >
(
    SELECT AVG(customer_total)
    FROM (
        SELECT
            o.customer_id,
            SUM(od.quantity * od.unit_price) AS customer_total
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        GROUP BY o.customer_id
    ) AS customer_spending
)
ORDER BY total_spent DESC;

-- Q19. Rank products by delivered revenue within each category.
SELECT
    p.category,
    p.product_name,
    SUM(od.quantity * od.unit_price) AS total_revenue,
    RANK() OVER (
        PARTITION BY p.category
        ORDER BY SUM(od.quantity * od.unit_price) DESC
    ) AS category_rank
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.category, p.product_id, p.product_name
ORDER BY p.category, category_rank;

-- ============================================================
-- END OF PROJECT
-- Important: Revenue/order value is calculated as quantity
-- multiplied by unit_price. It is not profit.
-- ============================================================
