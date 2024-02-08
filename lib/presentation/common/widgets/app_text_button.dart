import 'package:flutter/material.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

class AppTextButton extends StatelessWidget {
  final Function() onPressed;
  final String buttonText;
  final Color buttonColor;

  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          buttonText,
          style: AppTextStyles.actionButton(
            color: buttonColor,
          ),
        ),
      ),
    );
  }
}
