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

    return feature_df