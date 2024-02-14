import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class ProfileAvatarImage extends StatelessWidget {
  final String avatarUrl;
  final bool isDarkTheme;

  const ProfileAvatarImage({
    super.key,
    required this.avatarUrl,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
            image: DecorationImage(
              image: NetworkImage(avatarUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(
            8.0,
            8.0,
            0.0,
          ),
          child: Container(
            height: 28.0,
            width: 28.0,
            decoration: BoxDecoration(
              color: isDarkTheme ? DarkAppColors.background : LightAppColors.background,
              shape: BoxShape.circle,
            ),
            child: Container(
              margin: const EdgeInsets.all(2.0),
              decoration: const BoxDecoration(
                color: AppColors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.upload,
                color: AppColors.white,
                size: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
