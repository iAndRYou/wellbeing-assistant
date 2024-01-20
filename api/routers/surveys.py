from fastapi import APIRouter, Query, Path, Depends, Body, Form, HTTPException
from peewee import *
from typing import Union, Optional

from models import UserDto, SurveyDto, QuestionDto
from auth.jwt_handler import validate_token
from database_modules.entities import *
from enums import SurveyType

router = APIRouter(
    prefix="/surveys",
)

@router.get('/', response_model=Optional[SurveyDto], tags=['surveys'])
async def get_survey(survey_type: Optional[int] = None, user: UserDto = Depends(validate_token)):
    '''
        Returns a survey of a given type, 
        server chosen survey type if no type is specified
        or None if no survey is available at the moment
    '''
    
    if survey_type is not None:
        survey_type = SurveyType(survey_type)
        
    if not __check_if_survey_available(user, survey_type):
        return None
    
    survey = __select_survey(user, survey_type)
    return __survey_to_dto(survey)
    
    

def __check_if_survey_available(user, survey_type : Optional[SurveyType] = None) -> bool:
    # TODO: check if survey is available for user
    return True

def __select_survey(user, survey_type : Optional[SurveyType] = None) -> Survey:
    # TODO: select appropriate survey
    
    survey = (Survey.select()
              #.where(Survey.survey_type == survey_type)
              #.where()
              )
    if survey.count() == 0:
        raise HTTPException(status_code=404, detail="No surveys found")
    return Survey.select().first()

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
    