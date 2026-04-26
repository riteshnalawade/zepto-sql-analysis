SET search_path TO zepto;

-- Q1.Total number of customers
SELECT COUNT(*) AS total_customers FROM customers;

-- Q2.Total number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Q3.Total number of products
SELECT COUNT(*) AS total_products FROM products;

-- Q4.Total number of stores
SELECT COUNT(*) AS total_stores FROM stores;

-- Q5.Total revenue (delivered orders)
SELECT SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'delivered';

-- Q6.Cancelled orders
SELECT * FROM orders
WHERE status = 'cancelled';

-- Q7.Orders above ₹1000
SELECT order_id, total_amount
FROM orders
WHERE total_amount > 1000;

-- Q8.Customers from Mumbai
SELECT * FROM customers
WHERE city = 'Mumbai';

-- Q9.Average order value
SELECT AVG(total_amount) AS avg_order_value
FROM orders
WHERE status = 'delivered';

-- Q10.Total discount given
SELECT SUM(discount_amt) AS total_discount
FROM orders;

-- Q11.Orders per city
SELECT c.city, COUNT(*) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city;

-- Q12.Orders by status
SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status;

-- Q13.Revenue by city
SELECT c.city, SUM(o.total_amount) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'delivered'
GROUP BY c.city;

-- Q14.Products per category
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category;

-- Q15.Orders with customer names
SELECT o.order_id, c.name, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Q16.Order items with product names
SELECT oi.order_id, p.product_name, oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- Q17.Orders per store
SELECT s.store_name, COUNT(o.order_id) AS total_orders
FROM stores s
JOIN orders o ON s.store_id = o.store_id
GROUP BY s.store_name;

-- Q18.Top 5 highest value orders
SELECT order_id, total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 5;

-- Q19.Latest 5 orders
SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 5;

-- Q20.Total quantity sold per product
SELECT product_id, SUM(quantity) AS total_sold
FROM order_items
GROUP BY product_id;

-- Q21.Customers with more than 3 orders
SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 3;

-- Q22.Average delivery time
SELECT AVG(delivery_minutes) AS avg_delivery_time
FROM deliveries
WHERE status = 'delivered';

-- Q23.Running total of revenue
SELECT 
    order_date::date AS day,
    SUM(total_amount) AS daily_revenue,
    SUM(SUM(total_amount)) OVER (ORDER BY order_date::date) AS running_total
FROM orders
WHERE status = 'delivered'
GROUP BY order_date::date;

-- Q24.Row number for orders by amount
SELECT 
    order_id,
    total_amount,
    ROW_NUMBER() OVER (ORDER BY total_amount DESC) AS row_num
FROM orders;

-- Q25.Rank and dense rank of orders
SELECT 
    order_id,
    total_amount,
    RANK() OVER (ORDER BY total_amount DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY total_amount DESC) AS dense_rank
FROM orders;

-- Q26.Rank orders within each city
SELECT 
    c.city,
    o.order_id,
    o.total_amount,
    RANK() OVER (PARTITION BY c.city ORDER BY o.total_amount DESC) AS city_rank
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Q27.Average order value using window
SELECT 
    order_id,
    total_amount,
    AVG(total_amount) OVER () AS avg_order_value
FROM orders;

-- Q28.Orders count per customer (window)
SELECT 
    customer_id,
    order_id,
    COUNT(*) OVER (PARTITION BY customer_id) AS total_orders
FROM orders;

-- Q29.Previous order amount (LAG)
SELECT 
    order_id,
    total_amount,
    LAG(total_amount) OVER (ORDER BY order_date) AS prev_order
FROM orders;

-- Q30.Percentage contribution of each order
SELECT 
    order_id,
    total_amount,
    ROUND(100.0 * total_amount / SUM(total_amount) OVER (), 2) AS pct_contribution
FROM orders
WHERE status = 'delivered';