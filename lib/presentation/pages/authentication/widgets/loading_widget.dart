import 'package:flutter/material.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final double strokeWidth;
  final double size;
  final Color color;

  const LoadingWidget({
    super.key,
    this.strokeWidth = 2.2,
    this.size = 20.0,
    this.color = AppColors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
