import 'package:flutter/material.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';

class UserAvatarStatus extends StatelessWidget {
  final String avatar;
  final bool isOnline;
  final bool isDarkTheme;

  const UserAvatarStatus({
    super.key,
    required this.avatar,
    required this.isOnline,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 50.0,
          width: 50.0,
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
        Transform.translate(
          offset: const Offset(1, -1),
          child: _onlineStatus(isOnline),
        ),
      ],
    );
  }

  Widget _onlineStatus(bool isOnline) {
    if (!isOnline) return const SizedBox.shrink();
    return Container(
      height: 14.0,
      width: 14.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDarkTheme ? DarkAppColors.background : LightAppColors.background,
      ),
      child: Container(
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isOnline ? AppColors.green : AppColors.red,
        ),
      ),
    );
  }
}
