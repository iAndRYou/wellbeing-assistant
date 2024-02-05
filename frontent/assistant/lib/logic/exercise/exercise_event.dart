import 'package:assistant/model/exercise.dart';

abstract class ExerciseEvent {}

class ExerciseInit extends ExerciseEvent {}

class ExerciseSelected extends ExerciseEvent {
  final Exercise exercise;

  ExerciseSelected(this.exercise);
}

class ExerciseSelectedRepetitionsChanged extends ExerciseEvent {
  final int repetitions;

  ExerciseSelectedRepetitionsChanged(this.repetitions);
}

class ExerciseSelectedTimeChanged extends ExerciseEvent {
  final int time;

  ExerciseSelectedTimeChanged(this.time);
}

class ExerciseSubmit extends ExerciseEvent {}
