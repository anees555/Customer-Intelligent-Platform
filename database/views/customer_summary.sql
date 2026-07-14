------------------ Customer summary view ------------------------------------
CREATE OR REPLACE VIEW customer_summary AS

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