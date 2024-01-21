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
}
