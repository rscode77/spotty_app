import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:spotty_app/utils/constants/constants.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class AppSearchBar extends StatefulWidget {
  final bool isDarkTheme;
  final String hint;
  final TextEditingController searchController;
  final Function(String) onSubmitted;

  const AppSearchBar({
    super.key,
    required this.isDarkTheme,
    required this.hint,
    required this.searchController,
    required this.onSubmitted,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
        color: widget.isDarkTheme ? DarkAppColors.background : LightAppColors.background,
        boxShadow: Constants.defaultBoxShadow,
      ),
      height: 50.0,
      child: TextField(
        onChanged: (value) {
          setState(() {});
        },
        onSubmitted: (value) => widget.onSubmitted(value),
        textInputAction: TextInputAction.search,
        cursorColor: widget.isDarkTheme ? DarkAppColors.dark : LightAppColors.dark,
        cursorHeight: 16.0,
        cursorWidth: 1.2,
        controller: widget.searchController,
        style: TextStyle(
            height: 1.1,
            color: widget.isDarkTheme ? DarkAppColors.white : LightAppColors.dark,
            decoration: TextDecoration.none,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontStyle: GoogleFonts.roboto().fontStyle),
        decoration: InputDecoration(
          prefixIcon: Icon(
           LucideIcons.search,
            size: 20.0,
            color: widget.isDarkTheme ? DarkAppColors.iconLight : LightAppColors.iconLight,
          ),
          suffixIcon: widget.searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.searchController.clear();
                    });
                  },
                  icon: Icon(
                    LucideIcons.x,
                    size: 20.0,
                    color: widget.isDarkTheme ? DarkAppColors.iconLight : LightAppColors.iconLight,
                  ),
                )
              : null,
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
        ),
      ),
    );
  }
}
