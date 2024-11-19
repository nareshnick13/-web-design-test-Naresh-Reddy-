-- Insert Categories
INSERT INTO categories (name, description) 
VALUES 
('Smart Devices', 'Smart Devices'),
('Books', 'Books'),
('Clothing', 'Apparel and accessories');



-- Insert Users
INSERT INTO users (email, first_name, last_name, created_at) 
VALUES 
('nareshReddy@gmail.com', 'Naresh', 'Reddy', GETDATE()),
('sqlhero@yahoo.com', 'SQL', 'Hero', DATEADD(DAY, -35, GETDATE())),
('lead_engineer@test.com', 'Lead', 'Engineer', DATEADD(DAY, -50, GETDATE()));

-- Though the createdAt has a default with todays date I am still inserting values with different dates for easy querying.

-- Insert Products
INSERT INTO products (category_id, name, description, price, stock_quantity, created_at) 
VALUES 
(1, 'Smartphone', 'Latest model smartphone', 699.99, 50, GETDATE()),
(1, 'Laptop', 'High-performance laptop', 1299.99, 30, GETDATE()),
(2, 'SQL Guide', 'Complete SQL reference', 49.99, 100, GETDATE()),
(3, 'T-Shirt', 'Cotton casual t-shirt', 19.99, 200, GETDATE());


-- Insert Orders
INSERT INTO orders (user_id, status, total_amount, order_date) 
VALUES 
(1, 'completed', 749.98, DATEADD(DAY, -15, GETDATE())),
(2, 'processing', 1299.99, DATEADD(DAY, -25, GETDATE())),
(3, 'completed', 69.98, DATEADD(DAY, -35, GETDATE()));


-- Insert Order Details
INSERT INTO order_details (order_id, product_id, quantity, unit_price) 
VALUES 
(1, 1, 1, 699.99),
(1, 3, 1, 49.99),
(2, 2, 1, 1299.99),
(3, 3, 1, 49.99),
(3, 4, 1, 19.99);


-- Insert Reviews
INSERT INTO reviews (user_id, product_id, rating, comment, created_at) 
VALUES 
(1, 1, 5, 'Excellent smartphone!', DATEADD(DAY, -10, GETDATE())),
(2, 2, 4, 'Great laptop for the price', DATEADD(DAY, -9, GETDATE())),
(3, 3, 5, 'Very comprehensive SQL guide', DATEADD(DAY, -8, GETDATE()));
