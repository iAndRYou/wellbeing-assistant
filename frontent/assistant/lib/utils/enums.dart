enum MealType {
  ingredient,
  preparedMeal;

  String get name {
    switch (this) {
      case MealType.ingredient:
        return 'Ingredient';
      case MealType.preparedMeal:
        return 'Prepared Meal';
      default:
        return 'Unknown';
    }
  }
}

enum ExcersiseType {
  repetitions,
  timed;

  String get name {
    switch (this) {
      case ExcersiseType.repetitions:
        return 'Repetitions';
      case ExcersiseType.timed:
        return 'Timed';
      default:
        return 'Unknown';
    }
  }
}

enum SurveyType {
  postMeal,
  postExcersise,
  wellBeing;
}

enum ActivityType {
  meal,
  excersise;

  String get name {
    switch (this) {
      case ActivityType.meal:
        return 'Meal';
      case ActivityType.excersise:
        return 'Excersise';
      default:
        return 'Unknown';
    }
  }
}
