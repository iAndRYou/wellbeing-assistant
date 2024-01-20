from fastapi import APIRouter, Query, Path, Depends, Body, Form, HTTPException
from peewee import *

from models import Token, UserDto, UserMealDto, UserCompositeMealDto, UserExerciseDto, SurveyAnswerRequest, ActivityDetailsRequest, Activity
from auth.jwt_handler import validate_token
from database_modules.entities import User, UserMeal, UserExercise, Survey, Question, SurveyAnswer, Meal, Exercise
from enums import ActivityType

router = APIRouter(
    prefix="/recommendations",
)