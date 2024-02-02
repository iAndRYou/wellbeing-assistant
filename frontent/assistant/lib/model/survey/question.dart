class Question {
  final int id;
  final String questionContent;

  Question({
    required this.id,
    required this.questionContent,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionContent: json['question_content'],
    );
  }
}
