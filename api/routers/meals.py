from fastapi import APIRouter, Query, Path, Depends, Body, Form, HTTPException
from peewee import *

from models import UserDto, MealDto
from auth.jwt_handler import pwd_context, create_access_token, oauth2_scheme, validate_token, get_password_hash, verify_password, authenticate_user
from database_modules.entities import *
from enums import MealType


router = APIRouter(
    prefix="/meals",
)


@router.get('/', response_model=list[MealDto], tags=['meals'])
async def get_meals(user: UserDto = Depends(validate_token)):
    return __get_all_meals_from_db()

@router.get('/{meal_id}', response_model=MealDto, tags=['meals'])
async def get_meal(meal_id: int, user: UserDto = Depends(validate_token)):
    try:
        meal = Meal.get(Meal.id == meal_id)
    except DoesNotExist:
        raise HTTPException(status_code=404, detail="Meal not found")
    return MealDto.from_orm(meal)

@router.get('/ingredients/', response_model=list[MealDto], tags=['meals'])
async def get_ingredients(user: UserDto = Depends(validate_token)):
    meals = __get_all_meals_from_db()
    ingredients = [m for m in meals if m.meal_type == MealType.INGREDIENT]
    
    if len(ingredients) == 0:
        raise HTTPException(status_code=404, detail="No ingredients found")
    return ingredients

@router.get('/prepered_meals/', response_model=list[MealDto], tags=['meals'])
async def get_prepered_meals(user: UserDto = Depends(validate_token)):
    meals = __get_all_meals_from_db()
    prepered_meals = [m for m in meals if m.meal_type == MealType.PREPERED_MEAL]

    if len(prepered_meals) == 0:
        raise HTTPException(status_code=404, detail="No prepered meals found")
    return prepered_meals



def __get_all_meals_from_db():
    meals = Meal.select()
    if meals.count() == 0:
        raise HTTPException(status_code=404, detail="No meals found")
    meals_dto = [MealDto.from_orm(m) for m in meals]
    return meals_dto