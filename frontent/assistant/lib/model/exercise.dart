import 'package:assistant/utils/enums.dart';

class Exercise {
  final int id;
  final String name;
  final ExerciseType exerciseType;
  final String category;

  Exercise({
    required this.id,
    required this.name,
    required this.exerciseType,
    required this.category,
  });

  Exercise copyWith({
    int? id,
    String? name,
    ExerciseType? exerciseType,
    String? category,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      exerciseType: exerciseType ?? this.exerciseType,
      category: category ?? this.category,
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      exerciseType: ExerciseType.values[json['exercise_type'] - 1],
      category: json['category'],
    );
  }
}
