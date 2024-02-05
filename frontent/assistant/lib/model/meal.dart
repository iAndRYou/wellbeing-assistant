import 'package:assistant/utils/enums.dart';

class Meal {
  final int id;
  final String name;
  final int healthIndex;
  final int glycemicIndex;
  final double protein;
  final double carbohydrates;
  final double fats;
  final double fiber;
  final MealType mealType;
  int? weight;

  get nutriScore {
    switch (healthIndex) {
      case 1:
        return 'E';
      case 2:
        return 'D';
      case 3:
        return 'C';
      case 4:
        return 'B';
      case 5:
        return 'A';
      default:
        return 'E';
    }
  }

  Meal({
    required this.id,
    required this.name,
    required this.healthIndex,
    required this.glycemicIndex,
    required this.protein,
    required this.carbohydrates,
    required this.fats,
    required this.fiber,
    required this.mealType,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      name: json['name'],
      healthIndex: json['health_index'],
      glycemicIndex: json['glycemic_index'],
      protein: json['protein'],
      carbohydrates: json['carbohydrates'],
      fats: json['fats'],
      fiber: json['fiber'],
      mealType: MealType.values[json['meal_type'] - 1],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meal_id': id,
      'weight': weight!,
    };
  }
}
