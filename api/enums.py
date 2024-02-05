from enum import Enum

class MealType(Enum):
    INGREDIENT = 1
    PREPERED_MEAL = 2
    
class ExerciseType(Enum):
    REPETITIONS = 1
    TIMED = 2
    
class SurveyType(Enum):
    POST_MEAL = 1
    POST_EXERCISE = 2
    WELL_BEING = 3
    
class ActivityType(Enum):
    MEAL = 1
    EXERCISE = 2
    

class ExerciseCategory(Enum):
    CARDIO = 1
    STRENGTH = 2
    FLEXIBILITY = 3
    BALANCE = 4
    FUNCTIONAL = 5