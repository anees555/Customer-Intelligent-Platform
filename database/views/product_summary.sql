
-------------- PRODUCT SUMMARY VIEW ----------------------

CREATE OR REPLACE VIEW product_summary AS


SELECT 
	p.product_id,
	p.product_category_name,
	COUNT(*) AS total_units_sold,
	COUNT(DISTINCT oi.order_id) AS total_orders,
	SUM(oi.price) AS total_revenue,
	SUM(oi.freight_value) AS total_freight,
	ROUND(AVG(oi.price), 2) AS avg_price,
	ROUND(AVG(review_score), 2) AS avg_review_score,
	ROUND(AVG(delivery_days), 2) AS avg_delivery_days
FROM order_items oi
INNER JOIN order_summary os
ON os.order_id = oi.order_id 
INNER JOIN products p
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_category_name;