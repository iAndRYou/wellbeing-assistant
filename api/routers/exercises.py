from fastapi import APIRouter, Query, Path, Depends, Body, Form, HTTPException
from peewee import *

from models import UserDto, ExerciseDto
from auth.jwt_handler import validate_token
from database_modules.entities import *
from enums import *

router = APIRouter(
    prefix="/exercises",
)

@router.get('/', response_model=list[ExerciseDto], tags=['exercises'])
async def get_exercises(category : str = None, user: UserDto = Depends(validate_token)):
    '''
        Returns a list of all exercises in a given category or all exercises if no category is specified
    '''
    if category is None:
        exercises = Exercise.select()
    else:
        exercises = Exercise.select().where(Exercise.category == category)
    if exercises.count() == 0:
        raise HTTPException(status_code=404, detail="No exercises found")
    exercises_dto = [ExerciseDto.from_orm(e) for e in exercises]
    return exercises_dto

@router.get('/{exercise_id}', response_model=ExerciseDto, tags=['exercises'])
async def get_exercise(exercise_id: int, user: UserDto = Depends(validate_token)):
    '''
        Returns a specific exercise
    '''
    try:
        exercise = Exercise.get(Exercise.id == exercise_id)
    except DoesNotExist:
        raise HTTPException(status_code=404, detail="Exercise not found")
    return ExerciseDto.from_orm(exercise)