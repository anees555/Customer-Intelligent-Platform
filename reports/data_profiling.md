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
