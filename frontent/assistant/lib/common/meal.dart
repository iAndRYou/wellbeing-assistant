import 'package:assistant/common/indicators.dart';
import 'package:assistant/model/meal.dart';
import 'package:assistant/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

Row mealNutriens(Meal meal) {
  Color labelColor = const Color.fromARGB(150, 80, 80, 80);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
          Text(
            '${meal.protein}g / 100g',
            style: themeData.textTheme.titleSmall?.copyWith(color: labelColor),
          ),
          Text(
            ' Proteins',
            style: themeData.textTheme.bodySmall?.copyWith(color: labelColor),
          ),
        ],
      ),
      Column(
        children: [
          Text(
            '${meal.carbohydrates}g / 100g',
            style: themeData.textTheme.titleSmall?.copyWith(color: labelColor),
          ),
          Text(
            ' Carbs',
            style: themeData.textTheme.bodySmall?.copyWith(color: labelColor),
          ),
        ],
      ),
      Column(
        children: [
          Text(
            '${meal.fats}g / 100g',
            style: themeData.textTheme.titleSmall?.copyWith(color: labelColor),
          ),
          Text(
            ' Fats',
            style: themeData.textTheme.bodySmall?.copyWith(color: labelColor),
          ),
        ],
      ),
      Column(
        children: [
          Text(
            '${meal.fiber}g / 100g',
            style: themeData.textTheme.titleSmall?.copyWith(color: labelColor),
          ),
          Text(
            ' Fiber',
            style: themeData.textTheme.bodySmall?.copyWith(color: labelColor),
          ),
        ],
      ),
    ],
  );
}

Row mealScores(Meal meal) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      radialIndicator(
        range: const Tuple2(1, 5),
        value: meal.healthIndex.toDouble(),
        displayedValue: meal.nutriScore,
        title: 'Nutri-Score',
        width: 80,
        height: 80,
        showGradient: true,
      ),
      radialIndicator(
        range: const Tuple2(1, 100),
        value: meal.glycemicIndex.toDouble(),
        displayedValue: meal.glycemicIndex.toString(),
        title: 'Glycemic index',
        width: 80,
        height: 80,
        showGradient: true,
        inverted: true,
      ),
    ],
  );
}
