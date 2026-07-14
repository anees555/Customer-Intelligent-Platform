----------------------- SELLER SUMMARY VIEW ----------------------------

CREATE OR REPLACE VIEW seller_summary AS
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