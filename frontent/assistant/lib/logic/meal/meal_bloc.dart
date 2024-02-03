import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/logic/meal/meal_event.dart';
import 'package:assistant/logic/meal/meal_state.dart';
import 'package:assistant/logic/preferences_repo.dart';
import 'package:assistant/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final HttpServiceRepository httpServiceRepo;
  final SharedPreferencesRepository sharedPreferencesRepo;

  MealBloc({
    required this.httpServiceRepo,
    required this.sharedPreferencesRepo,
  }) : super(MealState()) {
    on<MealInit>((event, emit) async {
      var accessToken = await sharedPreferencesRepo.getSavedAccessToken();

      final preparedMeals =
          await httpServiceRepo.getPreparedMeals(accessToken: accessToken);
      final ingredients = await httpServiceRepo.getIngredients(
        accessToken: accessToken,
      );

      emit(state.copyWith(
        preparedMeals: preparedMeals,
        ingredients: ingredients,
      ));
    });

    on<MealSelectMeals>((event, emit) {
      emit(state.copyWith(currentMeals: event.meals));
    });

    on<MealSelectIngredients>((event, emit) {
      emit(state.copyWith(currentIngredients: event.ingredients));
    });

    on<MealEditWeight>((event, emit) {
      if (event.meal.mealType == MealType.preparedMeal) {
        final currentMeals = state.currentMeals;
        final index =
            currentMeals.indexWhere((meal) => meal.id == event.meal.id);

        if (index != -1) {
          currentMeals[index].weight = event.weight;
        }

        emit(state.copyWith(currentMeals: currentMeals));
      } else {
        final currentIngredients = state.currentIngredients;
        final index =
            currentIngredients.indexWhere((meal) => meal.id == event.meal.id);

        if (index != -1) {
          currentIngredients[index].weight = event.weight;
        }

        emit(state.copyWith(currentIngredients: currentIngredients));
      }
    });

    on<MealSubmit>((event, emit) async {
      var accessToken = await sharedPreferencesRepo.getSavedAccessToken();
      await httpServiceRepo.sendMeals(
        accessToken: accessToken,
        meals: state.allSelected,
      );
    });
  }
}
