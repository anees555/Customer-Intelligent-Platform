-- count the number of columns for each table
SELECT
    table_name,
    COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_schema = 'public'
GROUP BY table_name
ORDER BY table_name;

-- inspecting datatype of each column of each table in database
SELECT
	table_name,
	column_name,
	data_type
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;

-- Column profiling
-- Study one table at a time

-- Customers profiling

-- How many customers
SELECT COUNT(*) AS CustomerCount
FROM customers
-- 99441

-- How many unique customers
SELECT COUNT(DISTINCT customer_unique_id)
FROM customers
-- 96096

-- How many states
SELECT COUNT(DISTINCT customer_state) 
FROM Customers
-- 27

-- How many cities
SELECT COUNT(DISTINCT customer_city) 
FROM Customers
-- 4119

-- top 10 customer states
SELECT COUNT(customer_id), customer_state
FROM customer
GROUP BY customer_state
ORDER BY COUNT(customer_id) DESC LIMIT 10;

-- top 10 customer cities
SELECT COUNT(customer_id), customer_city
FROM customer
GROUP BY customer_city
ORDER BY COUNT(customer_id) DESC LIMIT 10;

-- knowing missing value
SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_id) AS customer_id,
    COUNT(customer_unique_id) AS customer_unique_id,
    COUNT(customer_zip_code_prefix) AS zip_code,
    COUNT(customer_city) AS city,
    COUNT(customer_state) AS state
FROM customers;
-- no missing value identified

-- Total number of rows in orders table
SELECT COUNT(*) AS total_orders
FROM orders;

-- order status ovservation
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- timespan between the first order to the last order in the table
SELECT
    MIN(order_purchase_timestamp) AS first_order,
    MAX(order_purchase_timestamp) AS last_order
FROM orders;

-- missing value ovservation
SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id,
    COUNT(customer_id) AS customer_id,
    COUNT(order_status) AS order_status,
    COUNT(order_purchase_timestamp) AS purchase_time,
    COUNT(order_approved_at) AS approved_at,
    COUNT(order_delivered_carrier_date) AS carrier_date,
    COUNT(order_delivered_customer_date) AS delivered_date,
    COUNT(order_estimated_delivery_date) AS estimated_delivery
FROM orders;

-- to find out the top 10 repeated customers
SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC
LIMIT 10;

-- to analyse the monthly sales trend
SELECT
	DATE_TRUNC('month', order_purchase_timestamp) AS month,
	COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month

-- to calculate the average, minimum and maximum delivery time form purchase time to delivered time 
SELECT
    AVG(order_delivered_customer_date - order_purchase_timestamp) AS avg_delivery_time,
	MAX(order_delivered_customer_date - order_purchase_timestamp) AS max_delivery_time,
	MIN(order_delivered_customer_date - order_purchase_timestamp) AS min_delivery_time
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- to count the total number of delayed orders
SELECT
    COUNT(*) AS delayed_orders
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date;

-- ------------ Product Profiling---------------------
-- inspect the product data
SELECT 
* 
FROM products LIMIT 5

-- count the total rows in product table
SELECT COUNT(*) AS total_products
FROM products;

-- count the number of products in each product category
SELECT COUNT(DISTINCT product_category_name) AS total_categories
FROM products;

-- top 10 product categories
SELECT
    product_category_name,
    COUNT(*) AS total_products
FROM products
GROUP BY product_category_name
ORDER BY total_products DESC
LIMIT 10;


-- missing value ovservation
SELECT
    COUNT(*) AS total_rows,
    COUNT(product_category_name) AS category,
    COUNT(product_name_length) AS name_length,
    COUNT(product_description_length) AS description_length,
    COUNT(product_photos_qty) AS photos,
    COUNT(product_weight_g) AS weight,
    COUNT(product_length_cm) AS length,
    COUNT(product_height_cm) AS height,
    COUNT(product_width_cm) AS width
FROM products;

-- product numerical summary
SELECT
    ROUND(AVG(product_weight_g), 2) AS avg_weight,
    ROUND(MIN(product_weight_g), 2) AS min_weight,
    ROUND(MAX(product_weight_g), 2) AS max_weight,

    ROUND(AVG(product_length_cm), 2) AS avg_length,
    ROUND(AVG(product_height_cm), 2) AS avg_height,
    ROUND(AVG(product_width_cm), 2) AS avg_width
FROM products;

-- product name statistics
SELECT
    AVG(product_name_length) AS avg_name_length,
    MIN(product_name_length) AS min_name_length,
    MAX(product_name_length) AS max_name_length
FROM products;

-- product description statistics
SELECT
    ROUND(AVG(product_description_length), 2) AS avg_description_length,
    MIN(product_description_length) AS min_description_length,
    MAX(product_description_length) AS max_description_length
FROM products;

-- product photo statistics
SELECT
    ROUND(AVG(product_photos_qty), 2) AS avg_photos,
    MIN(product_photos_qty) AS min_photos,
    MAX(product_photos_qty) AS max_photos
FROM products;