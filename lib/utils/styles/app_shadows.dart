import 'package:flutter/material.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';

class AppShadows {
  const AppShadows._();

  static BoxShadow defaultShadow({
    Offset offset = const Offset(0.0, 5.0),
  }) {
    return BoxShadow(
      color: AppColors.lightGray.withOpacity(0.14),
      offset: offset,
      blurRadius: 12.0,
    );
  }
}
