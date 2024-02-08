import 'package:flutter/material.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class MapButton extends StatelessWidget {
  final Function() onPressed;
  final bool isActive;
  final bool isDarkTheme;
  final IconData icon;

  const MapButton({
    super.key,
    required this.onPressed,
    required this.isActive,
    required this.isDarkTheme,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 50.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? AppColors.blue : AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.defaultPadding,
            ), // <-- Radius
          ),
          padding: EdgeInsets.zero, // <-- Add this line
        ),
        onPressed: onPressed,
        child: Icon(icon,
            size: 23.0,
            color: isActive
                ? AppColors.white
                : isDarkTheme
                    ? DarkAppColors.gray
                    : LightAppColors.gray),
      ),
    );
  }
}
