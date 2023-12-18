import 'package:flutter/material.dart';

class AppDimensions {
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static final _Height height = _Height();
  static final _Margin margin = _Margin();
  static final _Padding padding = _Padding();
  static final _Width width = _Width();
}

class _Height {
  final double actionButton = 46.0;
  final double bottomSheetHeight = 320.0;
  final double iconSize = 40.0;
  final double textField = 54.0;
  final double partDrawHeight = 240.0;
  final double dropDownButtonHeight = 46.0;
}

class _Margin {
  final double partDetailsListMargin = 8.0;
}

class _Padding {
  final EdgeInsets cell = const EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 13.0,
  );
}

class _Width {
  final double barCode = 250.0;
}
