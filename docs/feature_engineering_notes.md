## customers

### Feature: Recency (`recency_days`)

**Definition**

Number of days between the customer's most recent purchase and the latest purchase date in the dataset.

**Formula**

`Recency = Reference Date − Last Purchase Date`

**Purpose**

Measures how recently a customer has interacted with the platform.

**Business Importance**

Customers with lower recency values are generally more active and engaged, while higher values may indicate inactivity or potential churn.

**Used In**

- Customer Segmentation
- Customer Churn Prediction
- Customer Lifetime Value (CLV)

_____________________________________________________________________________________________________________________________________________

### Feature: Average Basket Size (`avg_basket_size`)

**Definition**

Average number of products purchased per order.

**Formula**

`Average Basket Size = Total Products / Total Orders`

**Purpose**

Measures a customer's typical purchase quantity per transaction.

**Business Importance**

Customers with larger basket sizes tend to purchase multiple items together, reflecting stronger purchase intent or bulk buying behavior.

**Used In**

- Customer Segmentation
- Customer Lifetime Value (CLV)
- Recommendation Systems

_____________________________________________________________________________________________________________________________________________

### Feature: Freight Ratio (`freight_ratio`)

**Definition**

Proportion of total customer spending allocated to shipping charges.

**Formula**

`Freight Ratio = Total Freight Paid / Total Spent`

**Purpose**

Measures the relative shipping cost borne by each customer instead of the absolute freight amount.

**Business Importance**

Customers with higher freight ratios may be more sensitive to shipping costs and could respond positively to promotions such as free shipping or discounted delivery.

**Used In**

- Customer Segmentation
- Marketing and Pricing Analysis

_____________________________________________________________________________________________________________________________________________

## Product Feature Engineering

### Feature: Revenue per Order (`revenue_per_order`)

**Definition**

Average revenue generated each time a product is purchased.

**Formula**

`Revenue per Order = Total Revenue / Total Orders`

**Purpose**

Measures the monetary value of each product purchase, helping distinguish high-value products from products that generate revenue mainly through high sales volume.

**Business Importance**

Useful for identifying premium products, evaluating product profitability, and supporting product recommendation and pricing strategies.

**Supports**

- Product Recommendation
- Product Performance Analysis
- Business Dashboard

_____________________________________________________________________________________________________________________________________________

### Feature: Revenue per Unit (`revenue_per_unit`)

**Definition**

Average revenue generated for each unit sold.

**Formula**

`Revenue per Unit = Total Revenue / Total Units Sold`

**Purpose**

Measures the realized monetary value of each unit sold, providing an indicator of product value beyond sales volume.

**Business Importance**

Useful for identifying premium products, comparing product pricing performance, and supporting recommendation and profitability analysis.

**Supports**

- Product Recommendation
- Pricing Analysis
- Business Dashboard