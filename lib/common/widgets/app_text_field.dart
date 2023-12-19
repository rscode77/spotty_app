import 'package:flutter/material.dart';
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
      height: AppDimensions.height.textField,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(
          color: borderColor, // Set border color
          width: 1.0, // Set border width
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          errorText: controller.errorText,
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
