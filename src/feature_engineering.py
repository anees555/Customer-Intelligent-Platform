import pandas as pd
import numpy as np

# customer feature 1: Recency
def customer_features(feature_df):
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