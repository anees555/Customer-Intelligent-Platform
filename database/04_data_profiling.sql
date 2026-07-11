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


----------- Order_items dataset profiling -----------------------

-- count the numeber of records in order_items table
SELECT COUNT(*) AS total_order_items
FROM order_items;

-- count the unique orders that contain items
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM order_items;

SELECT COUNT(DISTINCT product_id) AS unique_products_sold
FROM order_items;


SELECT COUNT(DISTINCT seller_id) AS total_sellers
FROM order_items;

SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id,
    COUNT(order_item_id) AS order_item_id,
    COUNT(product_id) AS product_id,
    COUNT(seller_id) AS seller_id,
    COUNT(shipping_limit_date) AS shipping_limit_date,
    COUNT(price) AS price,
    COUNT(freight_value) AS freight_value
FROM order_items;

SELECT
    ROUND(AVG(price),2) AS avg_price,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM order_items;

SELECT
    ROUND(AVG(freight_value),2) AS avg_freight,
    MIN(freight_value) AS min_freight,
    MAX(freight_value) AS max_freight
FROM order_items;

-- multiple items orders
SELECT
    COUNT(*) AS items_per_order,
    COUNT(order_id) AS total_orders
FROM order_items
GROUP BY order_id
ORDER BY items_per_order DESC
LIMIT 10;

-- most sold product
SELECT
    product_id,
    COUNT(*) AS total_sold
FROM order_items
GROUP BY product_id
ORDER BY total_sold DESC
LIMIT 10;

-- Highest revinue product
SELECT
    product_id,
    ROUND(SUM(price),2) AS revenue
FROM order_items
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 10;

------------ Sellers Table Data profiling -------------------------
-- Count the sellers
SELECT COUNT(*) AS total_sellers
FROM sellers;

-- Geographical distribution
SELECT
    seller_state,
    COUNT(*) AS total_sellers
FROM sellers
GROUP BY seller_state
ORDER BY total_sellers DESC;

-- Top seller cities
SELECT
    seller_city,
    COUNT(*) AS total_sellers
FROM sellers
GROUP BY seller_city
ORDER BY total_sellers DESC
LIMIT 10;

-- Missing Value observation: 
SELECT
    COUNT(*) AS total_rows,
    COUNT(seller_id) AS seller_id,
    COUNT(seller_zip_code_prefix) AS zip_code,
    COUNT(seller_city) AS city,
    COUNT(seller_state) AS state
FROM sellers;

------------ Order Payments table profiling ---------------------------
-- Count the number of rows
SELECT COUNT(*) AS total_payment_records
FROM order_payments;

-- Payment types analysis
SELECT
    payment_type,
    COUNT(*) AS total_transactions
FROM order_payments
GROUP BY payment_type
ORDER BY total_transactions DESC;

-- Installments
SELECT
    payment_installments,
    COUNT(*) AS total_orders
FROM order_payments
GROUP BY payment_installments
ORDER BY payment_installments;

-- payment statistics
SELECT
    ROUND(AVG(payment_value),2) AS avg_payment,
    MIN(payment_value) AS min_payment,
    MAX(payment_value) AS max_payment
FROM order_payments;

-- Missing value observation
SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id),
    COUNT(payment_sequential),
    COUNT(payment_type),
    COUNT(payment_installments),
    COUNT(payment_value)
FROM order_payments;


-------------------- Order Reviews Table profiling ---------------------------

-- Total reviews : 
 SELECT COUNT(*) AS total_reviews
FROM order_reviews;

 -- Review score distribution 
 SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;

 --  Missing value observation: 
 SELECT
    COUNT(*) AS total_rows,
    COUNT(review_id),
    COUNT(order_id),
    COUNT(review_score),
    COUNT(review_comment_title),
    COUNT(review_comment_message),
    COUNT(review_creation_date),
    COUNT(review_answer_timestamp)
FROM order_reviews;

 --  Average review: 
 SELECT
    ROUND(AVG(review_score),2) AS average_rating
FROM order_reviews;

--------- Geolocation Table Profiling --------------------

-- * Total Rows: 
SELECT COUNT(*) AS total_locations
FROM geolocation;

-- * Group by states : 
SELECT
    geolocation_state,
    COUNT(*) AS locations
FROM geolocation
GROUP BY geolocation_state
ORDER BY locations DESC;

-- * total cities : 
SELECT COUNT(DISTINCT geolocation_city)
FROM geolocation;

-- * missing value observation :
SELECT
    COUNT(*) AS total_rows,
    COUNT(geolocation_zip_code_prefix),
    COUNT(geolocation_lat),
    COUNT(geolocation_lng),
    COUNT(geolocation_city),
    COUNT(geolocation_state)
FROM geolocation;

------------- Product categories profiling ---------------------
-- * Count rows: 
SELECT COUNT(*) AS total_categories
FROM product_categories;

-- * Missing value observation: 
SELECT
    COUNT(*) AS total_rows,
    COUNT(product_category_name),
    COUNT(product_category_name_english)
FROM product_categories;
