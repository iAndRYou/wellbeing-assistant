from fastapi import APIRouter, Query, Path, Depends, Body, Form, HTTPException
from peewee import *

from models import Token, UserDto, UserMealDto, UserCompositeMealDto, UserExerciseDto, SurveyAnswerRequest, ActivityDetailsRequest, Activity
from auth.jwt_handler import validate_token
from database_modules.entities import User, UserMeal, UserExercise, Survey, Question, SurveyAnswer, Meal, Exercise
from enums import ActivityType
import datetime

import recommendation_model.interface as rec_interface


router = APIRouter(
    prefix="/recommendations",
)

@router.get('/meal', response_model=UserCompositeMealDto, tags=['recommendations'])
def get_meal_recommendation(user: UserDto = Depends(validate_token)):
    '''
    Returns a meal recommendation for the user
    '''

    # # get user's last 10 meals
    # meal_history = (UserMeal
    #     .select()
    #     .where(UserMeal.user == user.user_id)
    #     .order_by(UserMeal.date.desc())
    #     .limit(10)
    # )

    # def prepare_user_meal(user_meal):
    #     return {
    #         "id": user_meal.meal.id,
    #         "name": user_meal.meal.name,
    #         "health_index": user_meal.meal.health_index,
    #         "glycemic_index": user_meal.meal.glycemic_index,
    #         "protein": user_meal.meal.protein,
    #         "carbohydrates": user_meal.meal.carbohydrates,
    #         "fats": user_meal.meal.fats,
    #         "fiber": user_meal.meal.fiber,
    #         "meal_type": user_meal.meal.meal_type,
    #         "weight": user_meal.weight,
    #     }
    # def prepare_meal(meal):
    #     return {
    #         "id": meal.id,
    #         "name": meal.name,
    #         "health_index": meal.health_index,
    #         "glycemic_index": meal.glycemic_index,
    #         "protein": meal.protein,
    #         "carbohydrates": meal.carbohydrates,
    #         "fats": meal.fats,
    #         "fiber": meal.fiber,
    #         "meal_type": meal.meal_type,
    #     }

    # # change it to python list of dictionaries 
    # meal_history = [prepare_user_meal(meal) for meal in meal_history]

    # # get available meals
    # available_meals = (Meal
    #     .select()
    # )

    # # change it to python list of dictionaries
    # available_meals = [prepare_meal(meal) for meal in available_meals]
    

    # print(meal_history)
    # print(available_meals)

    # recommended_meal = rec_interface.get_meal_recommendation(meal_history, available_meals)

    # # recommended meal is now a dictionary with the meal and the weight
    # # turn the recommended meal into a UserCompositeMealDto
    # recommended_meal = UserCompositeMealDto(
    #     meal = UserMealDto(
    #         meal = Meal.get_by_id(recommended_meal['id']),
    #         weight = recommended_meal['weight']
    #     ),
    #     date = datetime.datetime.now()
    # )

    # return recommended_meal




@router.get('/exercise', response_model=UserExerciseDto, tags=['recommendations'])
def get_exercise_recommendation(user: UserDto = Depends(validate_token)):
    '''
    Returns an exercise recommendation for the user
    '''