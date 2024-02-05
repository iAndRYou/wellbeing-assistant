import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Styles {
  static const Transition defaultTransition = Transition.cupertino;
  static const Transition fadeTransition = Transition.fadeIn;

  static const EdgeInsets homePagePadding = EdgeInsets.fromLTRB(20, 20, 20, 0);
  static const EdgeInsets defaultPadding = EdgeInsets.symmetric(horizontal: 15);

  static const EdgeInsets contentPaddingNarrow =
      EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets contentPaddingWide =
      EdgeInsets.symmetric(vertical: 20);

  static const EdgeInsets contentMarginTop = EdgeInsets.only(top: 20);

  static const Radius defaultRadius = Radius.circular(15);
  static const Radius wideRadius = Radius.circular(50);

  static const BorderRadius defaultBorderRadius =
      BorderRadius.all(defaultRadius);
  static const BorderRadius wideBorderRadius = BorderRadius.all(wideRadius);

  static const SizedBox defaultVerticalSpace = SizedBox(height: 20);
  static const SizedBox defaultHorizontalSpace = SizedBox(width: 20);

  static const SizedBox smallHorizontalSpace = SizedBox(width: 10);

  static const SizedBox largeVerticalSpace = SizedBox(height: 40);

  static const inputTransparentBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: defaultBorderRadius,
  );

  static ButtonStyle primaryButtonStyle(
          {minimumSize, maximumSize, fixedSize}) =>
      ElevatedButton.styleFrom(
        minimumSize: minimumSize,
        maximumSize: maximumSize,
        fixedSize: fixedSize,
        backgroundColor: Get.theme.colorScheme.primary,
        foregroundColor: Get.theme.colorScheme.onPrimary,
        elevation: 5,
      );

  static ButtonStyle secondaryButtonStyle(
          {minimumSize, maximumSize, fixedSize}) =>
      ElevatedButton.styleFrom(
        minimumSize: minimumSize,
        maximumSize: maximumSize,
        fixedSize: fixedSize,
        backgroundColor: Get.theme.colorScheme.onPrimary,
        foregroundColor: Get.theme.colorScheme.primary,
        elevation: 5,
      );

  static ButtonStyle rectangleButtonStyle({backgroundColor, size}) =>
      ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: size,
        maximumSize: size,
        padding: const EdgeInsets.all(0),
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      );

  static InputDecoration formInputDecoration({required String label}) =>
      InputDecoration(
        filled: true,
        fillColor: Get.theme.colorScheme.onPrimary,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        errorStyle: Get.theme.textTheme.labelSmall!.copyWith(
          color: Get.theme.colorScheme.error,
        ),
        border: inputTransparentBorder,
        focusedBorder: inputTransparentBorder,
        enabledBorder: inputTransparentBorder,
        errorBorder: inputTransparentBorder,
        focusedErrorBorder: inputTransparentBorder,
      );

  static InputDecoration searchInputDecoration({
    required String label,
    required Color labelColor,
    required Color fillColor,
  }) =>
      InputDecoration(
        filled: true,
        fillColor: fillColor,
        labelText: label,
        labelStyle: TextStyle(color: labelColor),
        prefixIcon: Icon(Icons.search, color: labelColor),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: inputTransparentBorder,
        focusedBorder: inputTransparentBorder,
        enabledBorder: inputTransparentBorder,
        errorBorder: inputTransparentBorder,
        focusedErrorBorder: inputTransparentBorder,
      );
}
