import 'package:flutter/material.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class AppDropdownButton extends StatefulWidget {
  final String hint;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final bool isDarkTheme;

  const AppDropdownButton({
    Key? key,
    required this.hint,
    required this.items,
    this.value,
    required this.onChanged,
    required this.isDarkTheme,
  }) : super(key: key);

  @override
  State<AppDropdownButton> createState() => _AppDropdownButtonState();
}

class _AppDropdownButtonState extends State<AppDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: DropdownButtonFormField<String>(
        value: widget.value,
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(item),
            ),
          );
        }).toList(),
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.hint,
          labelStyle: TextStyle(
            color: widget.isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
            borderSide: BorderSide(
              width: 1.2,
              color: widget.isDarkTheme ? DarkAppColors.border : LightAppColors.border,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
            borderSide: BorderSide(
              width: 1.2,
              color: widget.isDarkTheme ? DarkAppColors.border : LightAppColors.border,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
            borderSide: const BorderSide(
              width: 1.2,
              color: AppColors.blue,
            ),
          ),
        ),
      ),
    );
  }
}