import 'package:assistant/model/meal.dart';

abstract class MealEvent {}

class MealInit extends MealEvent {}

class MealSelectMeals extends MealEvent {
  final List<Meal> meals;

  MealSelectMeals(this.meals);
}

class MealSelectIngredients extends MealEvent {
  final List<Meal> ingredients;

  MealSelectIngredients(this.ingredients);
}

class MealEditWeight extends MealEvent {
  final Meal meal;
  final int weight;

  MealEditWeight(this.meal, this.weight);
}

class MealSubmit extends MealEvent {}
