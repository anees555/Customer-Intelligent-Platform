# Customer Summary Data Preprocessing

## Overview

The customer summary dataset was profiled and evaluated before feature engineering. The objective of this phase was not to modify the data unnecessarily, but to assess its overall quality and determine whether any preprocessing actions were required. Each identified issue was investigated from both statistical and business perspectives before making a cleaning decision.

---

## 1. Data Type Conversion

### Objective

Ensure every column is stored using an appropriate data type for efficient analysis and future modeling.

### Actions Performed

- Converted monetary columns to `float`
- Converted review and delivery metrics to `float`
- Converted purchase date columns to `datetime`
- Verified integer columns for counts and lifetime values
- Preserved customer identifiers as string values

### Result

The dataset now uses appropriate data types for numerical computation, statistical analysis, visualization, and machine learning.

---

## 2. Missing Value Analysis

### Objective

Identify missing values and determine whether they represent data quality issues or expected business scenarios.

### Findings

| Column | Missing Records | Percentage | Decision |
|---------|----------------:|-----------:|----------|
| avg_delivery_days | 2,064 | 2.16% | Keep |
| avg_review_score | 699 | 0.73% | Keep |
| total_spent | 1 | <0.01% | Remove |
| avg_order_value | 1 | <0.01% | Remove |

### Business Interpretation

#### Missing Delivery Days

Customers with missing delivery days primarily correspond to orders that were cancelled, unavailable, or had not yet been delivered. Since delivery was never completed, calculating delivery time is not possible.

These missing values represent valid business events rather than data quality issues.

**Decision:** Retain these records without imputation.

---

#### Missing Review Scores

Some customers never submitted product reviews after receiving their orders.

A missing review does not indicate an error; it simply reflects customer behavior.

**Decision:** Retain these missing values.

---

#### Missing Revenue Values

One customer record contains missing values for both `total_spent` and `avg_order_value`.

Because these fields are essential financial metrics and only a single record is affected, the record is removed.

**Decision:** Remove the single invalid record.

---

## 3. Duplicate Analysis

### Objective

Verify that each customer appears only once within the customer summary table.

### Findings

- Duplicate records detected: **0**

### Decision

No duplicate removal was required.

---

## 4. Outlier Analysis

### Objective

Identify statistically unusual observations using the Interquartile Range (IQR) method.

### Findings

Several numerical variables contained observations outside the calculated IQR boundaries, including:

- Total orders
- Total spending
- Average order value
- Total products purchased
- Freight paid
- Delivery days
- Customer lifetime
- Average review score


<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Column</th>
      <th>Q1</th>
      <th>Q3</th>
      <th>IQR</th>
      <th>Lower Bound</th>
      <th>Upper Bound</th>
      <th>Outlier Count</th>
      <th>Outlier Percentage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>5</th>
      <td>avg_review_score</td>
      <td>4.00</td>
      <td>5.00</td>
      <td>1.00</td>
      <td>2.50</td>
      <td>6.50</td>
      <td>13313</td>
      <td>13.95</td>
    </tr>
    <tr>
      <th>2</th>
      <td>total_products</td>
      <td>1.00</td>
      <td>1.00</td>
      <td>0.00</td>
      <td>1.00</td>
      <td>1.00</td>
      <td>11868</td>
      <td>12.44</td>
    </tr>
    <tr>
      <th>3</th>
      <td>total_freight_paid</td>
      <td>14.08</td>
      <td>25.54</td>
      <td>11.46</td>
      <td>-3.11</td>
      <td>42.73</td>
      <td>9216</td>
      <td>9.66</td>
    </tr>
    <tr>
      <th>1</th>
      <td>total_spent</td>
      <td>63.10</td>
      <td>183.27</td>
      <td>120.17</td>
      <td>-117.16</td>
      <td>363.52</td>
      <td>7595</td>
      <td>7.96</td>
    </tr>
    <tr>
      <th>4</th>
      <td>avg_order_value</td>
      <td>62.44</td>
      <td>177.15</td>
      <td>114.71</td>
      <td>-109.62</td>
      <td>349.22</td>
      <td>7534</td>
      <td>7.90</td>
    </tr>
    <tr>
      <th>6</th>
      <td>avg_delivery_days</td>
      <td>7.00</td>
      <td>16.00</td>
      <td>9.00</td>
      <td>-6.50</td>
      <td>29.50</td>
      <td>4563</td>
      <td>4.78</td>
    </tr>
    <tr>
      <th>0</th>
      <td>total_orders</td>
      <td>1.00</td>
      <td>1.00</td>
      <td>0.00</td>
      <td>1.00</td>
      <td>1.00</td>
      <td>2913</td>
      <td>3.05</td>
    </tr>
    <tr>
      <th>7</th>
      <td>customer_lifetime_days</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>0.00</td>
      <td>2085</td>
      <td>2.19</td>
    </tr>
  </tbody>
