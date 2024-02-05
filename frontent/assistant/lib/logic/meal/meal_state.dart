import 'package:assistant/model/meal.dart';

class MealState {
  final List<Meal> preparedMeals;
  final List<Meal> ingredients;
  List<Meal> currentMeals;
  List<Meal> currentIngredients;

  List<Meal> get allSelected => currentMeals + currentIngredients;
  bool get hasSelected => allSelected.isNotEmpty;
  bool get hasAllSelected =>
      allSelected.isNotEmpty &&
      allSelected.every((meal) => meal.weight != null && meal.weight! > 0);

  MealState({
    this.preparedMeals = const [],
    this.ingredients = const [],
    this.currentMeals = const [],
    this.currentIngredients = const [],
  });

  MealState copyWith({
    List<Meal>? preparedMeals,
    List<Meal>? ingredients,
    List<Meal>? currentMeals,
    List<Meal>? currentIngredients,
  }) {
    return MealState(
      preparedMeals: preparedMeals ?? this.preparedMeals,
      ingredients: ingredients ?? this.ingredients,
      currentMeals: currentMeals ?? this.currentMeals,
      currentIngredients: currentIngredients ?? this.currentIngredients,
    );
  }
}
