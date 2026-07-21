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