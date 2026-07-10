## Customers Table Profiling

### Dataset Overview

* Total customer records: **99,441**
* Unique customers (`customer_unique_id`): **96,096**
* States represented: **27**
* Cities represented: **4,119**

### Geographic Distribution

* The largest customer population is concentrated in the states of **SP**, **RJ**, **MG**, **RS**, and **PR**.
* The cities with the highest number of customers are **São Paulo**, **Rio de Janeiro**, **Belo Horizonte**, **Brasília**, and **Curitiba**.

### Data Quality Assessment

* No missing values were found in any column.
* `customer_id` is unique for every record and serves as the transactional customer identifier.
* The number of unique `customer_unique_id` values is lower than the total number of records, indicating that some customers have multiple `customer_id` values.

### Initial Business Insight

The customer base is heavily concentrated in Brazil's major urban and economically developed regions. Additionally, the presence of multiple `customer_id` values for the same `customer_unique_id` suggests that a single customer may have placed multiple orders or may have been assigned different transactional identifiers over time. This distinction will be important when calculating customer-level metrics such as Customer Lifetime Value (CLV), Recency-Frequency-Monetary (RFM) analysis, and customer segmentation.
Here i found out that the customer_id simply represent that each time a customer places a order, the customer id is created so
if person places the order 17 times, then 17 unique customer_id is generated for the same customer_unique_id
so in simple way:
customer_id -> unique identifier for a customer's order-specific record.
custome_unique_id -> unique identifier for the customer


## Orders Table Profiling

### Dataset Overview

* Total order records: **99,441**
* Dataset time span: **September 2016 – October 2018**

### Order Status Distribution

The majority of orders were successfully completed.

| Order Status                            | Observation                                                          |
| --------------------------------------- | -------------------------------------------------------------------- |
| Delivered                               | Dominant order status, representing approximately 97% of all orders. |
| Shipped                                 | Small number of orders were still in transit.                        |
| Canceled                                | A limited number of orders were canceled.                            |
| Unavailable                             | Some orders could not be fulfilled due to product unavailability.    |
| Processing, Invoiced, Approved, Created | Represent orders at different stages of the order lifecycle.         |

### Data Quality Assessment

* `order_id`, `customer_id`, `order_status`, `order_purchase_timestamp`, and `order_estimated_delivery_date` contain no missing values.
* Missing values are present in:

  * `order_approved_at`
  * `order_delivered_carrier_date`
  * `order_delivered_customer_date`
* These missing values are expected because orders that were canceled or not completed never progressed through the full delivery process.

### Customer Purchasing Behavior

* Repeat purchases were identified by joining the `orders` and `customers` tables and grouping by `customer_unique_id`.
* The most active customer placed **17 orders** during the dataset period.
* This confirms that customer-level analyses such as Customer Lifetime Value (CLV), RFM segmentation, and customer retention analysis are appropriate for this dataset.

### Monthly Order Trend

* Order volume increased steadily throughout 2017.
* A significant peak was observed in **November 2017**, indicating a period of exceptionally high customer demand.
* Order volumes remained consistently high during most of 2018.
* The sharp decline in September and October 2018 is likely due to the dataset ending during those months rather than an actual decrease in business activity.

### Delivery Performance

* Average delivery time: **approximately 12.5 days**
* Minimum delivery time: **approximately 13 hours**
* Maximum delivery time: **209 days**

The large gap between the average and maximum delivery times suggests the presence of extreme delivery delays or outlier cases that should be investigated further.

### Delivery Delays

* **7,827 orders** were delivered after the estimated delivery date.

This indicates that a noticeable portion of deliveries experienced delays. In later stages of the project, the relationship between delivery delays and customer review scores will be analyzed to evaluate their impact on customer satisfaction.

### Initial Business Insights

* The business maintained a high order completion rate, with the vast majority of orders successfully delivered.
* Customer demand increased rapidly during 2017 and remained stable through most of 2018.
* Repeat customers are present, supporting customer loyalty analyses.
* Delivery performance appears satisfactory on average, but extreme delivery delays and late deliveries warrant further investigation.


## Products Table Profiling

### Dataset Overview

* Total product records: **32,951**
* Product categories: **73**

### Product Distribution

* The largest product categories are **cama_mesa_banho**, **esporte_lazer**, **moveis_decoracao**, **beleza_saude**, and **utilidades_domesticas**, indicating that home, lifestyle, and leisure products dominate the marketplace.

### Data Quality Assessment

* **610** products have missing category, name length, description length, and photo count information.
* Only **2** products have missing physical dimensions (weight, length, height, and width).
* Overall, the dataset is highly complete with only a small proportion of missing values.

### Product Characteristics

* Average product weight: **2.28 kg**
* Average dimensions: **30.82 cm × 16.94 cm × 23.20 cm**
* Product names average **48 characters** in length.
* Product descriptions average **772 characters**, indicating that most products contain detailed descriptions.
* Products have an average of **2.19 images**, with some listings containing up to **20 images**.

### Initial Business Insights

* The marketplace offers a diverse product catalog across **73 categories**.
* Home-related and lifestyle products represent the largest share of the inventory.
* Product metadata is largely complete, making the dataset suitable for feature engineering and predictive modeling.


## Order Items Table Profiling

### Dataset Overview

* Total order item records: **112,650**
* Orders containing at least one item: **98,666**
* Unique products sold: **32,951**
* Active sellers: **3,095**

### Data Quality Assessment

* No missing values were found in any column.
* The number of unique orders in `order_items` is **775 fewer** than the total number of orders in the `orders` table, indicating that some orders do not have associated order items. These are primarily orders that did not complete the normal fulfillment process.

### Pricing & Shipping

* Average product price: **120.65**
* Product prices range from **0.85** to **6,735.00**.
* Average freight cost: **19.99**
* Freight charges range from **0.00** to **409.68**.

### Order Characteristics

* Some orders contain multiple products, with the largest order consisting of **21 items**.
* Product sales are concentrated among a relatively small number of highly popular products.
* The highest-revenue products differ from the most frequently sold products, indicating that expensive products can generate substantial revenue even with lower sales volumes.

### Initial Business Insights

* The marketplace offers products from over **3,000 sellers**, demonstrating a diverse seller ecosystem.
* Product popularity and product revenue are not always correlated, suggesting that both sales volume and product price contribute to business performance.
* The `order_items` table will serve as the primary source for revenue analysis, sales trends, and customer purchasing behavior in later stages of the project.
