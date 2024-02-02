import 'package:assistant/model/survey/answer.dart';

class SurveyState {
  final int surveyId;
  final int numberOfQuestions;
  final List<Answer> answers;

  get isSurveyFilled => answers.length == numberOfQuestions;

  SurveyState({
    this.surveyId = 0,
    this.numberOfQuestions = 0,
    this.answers = const [],
  });

  SurveyState copyWith({
    int? surveyId,
    int? numberOfQuestions,
    List<Answer>? answers,
  }) {
    return SurveyState(
      surveyId: surveyId ?? this.surveyId,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      answers: answers ?? this.answers,
    );
  }

  SurveyState copyWithAnswer(Answer answer) {
    final newAnswers = List<Answer>.from(answers);
    if (newAnswers.any((element) => element.questionId == answer.questionId)) {
      newAnswers[newAnswers.indexWhere(
          (element) => element.questionId == answer.questionId)] = answer;
    } else {
      newAnswers.add(answer);
    }
    return copyWith(answers: newAnswers);
  }
}
