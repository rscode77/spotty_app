import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final Color buttonColor;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.height.buttonHeight,
      width: AppDimensions.width.buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle:  TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontStyle: GoogleFonts.roboto().fontStyle,
          ),
          foregroundColor: AppColors.white,
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
