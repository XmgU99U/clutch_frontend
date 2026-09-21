import 'package:clutch/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData mainTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.BG, 
    primaryColor: AppColors.primary, 
    colorScheme: const ColorScheme.dark()  , 
    fontFamily: 'Inter'
  );
}