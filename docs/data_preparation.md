# Data Preparation

## Objective

The transactional database is highly normalized, making analytical queries complex and repetitive. During this phase, analytical views are created by aggregating transactional data into denormalized datasets.

The following analytical views will be developed:

- order_summary
- customer_summary
- product_summary
- seller_summary

Each view has a clearly defined grain and is designed for reporting, business intelligence, and machine learning.


## Order Summary View

### Purpose

The `order_summary` view provides a denormalized order-level dataset by combining information from orders, order items, payments, and reviews.

### Grain

One row represents one order.

### Source Tables

- orders
- order_items
- order_payments
- order_reviews

### Features

- Order details
- Financial metrics
- Product metrics
- Delivery metrics
- Review score

This view serves as the foundation for customer, seller, and product analytical datasets.

## Customer Summary View

### Purpose

Provides one analytical record per customer by aggregating order-level metrics from the `order_summary` view.

### Grain

One row represents one unique customer (`customer_unique_id`).

### Source Tables

- customers
- customer_summary


### Key Features

- Total orders
- Total products purchased
- Total amount spent
- Average order value
- Average review score
- Average delivery time
- First and last purchase dates
- Customer lifetime