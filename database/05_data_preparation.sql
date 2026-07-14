--- Order Summary -----------
    -- PART A - item_summary
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

-- ============================================
-- ORDER SUMMARY VALIDATION
-- ============================================

-- row count
SELECT COUNT(*)
FROM order_summary;

-- check uniqueness
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders
FROM order_summary;

-- check null
SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id,
    COUNT(customer_id) AS customer_id,
    COUNT(total_items) AS total_items,
    COUNT(total_product_price) AS total_product_price,
    COUNT(total_payment) AS total_payment,
    COUNT(review_score) AS review_score
FROM order_summary;

-- validate the payment consistency
SELECT
    order_id,
    total_product_price,
    total_freight,
    total_payment,
    (total_product_price + total_freight) AS expected_payment
FROM order_summary
WHERE ABS(
    (total_product_price + total_freight) - total_payment
) > 0.01;

-- ==============================================================================================

----------------- Customer summary -------------------------------------------
SELECT
    c.customer_unique_id,
    COUNT(*) AS total_orders,
    SUM(os.total_payment) AS total_spent,
    SUM(os.total_items) AS total_products,
    SUM(os.total_freight) AS total_freight_paid,
    ROUND(AVG(os.total_payment), 2) AS avg_order_value,
    ROUND(AVG(os.review_score), 2) AS avg_review_score,
    ROUND(AVG(os.delivery_days), 2) AS avg_delivery_days,
    MIN(os.order_purchase_timestamp::date) AS first_purchase,
    MAX(os.order_purchase_timestamp::date) AS last_purchase,
    MAX(os.order_purchase_timestamp::date) -
    MIN(os.order_purchase_timestamp::date) AS customer_lifetime_days
FROM customers c
INNER JOIN order_summary os
    ON c.customer_id = os.customer_id
GROUP BY c.customer_unique_id;

-- ============================================
-- CUSTOMER SUMMARY VALIDATION
-- ============================================

SELECT COUNT(*)
FROM customer_summary;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM customer_summary;

SELECT *
FROM customer_summary
ORDER BY total_spent DESC
LIMIT 10;

===============================================================================

------------------ Product Summary for analysis ------------------------------------------

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

================================================================================

----------------------- Seller summary for analysis ----------------------------

SELECT
    s.seller_id,
    s.seller_city,
    s.seller_state,

    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(*) AS total_units_sold,

    SUM(oi.price) AS total_revenue,
    SUM(oi.freight_value) AS total_freight,

    ROUND(AVG(oi.price), 2) AS avg_product_price,
    ROUND(AVG(os.review_score), 2) AS avg_review_score,
    ROUND(AVG(os.delivery_days), 2) AS avg_delivery_days

FROM order_items oi

INNER JOIN order_summary os
    ON oi.order_id = os.order_id

INNER JOIN sellers s
    ON oi.seller_id = s.seller_id

GROUP BY
    s.seller_id,
    s.seller_city,
    s.seller_state;

-- ============================================
-- SELLER SUMMARY VALIDATION
-- ============================================
SELECT COUNT(*)
FROM seller_summary;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT seller_id) AS unique_sellers
FROM seller_summary;

SELECT *
FROM seller_summary
ORDER BY total_revenue DESC
LIMIT 10;