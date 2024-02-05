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

  int get value {
    switch (this) {
      case MealType.ingredient:
        return 1;
      case MealType.preparedMeal:
        return 2;
      default:
        return -1;
    }
  }
}

enum ExerciseType {
  repetitions,
  timed;

  int get value {
    switch (this) {
      case ExerciseType.repetitions:
        return 1;
      case ExerciseType.timed:
        return 2;
      default:
        return -1;
    }
  }

  String get name {
    switch (this) {
      case ExerciseType.repetitions:
        return 'Repetitions';
      case ExerciseType.timed:
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

  int get value {
    switch (this) {
      case SurveyType.postMeal:
        return 1;
      case SurveyType.postExcersise:
        return 2;
      case SurveyType.wellBeing:
        return 3;
      default:
        return -1;
    }
  }
}

enum ActivityType {
  meal,
  excersise;

  int get value {
    switch (this) {
      case ActivityType.meal:
        return 1;
      case ActivityType.excersise:
        return 2;
      default:
        return -1;
    }
  }

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
