import 'package:flutter/material.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class NotificationIconWidget extends StatefulWidget {
  const NotificationIconWidget({super.key});

  @override
  State<NotificationIconWidget> createState() => _NotificationIconWidgetState();
}

class _NotificationIconWidgetState extends State<NotificationIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          margin: const EdgeInsets.only(
            right: AppDimensions.defaultPadding,
            top: AppDimensions.defaultPadding,
          ),
          height: 45,
          width: 45,
          child: const Icon(
            Icons.notifications,
            size: 20,
            color: AppColors.black,
          ),
        ),
        Transform.translate(
          offset: const Offset(26, 46),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.red,
              shape: BoxShape.circle,
            ),
            height: 20,
            width: 20,
            child: const Center(
              child: Text(
                '1',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ),
        ),
      ],
    );
  }
}
