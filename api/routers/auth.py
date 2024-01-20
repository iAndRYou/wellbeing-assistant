from fastapi import APIRouter, Query, Path, Depends, Body, Form, HTTPException
from fastapi.security import OAuth2PasswordRequestForm
from peewee import *

from models import Token, UserRegisterDto
from auth.jwt_handler import pwd_context, create_access_token, oauth2_scheme, get_password_hash, verify_password, authenticate_user
from database_modules.entities import User

router = APIRouter(
    prefix="/auth",
    tags=["auth"],
)

@router.post('/login', response_model=Token, tags=['auth'])
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()):
    '''
    Login, returns access token.
    login: email,
    password: password
    
    '''
    try:
        user = authenticate_user(form_data.username, form_data.password)
    except DoesNotExist:
        raise HTTPException(status_code=400, detail="Incorrect email or password")
    
    access_token = create_access_token(
        data={"sub": user.email}
    )
    return {"access_token": access_token, "token_type": "bearer"}

@router.post('/register', response_model=Token, tags=['auth'])
async def register_user(new_user: UserRegisterDto = Body()):
    '''
    Register a new user
    '''
    try:
        dbuser = User.get(User.email == new_user.email)
        raise HTTPException(status_code=400, detail="Email already registered")
    except DoesNotExist:
        dbuser = None
        
    dbuser = User(
        name = new_user.name,
        email = new_user.email,
        password_hash = get_password_hash(new_user.password)
    )
    dbuser.save()

    access_token = create_access_token(
        data={"sub": dbuser.email}
    )
    return {"access_token": access_token, "token_type": "bearer"}

