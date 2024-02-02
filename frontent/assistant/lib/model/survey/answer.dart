class Answer {
  final int surveyId;
  final int questionId;
  final int answerScore;

  set answerScore(int value) {
    if (value < 0 || value > 5) {
      throw Exception('Answer score must be between 0 and 5');
    }
  }

  Answer({
    required this.surveyId,
    required this.questionId,
    required this.answerScore,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      surveyId: json['survey_id'],
      questionId: json['question_id'],
      answerScore: json['answer_score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'survey_id': surveyId,
      'question_id': questionId,
      'answer_score': answerScore,
    };
  }
}
