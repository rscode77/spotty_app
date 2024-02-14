import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/common/widgets/app_button.dart';
import 'package:spotty_app/presentation/common/widgets/app_text_button.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

class ColorPickerButton extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;
  final bool isDarkTheme;

  const ColorPickerButton({
    Key? key,
    required this.isDarkTheme,
    required this.initialColor,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  ColorPickerButtonState createState() => ColorPickerButtonState();
}

class ColorPickerButtonState extends State<ColorPickerButton> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.initialColor;
  }

  void changeColor(Color color) {
    setState(() => currentColor = color);
    widget.onColorChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData(
                dialogTheme: DialogTheme(
                    backgroundColor: widget.isDarkTheme ? DarkAppColors.background : LightAppColors.background),
              ),
              child: AlertDialog(
                titlePadding: const EdgeInsets.only(top: 24.0, left: 24.0),
                title: Text(
                  S.of(context).selectColor,
                  style: AppTextStyles.eventSubtitle(),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      ColorPicker(
                        pickerColor: currentColor,
                        onColorChanged: changeColor,
                        enableAlpha: false,
                        labelTypes: const [],
                      ),
                      AppButton(
                        onPressed: () => Navigator.pop(context),
                        buttonText: S.of(context).save,
                        buttonColor: AppColors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      buttonText: S.of(context).selectColor,
      buttonColor: AppColors.blue,
    );
  }
}
