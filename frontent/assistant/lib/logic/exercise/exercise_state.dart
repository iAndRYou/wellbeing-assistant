import 'package:assistant/logic/exercise/exercise_selected.dart';
import 'package:assistant/model/exercise.dart';

class ExerciseState {
  final List<Exercise> exercises;
  final Exercise? currentExercise;
  final SelectedExercise? selectedExercise;

  bool get hasCurrentExerciseFilled =>
      selectedExercise != null && selectedExercise!.isFilled;

  ExerciseState({
    this.exercises = const [],
    this.currentExercise,
    this.selectedExercise,
  });

  ExerciseState copyWith({
    List<Exercise>? exercises,
    Exercise? currentExercise,
    SelectedExercise? selectedExercise,
    String? filter,
  }) {
    return ExerciseState(
      exercises: exercises ?? this.exercises,
      currentExercise: currentExercise ?? this.currentExercise,
      selectedExercise: selectedExercise ?? this.selectedExercise,
    );
  }
}
