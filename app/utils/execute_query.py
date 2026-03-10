import psycopg
from psycopg.rows import dict_row
from app.database.connection import get_db_connection


def fetch_all(query, params=None):
    conn = get_db_connection()
    try:
        with conn.cursor(row_factory=dict_row) as cursor:
            cursor.execute(query, params or ())
            results = cursor.fetchall()
            return results
    finally:
        conn.close()


def execute_query(query, params=None, many=False):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        if many:
            cursor.executemany(query, params)
        else:
            cursor.execute(query, params or ())

        conn.commit()
        return cursor.rowcount
    except Exception as e:
        conn.rollback()
        print("Database error:", e)
        return 0
    finally:
        cursor.close()
        conn.close()