</table>
</div>

### Business Interpretation

Although these observations are statistically classified as outliers, they represent legitimate customer behavior rather than incorrect data.

Examples include:

- High-value customers with exceptionally large purchases
- Loyal customers placing multiple orders
- Customers with longer purchase histories
- Remote customers experiencing longer delivery times
- Extremely positive or negative customer reviews

Removing these records would eliminate valuable business information and could bias future customer segmentation and predictive modeling.

### Decision

No outliers were removed.

---

# Final Preprocessing Decisions

| Data Quality Issue | Action Taken | Reason |
|--------------------|--------------|--------|
| Data type inconsistencies | Converted | Required for analysis and modeling |
| Missing delivery days | Retained | Valid business scenario |
| Missing review scores | Retained | Customer chose not to leave a review |
| Missing revenue values | Removed (1 record) | Invalid financial data |
| Duplicate records | None found | No action required |
| Statistical outliers | Retained | Represent genuine customer behavior |

---

# Summary

The customer summary dataset was found to be of high overall quality. Most identified issues were determined to be natural outcomes of marketplace operations rather than data quality problems. As a result, only a single invalid record containing missing financial values will be removed, while all other observations will be retained to preserve the integrity of real customer behavior.

Following these preprocessing decisions, the customer summary dataset is considered ready for feature engineering, statistical analysis, and machine learning.

_____________________________________________________________________________________________________________________________________________

# Order Data Preprocessing Summary

## Dataset Overview

The `order_summary` dataset was inspected to evaluate data quality before feature engineering and machine learning. The preprocessing process focused on validating data types, identifying missing values, detecting duplicate records, investigating business inconsistencies, and assessing numerical outliers.

---

## 1. Data Type Validation

All columns were converted to appropriate data types.

- Numeric columns were converted to `int64` or `float64`.
- Date-related columns were converted to `datetime`.
- Identifier columns were retained as string values.

This ensures accurate numerical computations and date-based feature engineering.

---

## 2. Missing Value Analysis

Several columns contained missing values that were investigated individually.

<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>missing_values</th>
      <th>missing_percentage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>delivery_days</th>
      <td>2190</td>
      <td>2.22</td>
    </tr>
    <tr>
      <th>order_delivered_customer_date</th>
      <td>2190</td>
      <td>2.22</td>
    </tr>
    <tr>
      <th>delivery_delay_days</th>
      <td>2190</td>
      <td>2.22</td>
    </tr>
    <tr>
      <th>order_delivered_carrier_date</th>
      <td>1009</td>
      <td>1.02</td>
    </tr>
    <tr>
      <th>review_score</th>
      <td>749</td>
      <td>0.76</td>
    </tr>
    <tr>
      <th>order_approved_at</th>
      <td>14</td>
      <td>0.01</td>
    </tr>
    <tr>
      <th>total_payment</th>
      <td>1</td>
      <td>0.00</td>
    </tr>
    <tr>
      <th>product_payment</th>
      <td>1</td>
      <td>0.00</td>
    </tr>
  </tbody>
