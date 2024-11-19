-- Users Table
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    last_login DATETIME NULL
);
-- can Add more columns based on use case like dob (if we are targeting for a specific Age range) , SSN ( if we are planning to add our own credit checks or validations in future). 
-- Also can create a new Address table with userId as foriegn key  or add additional address columns here to look what products are sold more in a form specific area


-- Product Categories Look up Table
CREATE TABLE categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description NVARCHAR(MAX) NULL
);

-- Products Look up Table
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description NVARCHAR(MAX) NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Index on category_id
CREATE INDEX idx_category ON products(category_id);

-- Customer Orders Table
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT GETDATE(),
    status VARCHAR(20) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Indexes
CREATE INDEX idx_user ON orders(user_id);
CREATE INDEX idx_order_date ON orders(order_date);

-- Customer Order Details Table
CREATE TABLE order_details (
    order_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Indexes
CREATE INDEX idx_order ON order_details(order_id);
CREATE INDEX idx_product ON order_details(product_id);

-- Customer Reviews Table
CREATE TABLE reviews (
    review_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment NVARCHAR(MAX) NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_user_review FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_product_review FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Index on product_id and rating
CREATE INDEX idx_product_rating ON reviews(product_id, rating);
