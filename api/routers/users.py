from fastapi import APIRouter, Query, Path, Depends, Body, Form, HTTPException
from peewee import *

from models import Token, UserDto, UserMealDto, UserCompositeMealDto, UserExerciseDto
from auth.jwt_handler import pwd_context, create_access_token, oauth2_scheme, validate_token, get_password_hash, verify_password, authenticate_user
from database_modules.entities import User, UserMeal, UserExercise

router = APIRouter(
    prefix="/users",
    tags=["users"],
)

@router.get('/me', tags=['users'])
async def get_me(user: UserDto = Depends(validate_token)):
    '''
    Get the current user
    '''
    return user

@router.post('/meal', tags=['users'])
async def add_meal_to_user(user_composite_meal_dto : UserCompositeMealDto, user: UserDto = Depends(validate_token)):
    '''
    Add user consumed meal
    '''
    for meal in user_composite_meal_dto.meals:
        __add_meal_to_user(user, meal)
    return True

@router.post('/exercise', tags=['users'])
async def add_exercise_to_user(user_exercise_dto : UserExerciseDto, user: UserDto = Depends(validate_token)):
    '''
    Add user performed exercise
    '''
    __add_exercise_to_user(user, user_exercise_dto)
    return True


def __add_meal_to_user(user: UserDto, user_meal_dto : UserMealDto):
    try:
        Meal.get(Meal.id == user_meal_dto.meal_id)
    except DoesNotExist:
        raise HTTPException(status_code=404, detail="Meal not found")
    
    UserMeal.create(
        user_id = user.id,
        meal_id = user_meal_dto.meal_id,
        weight = user_meal_dto.weight
    )
    
def __add_exercise_to_user(user: UserDto, user_exercise_dto : UserExerciseDto):
    try:
        Exercise.get(Exercise.id == user_exercise_dto.exercise_id)
    except DoesNotExist:
        raise HTTPException(status_code=404, detail="Exercise not found")
    
    UserExercise.create(
        user_id = user.id,
        exercise_id = user_exercise_dto.exercise_id,
        time = user_exercise_dto.time,
        repetitions = user_exercise_dto.repetitions
    )
    
