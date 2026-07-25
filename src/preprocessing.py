import pandas as pd

def convert_dtypes(df: pd.DataFrame, 
                   numeric_columns: list[str] | None = None, 
                   datetime_columns: list[str] | None = None
    ) -> pd.DataFrame:
    """
    Convert numeric and datetime columns to appropriate pandas data types.
    """
    df = df.copy()
    if numeric_columns:
        for column in numeric_columns:
            df[column] = pd.to_numeric(df[column], errors="coerce")
    
    if datetime_columns:
        for column in datetime_columns:
            df[column] = pd.to_datetime(df[column], errors="coerce")
    
    return df

    
def missing_value_summary(df):
    """
    Return a summary of missing values for a DataFrame.
    """

    summary = (
        df.isnull()
          .sum()
          .to_frame("missing_values")
    )

    summary["missing_percentage"] = (
        summary["missing_values"] / len(df) * 100
    ).round(2)

    return summary[summary["missing_values"] > 0].sort_values(
        by="missing_values",
        ascending=False
    )



# Create an IQR outlier analysis function

def outlier_summary(df, columns):
    """
    Generates IQR-based outlier statistics for numerical columns.
    """

    summary = []

    for col in columns:

        Q1 = df[col].quantile(0.25)
        Q3 = df[col].quantile(0.75)

        IQR = Q3 - Q1

        lower_bound = Q1 - 1.5 * IQR
        upper_bound = Q3 + 1.5 * IQR

        outliers = df[
            (df[col] < lower_bound) |
            (df[col] > upper_bound)
        ]

        summary.append({
            "Column": col,
            "Q1": round(Q1, 2),
            "Q3": round(Q3, 2),
            "IQR": round(IQR, 2),
            "Lower Bound": round(lower_bound, 2),
            "Upper Bound": round(upper_bound, 2),
            "Outlier Count": len(outliers),
            "Outlier Percentage": round(
                len(outliers) / len(df) * 100,
                2
            )
        })

    return pd.DataFrame(summary)