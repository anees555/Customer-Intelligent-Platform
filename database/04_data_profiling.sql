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


