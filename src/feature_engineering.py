import pandas as pd
import numpy as np

# customer feature 1: Recency
def engineer_customer_features(feature_df):
    reference_date = feature_df["last_purchase"].max()
    print(f"Reference data: {reference_date}")

    feature_df["recency_days"] = (reference_date - feature_df["last_purchase"]).dt.days

    # feature 2: Average basket size
    feature_df["avg_basket_size"] = (feature_df["total_products"] / feature_df["total_orders"])

    # feature 3: Frieght ratio
    feature_df["freight_ratio"] = (feature_df["total_freight_paid"] / feature_df["total_spent"])

    # create recency score
    feature_df["R_score"] = pd.qcut(feature_df["recency_days"], q=5, labels=[5, 4, 3, 2, 1]).astype(int)

    # create frequency score
    feature_df["F_score"] = feature_df["total_orders"].apply(
    lambda x:
        5 if x >= 5 else
        4 if x == 4 else
        3 if x == 3 else
        2 if x == 2 else
        1
    )

    # create monetary score
    feature_df["M_score"] = pd.qcut(feature_df["total_spent"], q=5, labels=[1, 2, 3, 4, 5]).astype(int)

    # create RFM score
    feature_df["RFM_score"] = (feature_df["R_score"].astype(str) + feature_df["F_score"].astype(str) + feature_df["M_score"].astype(str))



    return feature_df


# -----------------------------------------------------------------------------------------------------------------------------------

# Product Feature Engineering
def engineer_product_features(feature_df):

    # Feature 1: Revenue per Order
    feature_df["revenue_per_order"] = (
        feature_df["total_revenue"] / feature_df["total_orders"]
    )

    # Feature 2: Freight Ratio
    feature_df["freight_ratio"] = (
        feature_df["total_freight"] / feature_df["total_revenue"]
    )

    # Feature 3: Popularity Score (Percentile-based)
    feature_df["popularity_score"] = (
        feature_df["total_orders"].rank(pct=True) * 0.5 +
        feature_df["total_units_sold"].rank(pct=True) * 0.5
    )

    # Feature 4: Premium Product (Top 20% by average price)
    premium_threshold = feature_df["avg_price"].quantile(0.80)

    feature_df["premium_product"] = (
        feature_df["avg_price"] >= premium_threshold
    ).astype(int)

    # Feature 5: Bestseller Product (Top 10% by units sold)
    bestseller_threshold = feature_df["total_units_sold"].quantile(0.90)

    feature_df["bestseller_flag"] = (
        feature_df["total_units_sold"] >= bestseller_threshold
    ).astype(int)

    # Feature 6: High Rating Product
    feature_df["high_rating_product"] = (
        feature_df["avg_review_score"] >= 4.5
    ).astype(int)

    return feature_df

# ----------------------------------------------------------------------------------------------------------------------


def engineer_seller_features(feature_df):

    # Feature 1: Revenue per Order
    feature_df["revenue_per_order"] = (
        feature_df["total_revenue"]
        / feature_df["total_orders"]
    )

    # Feature 2: Freight Ratio
    feature_df["freight_ratio"] = (
        feature_df["total_freight"]
        / feature_df["total_revenue"]
    )

    # Feature 3: Premium Seller
    premium_threshold = feature_df["avg_product_price"].quantile(0.80)

    feature_df["premium_seller"] = (
        feature_df["avg_product_price"] >= premium_threshold
    ).astype(int)

    # Feature 4: High Rating Seller
    feature_df["high_rating_seller"] = (
        feature_df["avg_review_score"] >= 4.5
    ).astype(int)

    # Feature 5: Fast Delivery Seller
    delivery_threshold = feature_df["avg_delivery_days"].median()

    feature_df["fast_delivery_seller"] = (
        feature_df["avg_delivery_days"] <= delivery_threshold
    ).astype(int)

    return feature_df