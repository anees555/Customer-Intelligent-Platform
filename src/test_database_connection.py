from src.database import get_connection_cursor

with get_connection_cursor() as cursor:
    cursor.execute("SELECT * FROM customers LIMIT 5;")
    rows = cursor.fetchall()

for row in rows:
    print(row)