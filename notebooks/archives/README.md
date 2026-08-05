# Customer Churn Prediction (Archived)

## Overview

Customer churn prediction was initially planned as one of the machine learning modules of the **Customer Intelligence Platform**. The objective was to identify customers who were unlikely to make future purchases using historical transaction data from the Olist Brazilian E-commerce dataset.

During implementation, two different approaches were explored and evaluated. Although both approaches were technically implemented, further analysis revealed that the Olist dataset is not well suited for supervised customer churn prediction. Consequently, this module has been archived and excluded from the final project.

---

# Objective

Develop a supervised machine learning model capable of predicting whether a customer is likely to churn based on historical purchasing behavior and engineered customer features.

---

# Approach 1: Rule-Based Churn Label (Recency Threshold)

## Methodology

The first approach defined churn using a simple business rule:

> Customers whose **recency exceeded a predefined threshold** were labeled as churned.

Customer features included:

- Total Orders
- Total Spending
- Average Order Value
- Delivery Performance
- Review Score
- Freight Ratio
- Customer Lifetime
- Recency
- Basket Size
- RFM Features

Several classification algorithms were trained, including:

- Logistic Regression
- Decision Tree
- Random Forest
- XGBoost

---

## Problem Encountered

Including **recency_days** as an input feature produced nearly perfect classification performance.

Example results:

| Model | Accuracy |
|--------|----------|
| Decision Tree | 100% |
| Random Forest | 100% |
| XGBoost | 99%+ |

Although these results initially appeared impressive, they were caused by **target leakage**.

Since the target variable itself was created directly from `recency_days`, the models simply learned the rule used to generate the labels rather than discovering meaningful behavioral patterns.

Removing `recency_days` eliminated the leakage but also caused model performance to collapse because the remaining customer features contained very limited predictive information.

This indicated that the constructed target was not suitable for a realistic supervised learning problem.

---

# Approach 2: Time-Based Churn Definition

To eliminate target leakage, a second and more production-oriented methodology was implemented.

## Methodology

A temporal train-label split was created using:

- Observation Period
- Cutoff Date
- Prediction Window

```
Historical Customer Behavior
        │
        ▼
-------------------- Cutoff --------------------
        │
        ▼
Future Purchase Window (90 Days)
```

Customers were labeled as:

- **Active** → Purchased again during the next 90 days.
- **Churned** → Did not purchase again during the prediction window.

This approach follows the standard methodology commonly used in production churn prediction systems.

---

## Dataset Analysis

Historical customer statistics:

| Metric | Value |
|--------|-------:|
| Customers before cutoff | 49,237 |
| Customers purchasing during prediction window | 20,224 |

At first glance, these numbers suggested that a reasonable prediction problem existed.

However, deeper investigation revealed a critical limitation.

Only **336 customers** who existed before the cutoff actually made another purchase during the prediction window.

The remaining customers appearing after the cutoff were almost entirely **new customers**, not returning ones.

As a result:

- Repeat purchasing behavior was extremely limited.
- Almost every historical customer was labeled as churned.
- The generated dataset became highly imbalanced.
- The resulting machine learning models were not meaningful despite the correct implementation.

---

# Key Findings

This investigation highlighted an important limitation of the Olist dataset.

Unlike subscription-based businesses or retail platforms with frequent repeat purchases, Olist primarily represents transactional e-commerce behavior where many customers purchase only once.

Because the dataset does not provide:

- an explicit churn label,
- customer subscription information,
- account activity status,
- or sufficient repeat purchasing behavior,

it does not naturally support supervised customer churn prediction.

---

# Conclusion

After evaluating multiple methodologies, customer churn prediction was intentionally excluded from the final project.

This decision was based on data suitability rather than implementation complexity.

The investigation demonstrated that:

- Rule-based churn labels introduced target leakage.
- Time-based labeling produced an extremely small number of returning customers.
- The available customer behavior was insufficient for building a reliable supervised churn prediction model.

Rather than forcing an unreliable model, the project focuses on machine learning tasks that are strongly supported by the available data.

---

# Final Project Direction

The archived churn prediction module was replaced by models that better align with the characteristics of the Olist dataset:

- Customer Segmentation
- Customer Lifetime Value (CLV) Prediction
- Sales Forecasting

These tasks leverage the strengths of the dataset while providing more reliable and actionable business insights.

---

## Note

This archived work is preserved as part of the project to document the complete data science workflow, including problem formulation, experimentation, validation, identification of dataset limitations, and informed decision-making regarding model feasibility.