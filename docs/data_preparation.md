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

## Product Summary View

### Purpose

The `product_summary` view provides one analytical record per product by combining product information with sales and order-level metrics. It is designed to support product performance analysis, category analysis, and sales reporting.

### Grain

One row represents one product (`product_id`).

### Source Tables

- products
- order_items
- order_summary

### Features

- Product ID
- Product category
- Total units sold
- Total orders
- Total revenue
- Total freight
- Average selling price
- Average review score
- Average delivery days

### Notes

- Revenue represents the total selling price of products and does not include freight charges.
- Review scores are available at the order level in the Olist dataset. Therefore, when an order contains multiple products, the same review score is associated with each product in that order.


## Seller Summary View

### Purpose

The `seller_summary` view provides one analytical record per seller by combining seller information with sales and order-level metrics. It is designed to support seller performance analysis, revenue analysis, and geographical seller insights.

### Grain

One row represents one seller (`seller_id`).

### Source Tables

- sellers
- order_items
- order_summary

### Features

- Seller ID
- Seller city
- Seller state
- Total orders
- Total units sold
- Total revenue
- Total freight
- Average product price
- Average review score
- Average delivery days

### Notes

- Revenue represents the total selling price of products and excludes freight charges.
- Review scores are available at the order level in the Olist dataset. Therefore, if an order contains products from multiple sellers, the same review score is associated with each seller involved in that order.