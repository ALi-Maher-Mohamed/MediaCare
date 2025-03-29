import 'package:flutter/material.dart';
import 'package:media_care/core/utils/app_color.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: AppColors.primary), // أزرق بدلاً من الأسود
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary, // الأزرق المائي الجديد
        background: AppColors.backgroundLight,
        surface: AppColors.surfaceLight, // خلفية الكروت
        onPrimary: AppColors.textLight,
        onSecondary: AppColors.textLight,
        onSurface: AppColors.primary, // النصوص على الكروت بالأزرق الطبي
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: AppColors.primary, // أزرق بدلاً من الأسود
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textLight, // أزرق بدلاً من الأسود
          fontSize: 16,
        ),
      ),
      iconTheme:
          const IconThemeData(color: AppColors.primary), // أيقونات بالأزرق
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
        ),
      ),
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary, // الأزرق المائي الجديد
        background: AppColors.backgroundDark,
        surface: AppColors.surfaceDark, // خلفية الكروت
        onPrimary: AppColors.textLight,
        onSecondary: AppColors.textLight,
        onSurface: AppColors.textLight, // النصوص على الكروت بالأبيض للتباين
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: AppColors.primary, // أزرق للعناوين الكبيرة
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textLight, // أبيض للنصوص العادية للتباين
          fontSize: 16,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.textLight),
    );
  }
}
