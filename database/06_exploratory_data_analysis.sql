/*
Section 1: Executive KPIs
High-level metrics.
These answer: "How is the business performing overall?"

Examples:

Total Revenue
Total Orders
Total Customers
Average Order Value
Average Delivery Time
Average Review Score
Repeat Customer Rate
*/
-- KPI 1: Total Revenue
SELECT
    ROUND(SUM(total_payment), 2) AS total_revenue
FROM order_summary;

-- KPI 2: Total Orders
SELECT
    COUNT(*) AS total_orders
FROM order_summary;

-- KPI 3: Total Customers
SELECT
    COUNT(*) AS total_customers
FROM customer_summary;

-- KPI 4: Average Order Value (AOV)
SELECT
    ROUND(AVG(total_payment), 2) AS average_order_value
FROM order_summary;

-- KPI 5: Average Delivery Time
SELECT
    ROUND(AVG(delivery_days), 2) AS average_delivery_days
FROM order_summary;

-- KPI 6: Average Customer Rating
SELECT
    ROUND(AVG(review_score), 2) AS average_review_score
FROM order_summary;

-- KPI 7: Repeat Customer Rate
-- Percentage of customers who have placed more than one order.
SELECT
    ROUND(
        100.0 *
        COUNT(*) FILTER (WHERE total_orders > 1)
        / COUNT(*),
        2
    ) AS repeat_customer_rate
FROM customer_summary;