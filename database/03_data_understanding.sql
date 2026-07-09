-- Check row counts
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'product_categories', COUNT(*) FROM product_categories
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation;



-- verify primary key

SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1

SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1

SELECT seller_id, COUNT(*)
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1

SELECT product_id, COUNT(*)
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1

SELECT order_id, order_item_id, COUNT(*)
FROM order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1

SELECT review_id, COUNT(*)
FROM order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1
-- here i found that there are 789 reviews id that are duplicated 
-- so considering review_id as primary key is not good option
-- so i changes the schemas by updating as composite primary key  (order_id, review_id)
SELECT review_id, order_id, COUNT(*)
FROM order_reviews
GROUP BY (review_id, order_id)
HAVING COUNT(*) > 1

SELECT geolocation_id, COUNT(*)
FROM geolocation
GROUP BY geolocation_id
HAVING COUNT(*) > 1

SELECT order_id, payment_sequential, COUNT(*)
FROM order_payments
GROUP BY (order_id, payment_sequential)
HAVING COUNT(*) > 1

SELECT product_category_name, COUNT(*)
FROM product_categories
GROUP BY product_category_name
HAVING COUNT(*) > 1



-- Referential integrity contraints check -- > To check orphan record
SELECT COUNT(*)
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*)
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT COUNT(*)
FROM order_items oi
LEFT JOIN sellers s
ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;

SELECT COUNT(*)
FROM order_payments op
LEFT JOIN orders o
ON op.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*)
FROM order_reviews orr
LEFT JOIN orders o
ON orr.order_id = o.order_id
WHERE o.order_id IS NULL;
-- This returns 610 but when left join is performed if the product_category_name in the product 
-- is null then after join, it becomes null so it returns 610 which can be accetable 
-- by modifying the query like below it results in 0 count
SELECT COUNT(*)
FROM products p
LEFT JOIN product_categories pc
ON p.product_category_name = pc.product_category_name
WHERE p.product_category_name IS NOT NULL
  AND pc.product_category_name IS NULL;