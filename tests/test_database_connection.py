from pathlib import Path
import sys


PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

from src.database import get_connection_cursor


def test_database_connection():
    with get_connection_cursor() as cursor:
        cursor.execute("SELECT 1;")
        result = cursor.fetchone()

    assert result is not None


if __name__ == "__main__":
    test_database_connection()