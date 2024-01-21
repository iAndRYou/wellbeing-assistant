import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ColorScheme colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 50, 196, 192),
  secondary: const Color.fromARGB(172, 141, 233, 213),
  background: const Color.fromARGB(255, 250, 250, 250),
  brightness: Brightness.light,
);

final ThemeData themeData =
    ThemeData.from(colorScheme: colorScheme).copyWith(textTheme: textTheme);

final TextStyle font = GoogleFonts.mukta();

final TextTheme textTheme = TextTheme(
  displayLarge: font.copyWith(
    fontSize: 96,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    color: Colors.black,
  ),
  displayMedium: font.copyWith(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    color: Colors.black,
  ),
  displaySmall: font.copyWith(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  headlineLarge: font.copyWith(
    fontSize: 40,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.black,
  ),
  headlineMedium: font.copyWith(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.black,
  ),
  headlineSmall: font.copyWith(
    fontSize: 26,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  ),
  titleLarge: font.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: Colors.black,
  ),
  titleMedium: font.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: Colors.black,
  ),
  titleSmall: font.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    color: Colors.black,
  ),
  bodyLarge: font.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: Colors.black,
  ),
  bodyMedium: font.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Colors.black,
  ),
  labelLarge: font.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: Colors.black,
  ),
  bodySmall: font.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: Colors.black,
  ),
  labelSmall: font.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    color: Colors.black,
  ),
);
