from enum import Enum

class MealType(Enum):
    INGREDIENT = 1
    PREPERED_MEAL = 2
    
class ExerciseType(Enum):
    REPETITIONS = 1
    TIMED = 2
    
class SurveyType(Enum):
    MEAL = 1
    #POST_MEAL = 2
    EXCERCISE = 2
    #POST_EXERCISE = 4
    WELL_BEING = 5
    NONE = 6
    
class ActivityType(Enum):
    MEAL = 1
    EXERCISE = 2
    

class ExerciseCategory(Enum):
    CARDIO = 1
    STRENGTH = 2
    FLEXIBILITY = 3
    BALANCE = 4
    FUNCTIONAL = 5