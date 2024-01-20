from pydantic import BaseModel, EmailStr, Field
from typing import Type, Union
from datetime import datetime

from enums import *



'''
 DTOs
'''

 # From server to client   
 # ONLY used for communication with the client
 
class UserDto(BaseModel):
    '''User model returned to the client'''
    id: int = Field(default=...)
    name: str = Field(default=...)
    email: EmailStr = Field(default=...)
    
class Token(BaseModel):
    access_token: str
    token_type: str
    
class MealDto(BaseModel):
    '''Meal model returned to the client'''
    id : int = Field(default=...)
    name: str = Field(default=...)
    health_index: int = Field(default=...)
    glycemic_index: int = Field(default=...)
    protein: int = Field(default=...)
    carbohydrates: int = Field(default=...)
    fats: int = Field(default=...)
    fiber: int = Field(default=...)
    meal_type: MealType = Field(default=...)
    
    @staticmethod
    def from_orm(meal):
        return MealDto(
            id = meal.id,
            name = meal.name,
            health_index = meal.health_index,
            glycemic_index = meal.glycemic_index,
            protein = meal.protein,
            carbohydrates = meal.carbohydrates,
            fats = meal.fats,
            fiber = meal.fiber,
            meal_type = MealType(meal.meal_type)
        )
    
    
class ExerciseDto(BaseModel):
    id : int = Field(default=...)
    name: str = Field(default=...)
    exercise_type: ExerciseType = Field(default=...)
    category: str = Field(default=...)
    
    @staticmethod
    def from_orm(exercise):
        return ExerciseDto(
            id = exercise.id,
            name = exercise.name,
            exercise_type = ExerciseType(exercise.exercise_type),
            category = exercise.category
        )
    
class Recommendation(BaseModel):
    recommendation : Union['CompositeMeal', 'ExerciseDto'] = Field(default=...)
    type : ActivityType = Field(default=...)
    date : datetime = Field(default=...)
    
class History(BaseModel):
    history : list['Activity'] = Field(default=...)
    
class ActivityDetails(BaseModel):
    activity : Union['CompositeMeal', 'ExerciseDto'] = Field(default=...)
    activity_type : ActivityType = Field(default=...)
    
class SurveyDto(BaseModel):
    '''Survey model returned to the client'''
    id : int = Field(default=...)
    name: str = Field(default=...)
    survey_type: SurveyType = Field(default=...)
    questions: list['QuestionDto'] = Field(default=...)
    
# From client to server
# ONLY used for communication with the server

class UserRegisterDto(BaseModel):
    '''User model for registering purposes'''
    name: str = Field(default=...)
    email: EmailStr = Field(default=...)
    password: str = Field(default=...)
    
class UserCompositeMealDto(BaseModel):
    '''Meal model sent from the client describing a complete meal consumed by the user'''''
    meals : list[UserMealDto] = Field(default=...)

# performed exercise
class UserExerciseDto(BaseModel):
    '''Exercise model sent from the client describing an exercise performed by the user'''
    exercise_id: int = Field(default=...)
    time: int = Field()
    repetitions: int = Field()
    
    
class ActivityDetailsRequest(BaseModel):
    activity_id : int = Field(default=...)
    activity_type : ActivityType = Field(default=...)
    
class SurveyAnswerRequest(BaseModel):
    list_of_answers : list['SurveyAnswerDto'] = Field(default=...)
    
'''
Internal models (not directy exposed in the communication with the client)
'''

class CompositeMeal(BaseModel):
    meals : list[MealDto] = Field(default=...)
    
class Activity(BaseModel):
    activity_id : int = Field(default=...)
    activity_type : ActivityType = Field(default=...)
    date : datetime = Field(default=...)
    
class QuestionDto(BaseModel):
    id : int = Field(default=...)
    question_content: str = Field(default=...)
    
class SurveyAnswerDto(BaseModel):
    survey_id : int = Field(default=...)
    question_id: int = Field(default=...)
    answer_score: int = Field(default=...)
    
# consumed meal
class UserMealDto(BaseModel):
    '''Meal model sent from the client describing an ingredient/prepped meal consumed by the user'''
    meal_id: int = Field(default=...)
    weight: int = Field(default=...)
    


    
    


    

