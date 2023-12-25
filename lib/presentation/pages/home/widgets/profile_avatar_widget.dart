import 'package:flutter/material.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final String username;

  const ProfileAvatarWidget({
    required this.username,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          username,
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(
              left: AppDimensions.defaultPadding,
              top: AppDimensions.defaultPadding,
            ),
            height: 45,
            width: 45,
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.black,
                // image: DecorationImage(
                //   image: AssetImage('assets/images/profile_avatar.png'),
                //   fit: BoxFit.cover,
                // ),
              ),
            )),
      ],
    );
  }
}
