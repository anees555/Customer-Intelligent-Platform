

CREATE OR REPLACE VIEW dim_customer AS

SELECT DISTINCT

    customer_id,
    customer_unique_id,
    customer_city,
    customer_state,
    customer_zip_code_prefix

FROM customers;

-- SELECT *
-- FROM dim_customer
-- LIMIT 5;

-- SELECT COUNT(*)
-- FROM dim_customer;

CREATE OR REPLACE VIEW dim_product AS

SELECT

    p.product_id,

    p.product_category_name,

    pct.product_category_name_english,

    p.product_weight_g,

    p.product_length_cm,

    p.product_height_cm,

    p.product_width_cm,

    p.product_photos_qty

FROM products p

LEFT JOIN product_categories pct
ON p.product_category_name = pct.product_category_name;

CREATE OR REPLACE VIEW dim_seller AS

SELECT DISTINCT

    seller_id,

    seller_city,

    seller_state,

    seller_zip_code_prefix

FROM sellers;

-- SELECT COUNT(*)
-- FROM dim_seller;

-- ----------------------------------------------------------------------------------------------------
-- new table name customer_segments is created on database and imported the customer_segments file 

CREATE TABLE customer_segments (
    customer_unique_id VARCHAR(50) PRIMARY KEY,
    cluster INTEGER,
    segment_name VARCHAR(100)
);

SELECT *
FROM customer_segments
LIMIT 10;

SELECT COUNT(*)
FROM customer_segments;
