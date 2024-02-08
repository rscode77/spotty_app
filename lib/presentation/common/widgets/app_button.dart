import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.buttonColor,
    this.buttonTextColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.height.buttonHeight,
      width: AppDimensions.width.buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          textStyle:  TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontStyle: GoogleFonts.roboto().fontStyle,
          ),
          foregroundColor: buttonTextColor,
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(buttonText),
      ),
    );
  }
}
