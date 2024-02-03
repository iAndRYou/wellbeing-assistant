class SelectedExercise {
  int exerciseId;
  int time;
  int repetitions;

  bool get isFilled => time > 0 || repetitions > 0;

  SelectedExercise({
    required this.exerciseId,
    this.time = 0,
    this.repetitions = 0,
  });

  SelectedExercise copyWith({
    int? exerciseId,
    int? time,
    int? repetitions,
  }) {
    return SelectedExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      time: time ?? this.time,
      repetitions: repetitions ?? this.repetitions,
    );
  }

  factory SelectedExercise.fromJson(Map<String, dynamic> json) {
    return SelectedExercise(
      exerciseId: json['exercise_id'],
      time: json['time'],
      repetitions: json['repetitions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise_id': exerciseId,
      'time': time,
      'repetitions': repetitions,
    };
  }
}
