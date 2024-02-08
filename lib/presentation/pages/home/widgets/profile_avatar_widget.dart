import 'package:flutter/material.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final String username;
  final bool isDarkTheme;

  const ProfileAvatarWidget({
    required this.username,
    required this.isDarkTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0).copyWith(
        top: 36.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.0),
                bottomLeft: Radius.circular(14.0),
              ),
            ),
            height: 45,
            width: 45,
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    12.0,
                  ),
                ),
                color: AppColors.black,
                image: DecorationImage(
                  image: AssetImage('assets/images/profile_avatar.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            height: 45,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(14.0),
                bottomRight: Radius.circular(14.0),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 4.0,
                  right: AppDimensions.defaultPadding,
                ),
                child: Text(
                  '@$username',
                  style: TextStyle(
                    color: isDarkTheme ? DarkAppColors.dark : LightAppColors.dark,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
