import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondary, // الوردي الطبي الجديد
        secondaryContainer: AppColors.primaryLight, // وردي فاتح كـ container
        surface: AppColors.surfaceLight,
        surfaceVariant: AppColors.lightGrey,
        onSurface: AppColors.textDark,
        onSurfaceVariant: AppColors.darkGrey,
        error: AppColors.backgroundLight,
        onPrimary: AppColors.textLight,
        onSecondary: AppColors.textLight,
        onError: AppColors.textLight,
        background: AppColors.backgroundLight,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: AppColors.textDark,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: AppColors.textDark,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textDark,
          fontSize: 16.sp,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textLight,
          fontSize: 14.sp,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.textDark),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
        ),
      ),
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondary, // الوردي الطبي الجديد
        secondaryContainer: Color(0xffC2185B), // وردي غامق كـ container
        surface: AppColors.surfaceDark,
        surfaceVariant: AppColors.darkGrey,
        onSurface: AppColors.textLight,
        onSurfaceVariant: AppColors.lightGrey,
        error: Colors.redAccent,
        onPrimary: AppColors.textLight,
        onSecondary: AppColors.textLight,
        onError: AppColors.textLight,
        background: AppColors.backgroundDark,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: AppColors.primary,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: AppColors.textLight,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textLight,
          fontSize: 16.sp,
        ),
        bodyMedium: TextStyle(
          color: AppColors.lightGrey,
          fontSize: 14.sp,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.textLight),
    );
  }
}
