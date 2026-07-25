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