# Customer Segmentation Business Interpretation

## Overview

This customer segmentation work turns the raw ecommerce data into a practical customer view that can support marketing, retention, and service decisions. The workflow follows three clear stages:

1. **Data preparation**: customer-level features were built from the cleaned source tables.
2. **K-Means modeling**: the customer base was clustered and evaluated using internal clustering metrics.
3. **Cluster analysis**: the final clusters were translated into business-friendly customer segments.

The final result is a segmentation model with **five actionable groups**: Premium Customers, Loyal Customers, Regular Customers, Budget Customers, and Dissatisfied Customers.

## Workflow Summary

### 1. Data preparation

The first notebook prepared a modeling table with **95,419 customers** and a consistent set of features. It combined purchase behavior, spending, delivery performance, and customer value indicators such as:

- total orders
- total spent
- average order value
- average review score
- average delivery days
- customer lifetime days
- recency days
- average basket size
- freight ratio
- R, F, M, and RFM scores

The main business value of this stage is that it converts transaction-level data into a single customer view that can be segmented and compared.

### 2. K-Means modeling

The second notebook tested multiple cluster counts using the **elbow method** and **silhouette score**, supported by additional clustering quality metrics. Although the internal metrics favored fewer clusters in some cases, the **five-cluster solution** was selected because it produced clearer and more useful business segments.

This was an important decision: the goal was not only to optimize a metric, but to create segments that teams can actually use in campaigns, service recovery, and retention planning.

### 3. Cluster analysis

The final notebook mapped the numeric clusters to human-readable segment names and compared them across business dimensions. The segment sizes show a clear concentration in the middle of the customer base, with a smaller group of high-value repeat buyers.

## Segment Interpretation

| Segment | Customers | Share | Business profile | Recommended action |
|---|---:|---:|---|---|
| **Regular Customers** | 34,289 | 35.9% | Large, stable group with moderate spend and strong review scores. | Use repeat-purchase campaigns, cross-sell offers, and lifecycle marketing to increase order frequency. |
| **Budget Customers** | 30,351 | 31.8% | Price-sensitive customers with low average spend but good satisfaction and low delivery time. | Promote discounts, bundles, and free-shipping thresholds to lift basket value. |
| **Dissatisfied Customers** | 15,605 | 16.4% | Customers with weak review scores and the longest delivery times. | Prioritize service recovery, logistics improvement, and complaint follow-up. |
| **Premium Customers** | 13,288 | 13.9% | Highest spenders with the largest average order value and strong satisfaction. | Protect this segment with VIP treatment, personalization, and premium bundles. |
| **Loyal Customers** | 1,886 | 2.0% | Smallest segment, but the most valuable in repeat behavior and lifetime relationship. | Reward loyalty, offer early access, and build retention programs around them. |

## Key Business Insights

- The customer base is dominated by **Regular** and **Budget** customers, which together make up more than two-thirds of all customers. This means growth will depend heavily on improving repeat purchase behavior and basket size in these two groups.
- **Premium** customers generate the strongest revenue value, so retention is more important than acquisition for this segment.
- **Loyal** customers are small in number but strategically important because they show the strongest repeat relationship with the business.
- **Dissatisfied** customers stand out because their lower satisfaction is linked to slower delivery. This suggests an operational issue, not just a marketing issue.
- Recency is high across most groups, which indicates that reactivation campaigns may be useful for several segments.

## Business Decisions Made

Based on the segmentation results, the following decisions are supported:

- Focus premium retention efforts on the highest-value customers rather than treating all customers the same.
- Build loyalty campaigns for repeat buyers to protect the small but important loyal segment.
- Use price-led promotions for budget customers to increase order size without losing sensitivity to price.
- Improve delivery performance and service recovery for dissatisfied customers before pushing additional sales.
- Treat the regular customer base as the main growth pool for upsell, cross-sell, and reactivation campaigns.

## Final Conclusion

This segmentation project provides a clear customer strategy framework. The workflow moved from raw data preparation to model selection and then to business interpretation, ending with segments that are easy to understand and act on.

The main outcome is that the business can now target each customer group differently instead of using one generic approach. That creates a stronger base for retention, revenue growth, and operational improvement.