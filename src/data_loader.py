import pandas as pd
from src.database import get_connection_cursor


def load_data(table_name: str) -> pd.DataFrame:
    """
    Load an entire PostgreSQL table or view into a Pandas DataFrame.

    Parameters
    ----------
    table_name : str
        Name of the PostgreSQL table or view.

    Returns
    -------
    pd.DataFrame
    """

    query = f"SELECT * FROM {table_name};"

    with get_connection_cursor() as cursor:
        cursor.execute(query)

        columns = [column[0] for column in cursor.description]
        rows = cursor.fetchall()

    return pd.DataFrame(rows, columns=columns)


def load_query(query: str) -> pd.DataFrame:
    """
    Execute any SQL query and return the result as a Pandas DataFrame.

    Parameters
    ----------
    query : str
        Any valid SQL SELECT query.

    Returns
    -------
    pd.DataFrame
    """

    with get_connection_cursor() as cursor:
        cursor.execute(query)

        columns = [column[0] for column in cursor.description]
        rows = cursor.fetchall()

    return pd.DataFrame(rows, columns=columns)