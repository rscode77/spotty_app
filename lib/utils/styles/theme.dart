import 'package:flutter/material.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';

ThemeData lightMode = ThemeData(
    hoverColor: Colors.transparent,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      background: LightAppColors.background,
      primary: AppColors.blue,
    ));

ThemeData darkMode = ThemeData(
    hoverColor: Colors.transparent,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      background: DarkAppColors.background,
      primary: AppColors.blue,
    ));
