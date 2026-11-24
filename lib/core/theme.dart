import 'package:flutter/material.dart';

import 'app_colors.dart';

OutlineInputBorder _border(Color color) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(16),
  borderSide: BorderSide(width: 2, color: color),
);

ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkBlue,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.gold,
      surface: AppColors.darkBlue,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBlue,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.gold),
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.gold),
      bodySmall: TextStyle(
          fontSize: 10, fontWeight: FontWeight.normal, color: AppColors.gold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.darkBlue,
        overlayColor: Colors.transparent,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
      ),
    ),
    textSelectionTheme:
    const TextSelectionThemeData(cursorColor: AppColors.gold),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkBlue,
      hintStyle: const TextStyle(fontSize: 16, color: AppColors.lightBlue),
      errorStyle: const TextStyle(color: AppColors.red),
      contentPadding: const EdgeInsets.all(16),
      border: _border(AppColors.gold),
      enabledBorder: _border(AppColors.gold),
      focusedBorder: _border(AppColors.gold),
      errorBorder: _border(AppColors.red),
      focusedErrorBorder: _border(AppColors.red),
    ),
  );
}