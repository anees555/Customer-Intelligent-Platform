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
/*
__________________________________________________________________________________________________________________________________

Section 2: Customer Analysis

Top customers by spending
Revenue Concentration (Pareto Analysis)
Spending distribution
One-time vs. repeat customers
Customer lifetime value
Purchase frequency
Average time between purchases
Customer lifetime
Churn indicators
*/
-- Analysis 1: Top Customers by Spending

SELECT
    customer_unique_id,
    total_spent
FROM customer_summary
ORDER BY total_spent DESC
LIMIT 10;

-- Analysis 2: Revenue Concentration (Pareto Analysis)
-- Business Question:
-- What percentage of total revenue is contributed by the top 1%, 5%, and 10% of customers?
WITH ranked_customers AS (
    SELECT
        customer_unique_id,
        total_spent,
        ROW_NUMBER() OVER (
            ORDER BY total_spent DESC
        ) AS customer_rank,
        COUNT(*) OVER () AS total_customers,
        SUM(total_spent) OVER () AS total_revenue
    FROM customer_summary
)

SELECT
    'Top 1%' AS customer_group,
    ROUND(
        SUM(total_spent) * 100.0 /
        MAX(total_revenue),
        2
    ) AS revenue_percentage
FROM ranked_customers
WHERE customer_rank <= CEIL(total_customers * 0.01)

UNION ALL

SELECT
    'Top 5%',
    ROUND(
        SUM(total_spent) * 100.0 /
        MAX(total_revenue),
        2
    )
FROM ranked_customers
WHERE customer_rank <= CEIL(total_customers * 0.05)

UNION ALL

SELECT
    'Top 10%',
    ROUND(
        SUM(total_spent) * 100.0 /
        MAX(total_revenue),
        2
    )
FROM ranked_customers
WHERE customer_rank <= CEIL(total_customers * 0.10);

-- Analysis 3: Customer Spending Distribution
SELECT
    CASE
        WHEN total_spent < 100 THEN 'Below 100'
        WHEN total_spent < 500 THEN '100 - 499'
        WHEN total_spent < 1000 THEN '500 - 999'
        WHEN total_spent < 2000 THEN '1000 - 1999'
        ELSE '2000+'
    END AS spending_range,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS customer_percentage
FROM customer_summary
GROUP BY spending_range
ORDER BY
    MIN(total_spent);

-- Analysis 4: One-time vs. Repeat Customers
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS customer_percentage
FROM customer_summary
GROUP BY customer_type;

-- Analysis 5: Purchase Frequency Distribution
-- How frequently do customers make purchases?

SELECT
    CASE
        WHEN total_orders = 1 THEN '1 Order'
        WHEN total_orders = 2 THEN '2 Orders'
        WHEN total_orders = 3 THEN '3 Orders'
        WHEN total_orders BETWEEN 4 AND 5 THEN '4-5 Orders'
        ELSE '6+ Orders'
    END AS purchase_frequency,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS customer_percentage
FROM customer_summary
GROUP BY purchase_frequency
ORDER BY
    MIN(total_orders);

-- Analysis 6: Customer Lifetime Analysis
-- How long do customers remain active between their first and last purchase?
-- Analysis 6.1: Overall Customer Lifetime
SELECT
    ROUND(AVG(customer_lifetime_days), 2) AS avg_customer_lifetime_days,
    MIN(customer_lifetime_days) AS min_customer_lifetime_days,
    MAX(customer_lifetime_days) AS max_customer_lifetime_days
FROM customer_summary;

-- Analysis 6.2: Customer Lifetime Distribution
SELECT
    CASE
        WHEN customer_lifetime_days = 0 THEN 'Single Purchase'
        WHEN customer_lifetime_days <= 30 THEN '1-30 Days'
        WHEN customer_lifetime_days <= 90 THEN '31-90 Days'
        WHEN customer_lifetime_days <= 180 THEN '91-180 Days'
        WHEN customer_lifetime_days <= 365 THEN '181-365 Days'
        ELSE '365+ Days'
    END AS lifetime_group,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS customer_percentage
FROM customer_summary
GROUP BY lifetime_group
ORDER BY
    MIN(customer_lifetime_days);

-- Analysis 7: Average Time Between Orders
-- How many days, on average, do repeat customers wait before placing their next order?
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        o.order_purchase_timestamp::date AS order_date,
        LAG(o.order_purchase_timestamp::date) OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp
        ) AS previous_order_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
)

SELECT
    ROUND(
        AVG(order_date - previous_order_date),
        2
    ) AS avg_days_between_orders
FROM customer_orders
WHERE previous_order_date IS NOT NULL;

-- Analysis 8: Churn Analysis
-- Customer churn means a customer has stopped purchasing from the business.
-- I assumed a customer is considered at risk of churn if they have not placed an order
-- in the last 180 days before the latest purchase date. but this can be depend on the business and product type
WITH reference_date AS (
    SELECT MAX(last_purchase) AS max_date
    FROM customer_summary
)

SELECT
    CASE
        WHEN (SELECT max_date FROM reference_date) - last_purchase > 180
            THEN 'At Risk'
        ELSE 'Active'
    END AS customer_status,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS customer_percentage
FROM customer_summary
GROUP BY customer_status;