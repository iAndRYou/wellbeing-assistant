from jose import JWTError, jwt
from fastapi import Depends, HTTPException, status
from datetime import datetime, timedelta

from database_modules.entities import User
from .config import *



async def decode_token(token: str = Depends(oauth2_scheme)) -> User:
    '''
    Decode a token and return the user
    '''

    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email: str = payload.get("sub")
        if email is None:
            raise JWTError
    except JWTError:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Could not validate credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
    user = User.get(User.email == email)
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user


def create_access_token(data: dict):
    '''
    Create an access token with an expiry time
    '''
    
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


def authenticate_user(email: str, password: str) -> User:
    '''
    Authenticate user by email and password
    '''
    
    dbuser = User.get(User.email == email)
    if dbuser is None: # no user was found with that email
        return False
    if not verify_password(password, dbuser.password_hash): # password hashes don't match
        return False
    return dbuser


def get_password_hash(password):
    '''
    Hash a password for storing
    '''
    
    return pwd_context.hash(password)


def verify_password(plain_password, hashed_password):
    '''
    Verify a stored password against one provided by user
    '''
    
    return pwd_context.verify(plain_password, hashed_password)


