from peewee import Model, SqliteDatabase, CharField, ForeignKeyField, IntegerField, ManyToManyField, DateTimeField, DateField
from .database import db

class BaseModel(Model):
    class Meta:
        database = db
        
class Exercise(BaseModel):
    name = CharField()
    exercise_type = IntegerField() #enum ExerciseType
    category = CharField()
    
class Meal(BaseModel):
    name = CharField()
    health_index = IntegerField()
    glycemic_index = IntegerField()
    protein = IntegerField()
    carbohydrates = IntegerField()
    fats = IntegerField()
    fiber = IntegerField()
    meal_type = IntegerField() #enum MealType
    
class Survey(BaseModel):
    name = CharField()
    survey_type = CharField()  #wnum SurveyType  "post-meal" / "post-exercise" / "well-being"
    
class Question(BaseModel):
    question_content = CharField()
    
# many to many relationship between question and survey
class SurveyQuestion(BaseModel):
    survey = ForeignKeyField(Survey) 
    question = ForeignKeyField(Question)

class SurveyAnswer(BaseModel):
    survey = ForeignKeyField(Survey)
    question = ForeignKeyField(Question)
    answer = CharField()
    
class User(BaseModel):
    name = CharField()
    email = CharField()
    password_hash = CharField()
    
class UserExercise(BaseModel):
    user = ForeignKeyField(User)
    exercise = ForeignKeyField(Exercise)
    date = DateTimeField(default=datetime.datetime.now)
    time = IntegerField(null = True) # in minutes
    repetitions = IntegerField(null = True)

class UserMeal(BaseModel):
    user = ForeignKeyField(User)
    meal = ForeignKeyField(Meal)
    date = DateTimeField(default=datetime.datetime.now)
    weight = IntegerField() # in grams