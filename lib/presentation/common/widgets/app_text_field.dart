import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotty_app/utils/enums/field_enum.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';
import 'package:spotty_app/utils/extensions/text_edit_controller_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final ExtendedTextEditingController controller;
  final FieldsEnum field;
  final bool isDarkTheme;

  const AppTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.field,
    required this.isDarkTheme,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool isObscure;

  @override
  initState() {
    super.initState();
    isObscure = widget.field == FieldsEnum.Password;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: widget.controller.errorText.isNullOrBlank ? 55.0 : 80.0,
      ),
      child: TextField(
        obscureText: isObscure,
        cursorColor: widget.isDarkTheme ? DarkAppColors.dark : LightAppColors.dark,
        cursorHeight: 16.0,
        cursorWidth: 1.2,
        controller: widget.controller,
        style: TextStyle(
            height: 1.1,
            color: widget.isDarkTheme ? DarkAppColors.white : LightAppColors.dark,
            decoration: TextDecoration.none,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontStyle: GoogleFonts.roboto().fontStyle),
        decoration: InputDecoration(
          suffixIcon: widget.field == FieldsEnum.Password
              ? IconButton(
            onPressed: () => setState(() => isObscure = !isObscure),
            icon: Icon(
              isObscure ? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined,
              size: 20.0,
              color: widget.isDarkTheme ? DarkAppColors.iconLight : LightAppColors.iconLight,
            ),
          )
              : null,
          prefixIcon: Icon(
            widget.field.icon,
            size: 20.0,
            color: widget.isDarkTheme ? DarkAppColors.iconLight : LightAppColors.iconLight,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
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
          labelText: widget.hint,
          labelStyle: TextStyle(
            color: widget.isDarkTheme ? DarkAppColors.grayText : LightAppColors.grayText,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
            borderSide: const BorderSide(
              width: 1.2,
              color: AppColors.red,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
            borderSide: const BorderSide(
              width: 1.2,
              color: AppColors.red,
            ),
          ),
          errorText: widget.controller.errorText,
          errorStyle: const TextStyle(
            color: AppColors.red,
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}