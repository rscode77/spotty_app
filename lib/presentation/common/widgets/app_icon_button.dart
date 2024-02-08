import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final Color color;
  final double iconSize;

  const AppIconButton({
    super.key,
    this.iconSize = 23.0,
    required this.onPressed,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: iconSize,
        color: color,
      ),
    );
  }
}
