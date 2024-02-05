import 'package:assistant/common/meal.dart';
import 'package:assistant/model/exercise.dart';
import 'package:assistant/model/meal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assistant/common/info_icons.dart';
import 'package:assistant/utils/styles.dart';

class Snackbars {
  static const Duration waitDuration = Duration(seconds: 2, milliseconds: 500);

  static showMessageSnackbar(
      {required String title, required String message, InfoIcon? icon}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      overlayBlur: 0,
      borderRadius: 50,
      margin: Styles.defaultPadding.copyWith(bottom: 15),
      padding: EdgeInsets.symmetric(
          horizontal: 10, vertical: icon == null ? 45 : 20),
      titleText: Center(
        child: icon,
      ),
      messageText: Center(
        child: Text(
          message.toUpperCase(),
          style: Get.textTheme.titleLarge?.copyWith(
            color: Get.theme.colorScheme.outline,
          ),
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: Get.theme.colorScheme.shadow.withOpacity(0.1),
          offset: const Offset(0, 8),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
      backgroundColor: Get.theme.colorScheme.background,
      duration: const Duration(seconds: 1, milliseconds: 500),
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      reverseAnimationCurve: Curves.fastEaseInToSlowEaseOut,
      instantInit: true,
    );
  }

  static showMealSnackbar({required Meal meal}) {
    Get.snackbar(
      meal.name,
      meal.mealType.name,
      snackPosition: SnackPosition.BOTTOM,
      overlayBlur: 0,
      borderRadius: 50,
      margin: Styles.defaultPadding.copyWith(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      titleText: Center(
        child: Column(
          children: [
            Text(
              'We think you may like this'.toUpperCase(),
              style: Get.textTheme.titleLarge?.copyWith(
                color: Get.theme.colorScheme.outline,
              ),
            ),
            Text(
              meal.name.toUpperCase(),
              style: Get.textTheme.headlineSmall?.copyWith(
                color: Get.theme.colorScheme.outline,
              ),
            ),
            Styles.defaultVerticalSpace,
          ],
        ),
      ),
      messageText: Center(
        child: Column(
          children: [
            mealScores(meal),
            mealNutriens(meal),
            Styles.defaultVerticalSpace,
            Text(
              'Give it a try ☺'.toUpperCase(),
              style: Get.textTheme.titleLarge?.copyWith(
                color: Get.theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: Get.theme.colorScheme.shadow.withOpacity(0.1),
          offset: const Offset(0, 8),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
      backgroundColor: Get.theme.colorScheme.background,
      duration: const Duration(seconds: 10),
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      reverseAnimationCurve: Curves.fastEaseInToSlowEaseOut,
      instantInit: true,
    );
  }

  static showMExerciseSnackbar({required Exercise exercise}) {
    Get.snackbar(
      exercise.name,
      exercise.exerciseType.name,
      snackPosition: SnackPosition.BOTTOM,
      overlayBlur: 0,
      borderRadius: 50,
      margin: Styles.defaultPadding.copyWith(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      titleText: Center(
        child: Column(
          children: [
            Text(
              'We think you may like this'.toUpperCase(),
              style: Get.textTheme.titleLarge?.copyWith(
                color: Get.theme.colorScheme.outline,
              ),
            ),
            Text(
              exercise.name.toUpperCase(),
              style: Get.textTheme.headlineSmall?.copyWith(
                color: Get.theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
      messageText: Center(
        child: Column(
          children: [
            SizedBox(
              width: 110,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary,
                  borderRadius: Styles.defaultBorderRadius,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      exercise.categoryIcon,
                      color: Get.theme.colorScheme.onSecondary,
                    ),
                    Styles.smallHorizontalSpace,
                    Text(
                      exercise.category,
                      style: Get.theme.textTheme.titleLarge?.copyWith(
                        color: Get.theme.colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Styles.defaultVerticalSpace,
            Text(
              'Give it a try ☺'.toUpperCase(),
              style: Get.textTheme.titleLarge?.copyWith(
                color: Get.theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
      boxShadows: [
        BoxShadow(
          color: Get.theme.colorScheme.shadow.withOpacity(0.1),
          offset: const Offset(0, 8),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
      backgroundColor: Get.theme.colorScheme.background,
      duration: const Duration(seconds: 10),
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      reverseAnimationCurve: Curves.fastEaseInToSlowEaseOut,
      instantInit: true,
    );
  }
}
