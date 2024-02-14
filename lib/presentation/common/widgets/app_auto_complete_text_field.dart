import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotty_app/utils/enums/field_enum.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';
import 'package:spotty_app/utils/extensions/text_edit_controller_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';


class AppAutoCompleteTextField extends StatefulWidget {
  final String hint;
  final ExtendedTextEditingController controller;
  final FieldsEnum field;
  final bool isDarkTheme;
  final TextInputType textInputType;
  final List<String> suggestions;
  final Function(String item) itemSubmitted;

  const AppAutoCompleteTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.field,
    required this.isDarkTheme,
    required this.suggestions,
    required this.itemSubmitted,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  State<AppAutoCompleteTextField> createState() => _AppAutoCompleteTextFieldState();
}

class _AppAutoCompleteTextFieldState extends State<AppAutoCompleteTextField> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: widget.controller.errorText.isNullOrBlank ? 55.0 : 80.0,
      ),
      child: AutoCompleteTextField<String>(
        clearOnSubmit: false,
        itemSubmitted: (String item) => widget.itemSubmitted(item),
        key: GlobalKey(),
        suggestions: widget.suggestions,
        itemBuilder: (BuildContext context, String suggestion) => ListTile(
          title: Text(suggestion),
        ),
        itemSorter: (String a, String b) => a.compareTo(b),
        itemFilter: (String suggestion, String query) => suggestion
            .toLowerCase()
            .contains(query.toLowerCase()),
        keyboardType: widget.textInputType,
        cursorColor: widget.isDarkTheme ? DarkAppColors.dark : LightAppColors.dark,
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
