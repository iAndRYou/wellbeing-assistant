from fastapi import APIRouter, Query, Path, Depends, Body, Form, HTTPException
from fastapi.security import OAuth2PasswordRequestForm

from ..models import Token
from ..auth.jwt_handler import pwd_context, create_access_token, decode_token, oauth2_scheme, get_password_hash, verify_password, authenticate_user

router = APIRouter(
    prefix="/users",
    tags=["users"],
)

@router