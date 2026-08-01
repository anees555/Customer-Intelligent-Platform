
# Visual EDA Summary

This document summarizes the main findings from the customer visual exploratory data analysis in a simple and professional way. The analysis focuses on customer spending, purchase frequency, order value, review scores, delivery time, and the relationship between delivery speed and customer satisfaction.

## Customer Spending

Customer spending is strongly right-skewed. Most customers spend relatively small amounts, while a small group of high-value customers contributes much larger totals.

The average spending is **166.07**, while the median is **107.95**. This gap shows that a few large purchases pull the mean upward. The distribution also has a long tail, with spending ranging from **9.59** to **13,664.08**.

From a business perspective, this suggests that revenue depends heavily on a smaller premium customer segment. Retention, loyalty programs, and personalized offers may be especially useful for this group.

## Purchase Frequency

Customer order counts are highly concentrated around a single order. The average number of orders per customer is **1.03**, the median is **1**, and the 75th percentile is also **1**. The maximum number of orders recorded is **16**.

This means most customers are one-time buyers, and repeat purchase behavior is limited. Improving customer retention and encouraging repeat orders should be a priority if the business wants to grow long-term customer value.

## Average Order Value

Average order value shows the same general pattern as total spending: it is strongly right-skewed. The mean is **161.07** and the median is **105.78**, which again shows that a small number of very large orders raise the average.

The 90th percentile is **307.94** and the 99th percentile is **1,069.38**, confirming that most customers place moderate-value orders, while a small premium group spends much more.

Because most customers place only one order, average order value is very close to total spending for most of the dataset.

## Average Review Score

Customer review scores are concentrated at the top end of the scale. The mean review score is **4.10**, while the median and mode are both **5**. The skewness is **-1.39**, which indicates that the distribution leans toward higher ratings.

The quartiles show the same pattern: at least 75% of customers have an average review score of **5**. This suggests that customer satisfaction is generally high across the marketplace.

Although low ratings are uncommon, they are still important because they may point to issues with product quality, seller service, or delivery performance.

## Average Delivery Days

Delivery time is positively skewed. The average delivery time is **12.51 days**, the median is **10 days**, and the most common value is **7 days**. Most customers receive their orders within a reasonable time, but some cases take much longer.

The 75th percentile is **16 days**, the 90th percentile is **23 days**, and the 99th percentile is **46 days**. The maximum delivery time reaches **210 days**, which indicates a small number of extreme delays.

Overall, the delivery process works well for most customers, but there is still room to reduce late deliveries and improve consistency.

## Delivery Time vs. Review Score

The scatter plot and fitted line show a moderate negative relationship between delivery time and review score. The correlation is **-0.335**, which means longer delivery times are generally associated with lower review scores.

The relationship is not perfect, so delivery time is not the only factor affecting reviews. Product quality, packaging, seller service, and customer expectations may also influence how customers rate their experience.

The main business takeaway is clear: improving delivery speed may help improve customer satisfaction.

## Overall Takeaway

The visual analysis shows a customer base with low purchase frequency, high satisfaction, and a small number of very valuable customers. The strongest improvement opportunities are increasing repeat purchases and reducing delivery delays, both of which could support better revenue growth and customer loyalty.
