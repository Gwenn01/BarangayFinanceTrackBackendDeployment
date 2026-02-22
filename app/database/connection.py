import psycopg
import os
from urllib.parse import urlparse

def get_db_connection():
    database_url = os.getenv("DATABASE_URL")

    if database_url.startswith("postgres://"):
        database_url = database_url.replace("postgres://", "postgresql://", 1)

    result = urlparse(database_url)

    return psycopg.connect(
        database=result.path[1:],
        user=result.username,
        password=result.password,
        host=result.hostname,
        port=result.port
    )