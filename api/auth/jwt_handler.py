from jose import JWTError, jwt
from fastapi import Depends, HTTPException, status
from datetime import datetime, timedelta
from peewee import DoesNotExist


from database_modules.entities import User
from models import UserDto
from .config import *



async def validate_token(token: str = Depends(oauth2_scheme)) -> UserDto:
    '''
    Validate a token and return the user
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
    try:
        user = User.get(User.email == email)
    except DoesNotExist:
        raise HTTPException(status_code=404, detail="User not found")
    
    userDto = UserDto(
        id = user.id,
        name = user.name,
        email = user.email,
    )
    return userDto


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


