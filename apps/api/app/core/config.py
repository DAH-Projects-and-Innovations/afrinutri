from pydantic_settings import BaseSettings
from typing import Optional


class Settings(BaseSettings):
    # Application 
    APP_NAME: str = "AfriNutri"
    APP_VERSION: str = "0.1.0"
    DEBUG: bool = False

    # Base de données 
    DATABASE_URL: str = "postgresql://postgres:password@localhost:5432/afrinutri"

    # Sécurité JWT 
    SECRET_KEY: str = "changez-moi-en-production"
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30

    # Stockage S3 / MinIO 
    S3_BUCKET_NAME: str = "afrinutri-images"
    S3_ACCESS_KEY: Optional[str] = None
    S3_SECRET_KEY: Optional[str] = None
    S3_ENDPOINT_URL: Optional[str] = None

    class Config:
        env_file = ".env"
        case_sensitive = True


# Instance globale utilisée dans tout le projet
settings = Settings()