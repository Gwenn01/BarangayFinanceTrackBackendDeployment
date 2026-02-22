import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    FLASK_ENV = os.getenv("FLASK_ENV", "development")
    SECRET_KEY = os.getenv("SECRET_KEY", "fallback-secret")

    # If DATABASE_URL exists (Render), use it
    DATABASE_URL = os.getenv("DATABASE_URL")

    if DATABASE_URL:
        # Render PostgreSQL
        SQLALCHEMY_DATABASE_URI = DATABASE_URL
    else:
        # Local MySQL
        DB_HOST = os.getenv("DB_HOST")
        DB_USER = os.getenv("DB_USER")
        DB_PASSWORD = os.getenv("DB_PASSWORD")
        DB_NAME = os.getenv("DB_NAME")

        SQLALCHEMY_DATABASE_URI = (
            f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}"
        )

    SQLALCHEMY_TRACK_MODIFICATIONS = False