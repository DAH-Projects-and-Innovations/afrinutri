from datetime import datetime, timedelta
from typing import Optional
from jose import JWTError, jwt
from passlib.context import CryptContext
from app.core.config import settings

# Hashing des mots de passe 
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_password(password: str) -> str:
    "Transforme un mot de passe en version illisible"
    return pwd_context.hash(password)

def verify_password(plain_password: str, hashed_password: str) -> bool:
    "Vérifie si un mot de passe correspond au hash stocké"
    return pwd_context.verify(plain_password, hashed_password)

# Tokens JWT 
def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    "Crée un token JWT pour un utilisateur connecté"
    to_encode = data.copy()

    # Définir la durée de validité du token
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(
            minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES
        )

    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)

def decode_access_token(token: str) -> Optional[dict]:
    "Vérifie et décode un token JWT"
    try:
        payload = jwt.decode(
            token,
            settings.SECRET_KEY,
            algorithms=[settings.ALGORITHM]
        )
        return payload
    except JWTError:
        return None