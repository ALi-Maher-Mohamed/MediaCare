import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/utils/app_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  bool isManual = false;

  ThemeCubit() : super(AppTheme.lightTheme);

  void setInitialTheme(BuildContext context) {
    if (!isManual) {
      final brightness = MediaQuery.of(context).platformBrightness;
      emit(brightness == Brightness.dark
          ? AppTheme.darkTheme
          : AppTheme.lightTheme);
    }
  }

  void toggleTheme() {
    isManual = true;
    if (state.brightness == Brightness.light) {
      emit(AppTheme.darkTheme);
    } else {
      emit(AppTheme.lightTheme);
    }
  }

  void resetToSystem(BuildContext context) {
    // رجوع للنظام
    isManual = false;
    setInitialTheme(context);
  }
}
