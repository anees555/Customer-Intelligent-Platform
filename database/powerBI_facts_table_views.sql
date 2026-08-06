CREATE VIEW fact_orders AS
SELECT
    os.order_id,
    c.customer_unique_id,
    os.order_purchase_timestamp,
    os.order_status,
    os.total_payment,
    os.total_product_price,
    os.total_freight,
    os.total_items,
    os.distinct_sellers,
    os.delivery_days,
    os.delivery_delay_days,
    os.review_score
FROM order_summary os
JOIN customers c
    ON os.customer_id = c.customer_id;

-- ---------------------------------------------------------------------------------------

CREATE VIEW dim_customer AS
SELECT
    customer_unique_id,
    MIN(customer_city) AS customer_city,
    MIN(customer_state) AS customer_state,
    MIN(customer_zip_code_prefix) AS customer_zip_code_prefix
FROM customers
GROUP BY customer_unique_id;