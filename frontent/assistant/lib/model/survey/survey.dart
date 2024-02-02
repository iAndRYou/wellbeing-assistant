import 'package:assistant/model/survey/question.dart';
import 'package:assistant/utils/enums.dart';

class Survey {
  final int id;
  final String name;
  final SurveyType surveyType;
  final List<Question> questions;

  Survey({
    required this.id,
    required this.name,
    required this.surveyType,
    required this.questions,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      id: json['id'],
      name: json['name'],
      surveyType: SurveyType.values[json['survey_type'] - 1],
      questions: json['questions']
          .map<Question>((question) => Question.fromJson(question))
          .toList(),
    );
  }
}
