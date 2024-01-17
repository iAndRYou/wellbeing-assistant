from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from database_modules.database import db
from database_modules.entities import *
from routers import auth, users

app = FastAPI(
    title="Wellbeing Assistant API"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

db.connect()

db.create_tables([Meal, Survey, SurveyAnswer, SurveyQuestion, Question, User, UserExercise, UserMeal], safe=True)

app.include_router(auth.router)
app.include_router(users.router)