</table>
</div>

### Business-valid Missing Values

The following missing values represent legitimate business scenarios and were intentionally preserved.

- `order_delivered_customer_date`
- `delivery_days`
- `delivery_delay_days`

These values are unavailable for orders that were not successfully delivered.

Similarly, missing `review_score` values indicate that customers did not submit a product review, which is expected behavior rather than a data quality issue.

### Data Quality Issues

Two minor inconsistencies were identified.

- **14 delivered orders** contained missing `order_approved_at` timestamps despite having complete shipping and delivery information. These records represent data collection inconsistencies and were retained because they account for only **0.01%** of the dataset.
- **One delivered order** contained missing payment values (`total_payment` and `product_payment`) despite having valid product and freight amounts. Since the payment amount can be reconstructed using business rules (`product price + freight`), this record was identified for correction.

---

## 3. Duplicate Analysis

No duplicate `order_id` values or duplicate records were identified.

The dataset maintains one record per order and preserves entity integrity.

---

## 4. Outlier Analysis

Outliers were detected using the Interquartile Range (IQR) method.

<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Column</th>
      <th>Q1</th>
      <th>Q3</th>
      <th>IQR</th>
      <th>Lower Bound</th>
      <th>Upper Bound</th>
      <th>Outlier Count</th>
      <th>Outlier Percentage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>8</th>
      <td>review_score</td>
      <td>4.00</td>
      <td>5.00</td>
      <td>1.00</td>
      <td>2.50</td>
      <td>6.50</td>
      <td>13849</td>
      <td>14.04</td>
    </tr>
    <tr>
      <th>5</th>
      <td>total_freight</td>
      <td>13.85</td>
      <td>24.04</td>
      <td>10.19</td>
      <td>-1.44</td>
      <td>39.33</td>
      <td>9941</td>
      <td>10.08</td>
    </tr>
    <tr>
      <th>2</th>
      <td>total_items</td>
      <td>1.00</td>
      <td>1.00</td>
      <td>0.00</td>
      <td>1.00</td>
      <td>1.00</td>
      <td>9803</td>
      <td>9.94</td>
    </tr>
    <tr>
      <th>7</th>
      <td>product_payment</td>
      <td>45.90</td>
      <td>149.90</td>
      <td>104.00</td>
      <td>-110.10</td>
      <td>305.90</td>
      <td>7917</td>
      <td>8.02</td>
    </tr>
    <tr>
      <th>4</th>
      <td>total_product_price</td>
      <td>45.90</td>
      <td>149.90</td>
      <td>104.00</td>
      <td>-110.10</td>
      <td>305.90</td>
      <td>7913</td>
      <td>8.02</td>
    </tr>
    <tr>
      <th>6</th>
      <td>total_payment</td>
      <td>62.00</td>
      <td>176.88</td>
      <td>114.88</td>
      <td>-110.32</td>
      <td>349.20</td>
      <td>7777</td>
      <td>7.88</td>
    </tr>
    <tr>
      <th>0</th>
      <td>delivery_days</td>
      <td>7.00</td>
      <td>16.00</td>
      <td>9.00</td>
      <td>-6.50</td>
      <td>29.50</td>
      <td>4732</td>
      <td>4.80</td>
    </tr>
    <tr>
      <th>1</th>
      <td>delivery_delay_days</td>
      <td>-17.00</td>
      <td>-7.00</td>
      <td>10.00</td>
      <td>-32.00</td>
      <td>8.00</td>
      <td>4301</td>
      <td>4.36</td>
    </tr>
    <tr>
      <th>3</th>
      <td>distinct_sellers</td>
      <td>1.00</td>
      <td>1.00</td>
      <td>0.00</td>
      <td>1.00</td>
      <td>1.00</td>
      <td>1278</td>
      <td>1.30</td>
    </tr>
  </tbody>
