import 'package:flutter/material.dart';
import '../../constants/colors.dart';

/// Custom AppBar theme for InternTrack TN
class AppAppBarTheme {
  AppAppBarTheme._();

  /// Light mode AppBar theme
  static const AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.lightBg,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: AppColors.textPrimary,
      size: 24,
    ),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
  );

  /// Dark mode AppBar theme
  static const AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.cardDark,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: AppColors.textWhite,
      size: 24,
    ),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textWhite,
    ),
  );
}
