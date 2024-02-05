import 'package:assistant/utils/enums.dart';

abstract class HomeEvent {}

class HomeInit extends HomeEvent {}

class HomeUpdate extends HomeEvent {}

class HomeRequestSurvey extends HomeEvent {}

class HomeRequestSpecificSurvey extends HomeEvent {
  final SurveyType surveyType;

  HomeRequestSpecificSurvey({required this.surveyType});
}

class HomeGetMealProposition extends HomeEvent {}

class HomeGetExerciseProposition extends HomeEvent {}

class HomeSurveyReceived extends HomeEvent {}
