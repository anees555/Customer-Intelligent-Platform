----------- ORDER SUMMARY VIEW -----------------
CREATE OR REPLACE VIEW order_summary AS

WITH item_summary AS (
    SELECT
        order_id,
        COUNT(*) AS total_items,
        COUNT(DISTINCT seller_id) AS distinct_sellers,
        SUM(price) AS total_product_price,
        SUM(freight_value) AS total_freight
    FROM order_items
    GROUP BY order_id
),
    -- PART B - Payment summary
    payment_summary AS (
    SELECT
        order_id,
        SUM(payment_value) AS total_payment
    FROM order_payments
    GROUP BY order_id
),
    -- PART C - review summary
    review_summary AS (
    SELECT
        order_id,
        ROUND(AVG(review_score), 2) AS review_score
    FROM order_reviews
    GROUP BY order_id
)
SELECT 
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
	(o.order_delivered_customer_date::date - o.order_purchase_timestamp::date) AS delivery_days,
	(o.order_delivered_customer_date::date - o.order_estimated_delivery_date::date) AS delivery_delay_days,
	i.total_items,
	i.distinct_sellers,
	i.total_product_price,
	i.total_freight,
	p.total_payment,
	(p.total_payment - i.total_freight) AS product_payment,
	r.review_score
FROM orders o
JOIN item_summary i
ON o.order_id = i.order_id
LEFT JOIN payment_summary p
ON o.order_id = p.order_id
LEFT JOIN review_summary r
ON o.order_id = r.order_id;