</table>
</div>

### Key Observations

- High `review_score` outliers primarily represent low customer ratings (scores of 1 and 2). These are genuine customer feedback and should not be removed.
- Large values in `total_product_price`, `product_payment`, `total_payment`, and `total_freight` correspond to expensive purchases rather than erroneous transactions.
- Higher values in `delivery_days` and positive `delivery_delay_days` indicate legitimately slow deliveries.
- Orders containing multiple products or multiple sellers naturally appear as outliers because most marketplace orders consist of a single item purchased from a single seller.

### Decision

No outliers were removed because they represent valid business behavior rather than measurement errors. Preserving these observations is essential for accurately modeling customer purchasing behavior, logistics performance, and revenue distribution.

---

## Overall Decision

The `order_summary` dataset is of high quality and requires only minimal preprocessing before feature engineering.

The only corrective action identified is reconstructing the missing payment values for a single record. All remaining missing values and numerical outliers represent valid marketplace behavior and will be preserved for subsequent exploratory analysis and machine learning.

_____________________________________________________________________________________________________________________________________________

# Product Data Preprocessing Summary

## Overview

The `product_summary` dataset was evaluated to assess data quality before feature engineering and machine learning. The preprocessing process focused on validating data types, identifying missing values, detecting duplicate records, and analyzing numerical outliers. Since this table contains aggregated product-level metrics, most extreme values reflect genuine marketplace behavior rather than data quality issues.

---

## 1. Data Type Validation

All columns were converted to their appropriate data types.

- Numeric columns were converted to `int64` or `float64`.
- The product identifier was retained as a string.

This ensures consistent calculations and compatibility with subsequent analytical and machine learning tasks.

---

## 2. Missing Value Analysis

Three columns contained missing values that were investigated individually.

<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>missing_values</th>
      <th>missing_percentage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>avg_delivery_days</th>
      <td>737</td>
      <td>2.24</td>
    </tr>
    <tr>
      <th>product_category_name</th>
      <td>610</td>
      <td>1.85</td>
    </tr>
    <tr>
      <th>avg_review_score</th>
      <td>162</td>
      <td>0.49</td>
    </tr>
  </tbody>
</table>
</div>

### Business-valid Missing Values

The following missing values represent valid business scenarios and were intentionally preserved.

- **`product_category_name` (610 records)**

  These products do not have an associated category in the original Olist dataset. Since the original category information is unavailable, these values were retained rather than assigning an artificial category.

- **`avg_review_score` (162 records)**

  These products have not received any customer reviews. The missing values indicate the absence of reviews rather than poor customer satisfaction and therefore were preserved.

- **`avg_delivery_days` (737 records)**

  These products belong to orders that were not successfully delivered. Since delivery never occurred, the average delivery time cannot be calculated. These missing values were retained as valid business observations.

---

## 3. Duplicate Analysis

No duplicate `product_id` values or duplicate records were identified.

Each product appears exactly once in the summary dataset, preserving entity integrity.

---

## 4. Outlier Analysis

Outliers were detected using the Interquartile Range (IQR) method.

