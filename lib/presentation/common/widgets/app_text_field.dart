import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';
import 'package:spotty_app/utils/extensions/text_edit_controller_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class AppTextField extends StatelessWidget {
  final Color borderColor;
  final Color fillColor;
  final Color textColor;
  final String hint;
  final ExtendedTextEditingController controller;

  const AppTextField({
    Key? key,
    this.borderColor = AppColors.lightGray,
    this.fillColor = AppColors.lightGrayFill,
    this.textColor = AppColors.black,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: controller.errorText.isNullOrBlank ? 55 : 80,
      ),
      child: TextField(
        style:  TextStyle(
          color: AppColors.black,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontStyle: GoogleFonts.roboto().fontStyle
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
            borderSide: const BorderSide(
              width: 2,
              color: AppColors.lightGray,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
            borderSide: const BorderSide(
              width: 2,
              color: AppColors.lightGray,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
            borderSide: const BorderSide(
              width: 2,
              color: AppColors.green,
            ),
          ),
          labelText: hint,
          floatingLabelStyle: const TextStyle(
            color: AppColors.black,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          labelStyle: const TextStyle(
            color: AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
            borderSide: const BorderSide(
              width: 2,
              color: AppColors.red,
            ),
          ),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          errorText: controller.errorText,
          errorStyle: const TextStyle(
            color: AppColors.red,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}