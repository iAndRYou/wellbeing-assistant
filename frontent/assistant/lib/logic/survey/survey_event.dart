abstract class SurveyEvent {}

class SurveyStarted extends SurveyEvent {
  final int surveyId;
  final int numberOfQuestions;

  SurveyStarted({required this.surveyId, required this.numberOfQuestions});
}

class SurveyQuestionAnswered extends SurveyEvent {
  final int questionId;
  final int answerValue;

  SurveyQuestionAnswered({required this.questionId, required this.answerValue});
}

class SurveySubmitted extends SurveyEvent {}
