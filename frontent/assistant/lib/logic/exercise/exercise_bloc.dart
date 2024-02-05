import 'package:assistant/logic/exercise/exercise_event.dart';
import 'package:assistant/logic/exercise/exercise_selected.dart';
import 'package:assistant/logic/exercise/exercise_state.dart';
import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/logic/preferences_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final HttpServiceRepository httpServiceRepo;
  final SharedPreferencesRepository sharedPreferencesRepo;

  ExerciseBloc({
    required this.httpServiceRepo,
    required this.sharedPreferencesRepo,
  }) : super(ExerciseState()) {
    on<ExerciseInit>((event, emit) async {
      var accessToken = await sharedPreferencesRepo.getSavedAccessToken();
      var exercises =
          await httpServiceRepo.getExercises(accessToken: accessToken);

      emit(state.copyWith(exercises: exercises));
    });

    on<ExerciseSelected>((event, emit) async {
      SelectedExercise selectedExercise =
          SelectedExercise(exerciseId: event.exercise.id);

      emit(state.copyWith(
          currentExercise: event.exercise, selectedExercise: selectedExercise));
    });

    on<ExerciseSelectedRepetitionsChanged>((event, emit) async {
      var selectedExercise = state.selectedExercise;
      if (selectedExercise != null) {
        selectedExercise.repetitions = event.repetitions;
        emit(state.copyWith(selectedExercise: selectedExercise));
      }
    });

    on<ExerciseSelectedTimeChanged>((event, emit) async {
      var selectedExercise = state.selectedExercise;
      if (selectedExercise != null) {
        selectedExercise.time = event.time;
        emit(state.copyWith(selectedExercise: selectedExercise));
      }
    });

    on<ExerciseSubmit>((event, emit) async {
      var accessToken = await sharedPreferencesRepo.getSavedAccessToken();
      var selectedExercise = state.selectedExercise;

      if (selectedExercise != null) {
        await httpServiceRepo.sendExercise(
            accessToken: accessToken, selectedExercise: selectedExercise);
      }
    });
  }
}
