CREATE OR REPLACE VIEW fact_orders AS

SELECT

    order_id,

    customer_id,

    order_purchase_timestamp,

    order_status,

    total_payment,

    total_product_price,

    total_freight,

    total_items,

    distinct_sellers,

    delivery_days,

    delivery_delay_days,

    review_score

FROM order_summary;

-- ---------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW fact_order_items AS

SELECT

    order_id,

    product_id,

    seller_id,

    1 AS quantity,

    price,

    freight_value

FROM order_items;