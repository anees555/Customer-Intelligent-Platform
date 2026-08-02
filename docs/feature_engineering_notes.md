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

### Feature: Freight Ratio (`freight_ratio`)

**Definition**

Proportion of product revenue spent on freight.

**Formula**

`Freight Ratio = Total Freight / Total Revenue`

**Purpose**

Measures shipping cost relative to product revenue, helping identify products with high logistics costs.

**Business Importance**

Useful for profitability analysis, pricing decisions, and logistics optimization.

**Supports**

- Business Dashboard
- Profitability Analysis
- Logistics Performance

_____________________________________________________________________________________________________________________________________________

### Feature: Popularity Score (`popularity_score`)

**Definition**

Normalized score combining total orders and total units sold.

**Formula**

`Popularity Score = 0.5 × Normalized Orders + 0.5 × Normalized Units Sold`

**Purpose**

Measures overall product demand by considering both purchase frequency and sales volume.

**Business Importance**

Useful for identifying popular products for recommendation systems and business reporting.

**Supports**

- Product Recommendation
- Product Performance Analysis
- Business Dashboard

_____________________________________________________________________________________________________________________________________________

### Feature: Premium Product (`premium_product`)

**Definition**

Binary indicator identifying products with relatively high average selling prices.

**Business Rule**

Products with an average selling price greater than or equal to the **80th percentile (179.99)** are classified as premium products.

- `1` → Premium Product
- `0` → Standard Product

**Purpose**

Separates premium products from standard products based on market pricing, enabling analysis of high-value product performance.

**Business Importance**

This feature supports premium product identification, pricing strategy analysis, product recommendation, and executive dashboards.

**Supports**

- Product Recommendation
- Product Performance Analysis
- Business Dashboard

_____________________________________________________________________________________________________________________________________________

### Feature: Bestseller Flag (`bestseller_flag`)

**Definition**

Binary indicator identifying products with exceptionally high sales volume.

**Business Rule**

Products with total units sold greater than or equal to the **90th percentile (6 units)** are classified as bestsellers.

- `1` → Bestseller
- `0` → Standard Product

**Purpose**

Highlights products with consistently strong market demand, regardless of their selling price.

**Business Importance**

Useful for identifying high-demand products, supporting recommendation systems, inventory planning, and sales performance analysis.

**Supports**

- Product Recommendation
- Sales Forecasting
- Product Performance Analysis
- Business Dashboard

_____________________________________________________________________________________________________________________________________________

### Feature: High Rating Product (`high_rating_product`)

**Definition**

Binary indicator identifying products with consistently high customer satisfaction.

**Business Rule**

Products with an average review score greater than or equal to **4.5** are classified as high-rating products.

- `1` → High Rating Product
- `0` → Standard Rating Product

**Purpose**

Highlights products that consistently receive excellent customer feedback.

**Business Importance**

Useful for product recommendation, quality monitoring, and identifying products that deliver a positive customer experience.

**Supports**

- Product Recommendation
- Product Quality Analysis
- Business Dashboard

_____________________________________________________________________________________________________________________________________________
_____________________________________________________________________________________________________________________________________________

## Seller Feature Engineering

Seller feature engineering focuses on creating business-oriented features that describe seller performance, pricing strategy, logistics efficiency, and customer satisfaction. Unlike customer features, these features are primarily intended for marketplace analysis and business intelligence dashboards rather than serving as primary inputs for customer-focused machine learning models.

---

### Feature: Revenue per Order (`revenue_per_order`)

**Definition**

Average revenue generated by a seller for each completed order.

**Formula**

`Revenue per Order = Total Revenue / Total Orders`

**Purpose**

Measures the average monetary value generated from each order handled by a seller, allowing comparison between sellers with many low-value orders and those with fewer high-value orders.

**Business Importance**

Useful for evaluating seller performance, identifying high-value sellers, and supporting marketplace performance analysis.

**Supports**

- Seller Performance Analysis
- Business Dashboard

_____________________________________________________________________________________________________________________________________________

### Feature: Freight Ratio (`freight_ratio`)

**Definition**

Proportion of seller revenue spent on freight charges.

**Formula**

`Freight Ratio = Total Freight / Total Revenue`

**Purpose**

Measures shipping cost relative to revenue, providing an indication of logistics efficiency.

**Business Importance**

Useful for identifying sellers with relatively high shipping costs and supporting logistics optimization and profitability analysis.

**Supports**

- Logistics Performance Analysis
- Business Dashboard

_____________________________________________________________________________________________________________________________________________

### Feature: Premium Seller (`premium_seller`)

**Definition**

Binary indicator identifying sellers that primarily sell higher-priced products.

**Business Rule**

Sellers with an average product price greater than or equal to the **80th percentile (202.97)** are classified as premium sellers.

- `1` → Premium Seller
- `0` → Standard Seller

**Purpose**

Distinguishes sellers specializing in premium-priced products from the rest of the marketplace.

**Business Importance**

Useful for marketplace segmentation, seller performance evaluation, and premium seller identification.

**Supports**

- Seller Performance Analysis
- Business Dashboard

_____________________________________________________________________________________________________________________________________________

### Feature: High Rating Seller (`high_rating_seller`)

**Definition**

Binary indicator identifying sellers with consistently high customer satisfaction.

**Business Rule**

Sellers with an average review score greater than or equal to **4.5** are classified as high-rating sellers.

- `1` → High Rating Seller
- `0` → Standard Rating Seller

**Purpose**

Highlights sellers that consistently receive excellent customer reviews.

**Business Importance**

Useful for monitoring service quality, identifying trusted sellers, and supporting seller recommendation and marketplace analysis.

**Supports**

- Seller Quality Analysis
- Business Dashboard

_____________________________________________________________________________________________________________________________________________

### Feature: Fast Delivery Seller (`fast_delivery_seller`)

**Definition**

Binary indicator identifying sellers with faster-than-average delivery performance.

**Business Rule**

Sellers with an average delivery time less than or equal to the **dataset median (11 days)** are classified as fast-delivery sellers.

- `1` → Fast Delivery Seller
- `0` → Standard Delivery Seller

**Purpose**

Measures seller logistics efficiency by distinguishing sellers that consistently deliver products more quickly than the marketplace median.

**Business Importance**

Useful for evaluating fulfillment performance, identifying operationally efficient sellers, and supporting logistics analysis.

**Supports**

- Logistics Performance Analysis
- Seller Performance Analysis
- Business Dashboard

_____________________________________________________________________________________________________________________________________________
_____________________________________________________________________________________________________________________________________________