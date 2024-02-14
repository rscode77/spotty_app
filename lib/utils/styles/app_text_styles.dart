import 'package:flutter/material.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';

class AppTextStyles {

  const AppTextStyles._();

  static TextStyle actionButton({
    Color color = AppColors.black,
    TextDecoration? decoration,
    double fontSize = 15.0,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      color: color,
      decoration: decoration,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle textActionButton({
    Color color = AppColors.black,
    TextDecoration? decoration,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      color: color,
      decoration: decoration,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle chatTitle({
    Color color = AppColors.black,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle chatMessage({
    Color color = AppColors.black,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle title({
    Color color = AppColors.black,
    TextDecoration? decoration,
    double fontSize = 16.0,
    FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.w500,
    double? height,
  }) {
    return TextStyle(
      color: color,
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle appBarTitle({
    Color color = AppColors.black,
    TextDecoration? decoration,
    double fontSize = 18.0,
    FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.w500,
    double? height,
  }) {
    return TextStyle(
      color: color,
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle textTitle({
    Color color = AppColors.black,
    TextDecoration? decoration,
    double fontSize = 24.0,
    FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.w800,
    double? height,
  }) {
    return TextStyle(
      color: color,
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle textSubtitle({
    Color color = AppColors.black,
    TextDecoration? decoration,
    double fontSize = 14.0,
    FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
  }) {
    return TextStyle(
      color: color,
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle eventTitle({
    Color color = AppColors.black,
    TextDecoration? decoration,
    double fontSize = 16.0,
    FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.w500,
    double? height,
  }) {
    return TextStyle(
      color: color,
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle eventSubtitle({
    Color color = AppColors.black,
    TextDecoration? decoration,
    double fontSize = 14.0,
    FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
  }) {
    return TextStyle(
      color: color,
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle eventInformation({
    Color color = AppColors.black,
    TextDecoration? decoration,
    double fontSize = 15.0,
    FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.w500,
    double? height,
  }) {
    return TextStyle(
      color: color,
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle eventDescription({
    Color color = AppColors.black,
    TextDecoration? decoration,
    double fontSize = 15.0,
    FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
  }) {
    return TextStyle(
      color: color,
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle infoSmall({
    Color color = AppColors.black,
    TextDecoration? decoration,
    double fontSize = 14.0,
    FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
  }) {
    return TextStyle(
      color: color,
      decoration: decoration,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle editData({
    Color color = AppColors.black,
    TextDecoration? decoration,
    double fontSize = 14.0,
    FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
  }) {
    return TextStyle(
      decorationColor: color,
      color: color,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      height: height,
      decoration: decoration,
    );
  }
}
