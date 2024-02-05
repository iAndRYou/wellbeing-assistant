from fastapi import APIRouter, Query, Path, Depends, Body, Form, HTTPException
from peewee import *
from typing import Union, Optional
import datetime

from models import UserDto, SurveyDto, QuestionDto
from auth.jwt_handler import validate_token
from database_modules.entities import *
from enums import SurveyType, ActivityType
from .users import get_activities

router = APIRouter(
    prefix="/surveys",
)

@router.get('/', response_model=Optional[SurveyDto], tags=['surveys'])
async def get_survey(user: UserDto = Depends(validate_token)):
    '''
        Returns a survey of a given type, 
        server chosen survey type
        or None if no survey is available at the moment
    '''
    
    survey = __select_survey(user)
    return survey
    
    

def __check_if_survey_available(user) -> SurveyType:
    activities = get_activities(user)
    if activities is None or len(activities) == 0:
        return SurveyType.NONE
    
    most_recent_activity = activities[0]
    survey_type = __map_survey_type(most_recent_activity.activity_type, most_recent_activity.date)
    
    survey_answers = (SurveyAnswer
         .select()
         .join(Survey)
         .where(SurveyAnswer.activity_id == most_recent_activity.activity_id)
         .where(Survey.survey_type == survey_type.value))
    
    if survey_answers.count() > 0:
        return SurveyType.NONE
    
    return survey_type

def __select_survey(user) -> Optional[SurveyDto]:
    survey_type = __check_if_survey_available(user)
    if survey_type == SurveyType.NONE:
        return None
    
    survey = (Survey.select()
               .where(Survey.survey_type == survey_type.value)
               )
    if survey.count() == 0:
        raise HTTPException(status_code=404, detail="No surveys found for this survey type...")
    return __survey_to_dto(survey[0])
    


def __map_survey_type(activity_type : ActivityType, date) -> SurveyType:
    # time_delta = datetime.datetime.now() - date
    # if time_delta.total_seconds() < 60*60*3:
    #     if activity_type == ActivityType.EXERCISE:
    #         return SurveyType.EXCERCISE
    #     else:
    #         return SurveyType.MEAL
    # else:
    #     if activity_type == ActivityType.EXERCISE:
    #         return SurveyType.POST_EXERCISE
    #     elif activity_type == ActivityType.MEAL:
    #         return SurveyType.POST_MEAL
    
    if activity_type == ActivityType.EXERCISE:
        return SurveyType.EXCERCISE
    elif activity_type == ActivityType.MEAL:
        return SurveyType.MEAL
    
    raise HTTPException(status_code=404, detail="No surveys found...")
    

def __survey_to_dto(survey : Survey) -> SurveyDto:
    questions =  (Question
         .select()
         .join(SurveyQuestion)
         .join(Survey)
         .where(Survey.id == survey.id))
    if questions.count() == 0:
        raise HTTPException(status_code=404, detail="No questions found")
    surveyDto = SurveyDto(
        id = survey.id,
        name = survey.name,
        questions = [QuestionDto.from_orm(q) for q in questions],
        survey_type = SurveyType(survey.survey_type)
    )
    return surveyDto
    

# # TODO: the surveys are hardcoded for now, ideally they should be stored in the database 
# meal__satisfaction = QuestionDto(id=1, question_content="Overall Satisfaction: On a scale of 1-5, how satisfied were you with your meal?")
# meal__flavor = QuestionDto(id=2, question_content="Flavor Enjoyment: How enjoyable was the taste of your meal on a scale of 1-5?")
# meal__satiety = QuestionDto(id=3, question_content="Satiety Level: On a scale of 1-5, how full did you feel after eating the meal?")
# meal__digestions = QuestionDto(id=4, question_content="Digestive Comfort: Rate your digestive comfort after the meal on a scale of 1-5.")
# meal__energy = QuestionDto(id=5, question_content="Energy Levels: On a scale of 1-5, how would you rate your energy levels after the meal?")

# MEAL_SURVEY = SurveyDto(
#     id = 1,
#     name = "Post Meal Survey",
#     survey_type = SurveyType.POST_MEAL,
#     questions = [meal__satisfaction, meal__flavor, meal__satiety, meal__digestions, meal__energy]
# )

# exercise__effort = QuestionDto(id=6, question_content="Effort Level: On a scale of 1-5, how would you rate the effort required for the exercise?")
# exercise__enjoyment = QuestionDto(id=7, question_content="Enjoyment Level: How much did you enjoy the exercise on a scale of 1-5?")
# exercise__comfort = QuestionDto(id=8, question_content="Physical Comfort: Rate your physical comfort during the exercise on a scale of 1-5.")
# exercise__wellbeing = QuestionDto(id=9, question_content="Post-Exercise Wellbeing: On a scale of 1-5, how do you feel overall after completing the exercise?")
# exercise__motivation = QuestionDto(id=10, question_content="Motivation for Next Session: On a scale of 1-5, how motivated are you to perform a similar exercise again?")

# EXERCISE_SURVEY = SurveyDto(
#     id = 2,
#     name = "Post Exercise Survey",
#     survey_type = SurveyType.POST_EXERCISE,
#     questions = [exercise__effort, exercise__enjoyment, exercise__comfort, exercise__wellbeing, exercise__motivation]
# )
