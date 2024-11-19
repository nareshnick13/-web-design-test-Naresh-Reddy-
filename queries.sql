-- Simple CRUD Operations

-- Insert a new user

INSERT INTO users (email, first_name, last_name)
VALUES ('chowacothebest@email.com', 'Chowaco', 'Thankyou');


-- Update a product's price
UPDATE products SET price = 999.99 WHERE product_id = 1;


-- Delete an old order
DELETE FROM orders WHERE order_date < DATEADD(YEAR, -1, GETDATE());


-- Complex Queries

-- Total sales by product category for a specific month
SELECT 
    c.name AS category_name,
    SUM(od.quantity * od.unit_price) AS total_sales
FROM categories c
  JOIN products p ON c.category_id = p.category_id
  JOIN order_details od ON p.product_id = od.product_id
  JOIN orders o ON od.order_id = o.order_id
WHERE MONTH(o.order_date) = MONTH(GETDATE()) AND YEAR(o.order_date) = YEAR(GETDATE())
GROUP BY c.name;


-- Users who have never placed an order
SELECT u.first_name, u.last_name, u.email
FROM users u
  LEFT JOIN orders o ON u.user_id = o.user_id
WHERE o.order_id IS NULL;


-- Top 5 products by average review rating
SELECT 
    p.name,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(r.review_id) AS review_count
FROM products p
LEFT JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name
HAVING COUNT(r.review_id) >= 3
ORDER BY avg_rating DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;


-- Number of orders per day for the last 30 days
SELECT 
    CAST(order_date AS DATE) AS order_day,
    COUNT(*) AS order_count
FROM orders
WHERE order_date >= DATEADD(DAY, -30, GETDATE())
GROUP BY CAST(order_date AS DATE)
ORDER BY order_day DESC;
