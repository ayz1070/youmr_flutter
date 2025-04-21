import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  // ✅ 라이트 모드 테마
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    dividerColor: AppColors.divider,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.black),
      titleTextStyle: AppTextStyles.headline2,
    ),
    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.headline1,
      headlineMedium: AppTextStyles.headline2,
      headlineSmall: AppTextStyles.headline3,
      bodyLarge: AppTextStyles.body1,
      bodySmall: AppTextStyles.body2,

    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // ✅ 다크 모드 테마
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    dividerColor: AppColors.darkDivider,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.white),
      titleTextStyle: AppTextStyles.headline2.copyWith(color: AppColors.darkTextPrimary),
    ),
    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.headline1,
      headlineMedium: AppTextStyles.headline2,
      headlineSmall: AppTextStyles.headline3,
      bodyLarge: AppTextStyles.body1,
      bodyMedium: AppTextStyles.body2,

    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}