<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Column</th>
      <th>Q1</th>
      <th>Q3</th>
      <th>IQR</th>
      <th>Lower Bound</th>
      <th>Upper Bound</th>
      <th>Outlier Count</th>
      <th>Outlier Percentage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>total_orders</td>
      <td>1.00</td>
      <td>2.00</td>
      <td>1.0</td>
      <td>-0.50</td>
      <td>3.50</td>
      <td>5538</td>
      <td>16.81</td>
    </tr>
    <tr>
      <th>2</th>
      <td>total_revenue</td>
      <td>59.90</td>
      <td>329.00</td>
      <td>269.1</td>
      <td>-343.75</td>
      <td>732.65</td>
      <td>3717</td>
      <td>11.28</td>
    </tr>
    <tr>
      <th>3</th>
      <td>total_freight</td>
      <td>15.94</td>
      <td>58.04</td>
      <td>42.1</td>
      <td>-47.21</td>
      <td>121.19</td>
      <td>3585</td>
      <td>10.88</td>
    </tr>
    <tr>
      <th>0</th>
      <td>total_units_sold</td>
      <td>1.00</td>
      <td>3.00</td>
      <td>2.0</td>
      <td>-2.00</td>
      <td>6.00</td>
      <td>3102</td>
      <td>9.41</td>
    </tr>
    <tr>
      <th>4</th>
      <td>avg_price</td>
      <td>39.90</td>
      <td>154.90</td>
      <td>115.0</td>
      <td>-132.60</td>
      <td>327.40</td>
      <td>2817</td>
      <td>8.55</td>
    </tr>
    <tr>
      <th>5</th>
      <td>avg_review_score</td>
      <td>3.60</td>
      <td>5.00</td>
      <td>1.4</td>
      <td>1.50</td>
      <td>7.10</td>
      <td>2773</td>
      <td>8.42</td>
    </tr>
    <tr>
      <th>6</th>
      <td>avg_delivery_days</td>
      <td>7.00</td>
      <td>15.00</td>
      <td>8.0</td>
      <td>-5.00</td>
      <td>27.00</td>
      <td>1384</td>
      <td>4.20</td>
    </tr>
  </tbody>
</table>
</div>

### Key Observations

- Products with exceptionally high **total orders**, **units sold**, and **revenue** represent the marketplace's best-selling products rather than erroneous records.
- Higher **freight costs** are expected for larger, heavier, or geographically distant shipments.
- High **average prices** correspond to premium or high-value products available on the marketplace.
- Lower **average review scores** reflect genuine customer dissatisfaction and should not be treated as invalid observations.
- Longer **average delivery times** are consistent with logistics challenges and deliveries to remote regions.

### Decision

No outliers were removed because they represent legitimate business behavior rather than measurement or data entry errors. Retaining these observations preserves valuable information regarding product popularity, pricing strategies, customer satisfaction, and logistics performance.

---

## Overall Decision

The `product_summary` dataset demonstrates high overall data quality and requires minimal preprocessing before feature engineering.

All identified missing values represent valid business scenarios and were preserved. Likewise, all detected outliers correspond to meaningful marketplace behavior and were intentionally retained to ensure that subsequent analyses and machine learning models accurately capture real-world business patterns.

_____________________________________________________________________________________________________________________________________________

# Seller Data Preprocessing Summary

## Overview

The `seller_summary` dataset was evaluated to assess data quality before feature engineering and machine learning. The preprocessing process included validating data types, identifying missing values, checking duplicate records, and detecting numerical outliers. As this dataset contains aggregated seller-level metrics, most extreme values represent natural differences in seller performance rather than data quality issues.

---

## 1. Data Type Validation

All columns were converted to appropriate data types.

- Numeric columns were converted to `int64` or `float64`.
- Seller identifiers and location attributes were retained as string values.

This ensures accurate numerical analysis and compatibility with downstream modeling tasks.

---

## 2. Missing Value Analysis

<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>missing_values</th>
      <th>missing_percentage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>avg_delivery_days</th>
      <td>125</td>
      <td>4.04</td>
    </tr>
    <tr>
      <th>avg_review_score</th>
      <td>5</td>
      <td>0.16</td>
    </tr>
  </tbody>
</table>
</div>

Only two columns contained missing values.

### Business-valid Missing Values

The following missing values represent legitimate business situations and were intentionally preserved.

- **`avg_review_score` (5 records)**

  These sellers have no completed customer reviews associated with their orders. The missing values indicate the absence of review information rather than poor seller performance.

