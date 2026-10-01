CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price REAL
);
INSERT INTO products (product_id, product_name, category, price)
VALUES
(1, 'Laptop', 'Electronics', 3500),
(2, 'Phone', 'Electronics', 2200),
(3, 'Headphones', 'Accessories', 300),
(4, 'Keyboard', 'Accessories', 250),
(5, 'Monitor', 'Electronics', 1200);
CREATE TABLE sales (
    sale_id INTEGER PRIMARY KEY,
    product_id INTEGER,
    quantity INTEGER,
    sale_date TEXT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO sales (sale_id, product_id, quantity, sale_date)
VALUES
(1, 1, 2, '2026-09-01'),
(2, 2, 3, '2026-09-03'),
(3, 3, 5, '2026-09-05'),
(4, 1, 1, '2026-09-10'),
(5, 4, 4, '2026-09-12'),
(6, 5, 2, '2026-09-15'),
(7, 2, 2, '2026-09-20'),
(8, 3, 3, '2026-09-25');

-- Analysis 1: Total units sold for each product
SELECT 
    p.product_name,
    SUM(s.quantity) AS total_sold
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;
-- Analysis 2: Total revenue for each product
SELECT
    p.product_name,
    SUM(s.quantity * p.price) AS total_revenue
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Analysis 3: Total revenue by category
SELECT
    p.category,
    SUM(s.quantity * p.price) AS total_revenue
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Analysis 4: Best selling product
SELECT
    p.product_name,
    SUM(s.quantity) AS total_sold
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 1;

-- Analysis 5: Average product price
SELECT
    category,
    ROUND(AVG(price), 2) AS average_price
FROM products
GROUP BY category
ORDER BY average_price DESC;

-- Analysis 6: Number of sales transactions for each product
SELECT
    p.product_name,
    COUNT(s.sale_id) AS number_of_sales
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY number_of_sales DESC;

-- Analysis 7: Most expensive product
SELECT
    product_name,
    price
FROM products
ORDER BY price DESC
LIMIT 1;

-- Analysis 8: Cheapest product
SELECT
    product_name,
    price
FROM products
ORDER BY price ASC
LIMIT 1;

-- Analysis 9: Total store revenue
SELECT
    SUM(s.quantity * p.price) AS total_store_revenue
FROM products p
JOIN sales s ON p.product_id = s.product_id;

-- Analysis 10: Product with highest revenue
SELECT
    p.product_name,
    SUM(s.quantity * p.price) AS total_revenue
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 1;