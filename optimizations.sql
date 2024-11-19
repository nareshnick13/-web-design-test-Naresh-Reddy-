-- Optimization Recommendations

-- 1. Create indexes for frequently queried columns
            -- Index on product price
            CREATE INDEX idx_product_price ON products(price);            
            -- Index on order status
            CREATE INDEX idx_order_status ON orders(status);            
            -- Index on review created_at timestamp
            CREATE INDEX idx_review_created ON reviews(created_at);


-- 2. Create composite indexes for common query patterns
          -- Composite index on user_id and order_date in orders table
        CREATE INDEX idx_order_user_date ON orders(user_id, order_date);        
        -- Composite index on category_id and price in products table
        CREATE INDEX idx_product_category_price ON products(category_id, price);




-- 4. Materialized view for frequently accessed aggregations          
          CREATE VIEW mv_product_ratings AS
          SELECT 
              p.product_id,
              p.name,
              AVG(r.rating) AS avg_rating,
              COUNT(r.review_id) AS review_count
          FROM products p
          LEFT JOIN reviews r ON p.product_id = r.product_id
          GROUP BY p.product_id, p.name;
          
          -- index on the view for better performance
          CREATE UNIQUE CLUSTERED INDEX idx_mv_product_ratings
          ON mv_product_ratings (product_id);
