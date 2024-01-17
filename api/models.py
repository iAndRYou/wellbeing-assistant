from pydantic import BaseModel, EmailStr, Field
'''
 DTOs
'''
# From client to server
class UserLoginDto(BaseModel):
    '''User model for login purposes'''
    email: EmailStr = Field(default=...)
    password: str = Field(default=...)

class UserRegisterDto(BaseModel):
    '''User model for registering purposes'''
    name: str = Field(default=...)
    email: EmailStr = Field(default=...)
    password: str = Field(default=...)
 
 
 # From server to client   
class UserDto(BaseModel):
    '''User model returned to the client'''
    id: int = Field(default=...)
    name: str = Field(default=...)
    email: EmailStr = Field(default=...)
    
    

class Token(BaseModel):
    access_token: str
    token_type: str