- **`avg_delivery_days` (125 records)**

  These sellers only have orders that were cancelled, unavailable, or otherwise not delivered. Since no successful deliveries occurred, the average delivery time cannot be calculated.

No imputation was performed because these missing values accurately represent business conditions rather than data errors.

---

## 3. Duplicate Analysis

No duplicate `seller_id` values or duplicate records were identified.

Each seller appears exactly once in the summary dataset, ensuring entity integrity.

---

## 4. Outlier Analysis

<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Column</th>
      <th>Q1</th>
      <th>Q3</th>
      <th>IQR</th>
      <th>Lower Bound</th>
      <th>Upper Bound</th>
      <th>Outlier Count</th>
      <th>Outlier Percentage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>total_orders</td>
      <td>2.00</td>
      <td>21.50</td>
      <td>19.50</td>
      <td>-27.25</td>
      <td>50.75</td>
      <td>421</td>
      <td>13.60</td>
    </tr>
    <tr>
      <th>1</th>
      <td>total_units_sold</td>
      <td>2.00</td>
      <td>24.00</td>
      <td>22.00</td>
      <td>-31.00</td>
      <td>57.00</td>
      <td>416</td>
      <td>13.44</td>
    </tr>
    <tr>
      <th>2</th>
      <td>total_revenue</td>
      <td>208.85</td>
      <td>3280.83</td>
      <td>3071.98</td>
      <td>-4399.12</td>
      <td>7888.80</td>
      <td>380</td>
      <td>12.28</td>
    </tr>
    <tr>
      <th>3</th>
      <td>total_freight</td>
      <td>46.17</td>
      <td>558.17</td>
      <td>512.00</td>
      <td>-721.83</td>
      <td>1326.17</td>
      <td>371</td>
      <td>11.99</td>
    </tr>
    <tr>
      <th>4</th>
      <td>avg_product_price</td>
      <td>52.18</td>
      <td>174.00</td>
      <td>121.81</td>
      <td>-130.53</td>
      <td>356.71</td>
      <td>298</td>
      <td>9.63</td>
    </tr>
    <tr>
      <th>5</th>
      <td>avg_review_score</td>
      <td>3.71</td>
      <td>4.60</td>
      <td>0.89</td>
      <td>2.38</td>
      <td>5.93</td>
      <td>246</td>
      <td>7.95</td>
    </tr>
    <tr>
      <th>6</th>
      <td>avg_delivery_days</td>
      <td>8.21</td>
      <td>14.09</td>
      <td>5.88</td>
      <td>-0.60</td>
      <td>22.90</td>
      <td>142</td>
      <td>4.59</td>
    </tr>
  </tbody>
</table>
</div>

Outliers were detected using the Interquartile Range (IQR) method.

### Key Observations

- Sellers with exceptionally high **total orders** and **units sold** represent the marketplace's highest-performing sellers rather than abnormal records.
- Higher values in **total revenue** reflect successful sellers with larger sales volumes and higher-value transactions.
- Large **total freight** values are expected for sellers processing many orders or shipping larger products.
- Higher **average product prices** indicate sellers specializing in premium or expensive products.
- Lower **average review scores** represent genuine customer feedback and should not be considered erroneous data.
- Longer **average delivery times** are consistent with differences in seller location, shipping practices, and logistics performance.

### Decision

No outliers were removed because all identified extreme values represent legitimate business variation. Preserving these observations is essential for accurately analyzing seller performance, revenue contribution, customer satisfaction, and operational efficiency.

---

## Overall Decision

The `seller_summary` dataset demonstrates high overall data quality and requires only minimal preprocessing before feature engineering.

All missing values correspond to valid business scenarios and were intentionally preserved. Likewise, all statistical outliers represent meaningful differences in seller performance rather than data quality issues. Consequently, no records were removed or modified during preprocessing, ensuring that genuine marketplace behavior remains available for exploratory analysis and predictive modeling.