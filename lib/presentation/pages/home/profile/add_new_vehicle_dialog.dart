import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotty_app/data/models/requests/add_vehicle_request.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/bloc/vehicle_bloc.dart';
import 'package:spotty_app/presentation/common/widgets/app_auto_complete_text_field.dart';
import 'package:spotty_app/presentation/common/widgets/app_button.dart';
import 'package:spotty_app/presentation/common/widgets/app_dropdown_button.dart';
import 'package:spotty_app/presentation/common/widgets/app_text_field.dart';
import 'package:spotty_app/presentation/common/widgets/color_picker_button.dart';
import 'package:spotty_app/utils/constants/constants.dart';
import 'package:spotty_app/utils/enums/field_enum.dart';
import 'package:spotty_app/utils/enums/vehicle_type_enum.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/extensions/string_extensions.dart';
import 'package:spotty_app/utils/extensions/text_edit_controller_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

class AddNewVehicleDialog extends StatefulWidget {
  final int userId;
  final Function(AddVehicleRequest vehicle) onVehicleSave;

  const AddNewVehicleDialog({
    super.key,
    required this.userId,
    required this.onVehicleSave,
  });

  @override
  State<AddNewVehicleDialog> createState() => _AddNewVehicleDialogState();
}

class _AddNewVehicleDialogState extends State<AddNewVehicleDialog> {
  bool get _isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  final ExtendedTextEditingController _brandTextField = ExtendedTextEditingController();
  final ExtendedTextEditingController _modelTextField = ExtendedTextEditingController();
  final ExtendedTextEditingController _horsePowerTextField = ExtendedTextEditingController();
  final ValueNotifier<VehicleType> _vehicleType = ValueNotifier<VehicleType>(VehicleType.Car);
  final ValueNotifier<Color> _color = ValueNotifier<Color>(Colors.white);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: AlertDialog(
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        surfaceTintColor: Colors.transparent,
        content: BlocBuilder<VehicleBloc, VehicleState>(
          builder: (context, state) {
            return SizedBox(
              height: 430,
              width: 450,
              child: _buildBody(state),
            );
          },
        ),
      ),
    );
  }

  // TODO add image of vehicle configure vehicle color as avtar on map

  Widget _buildBody(VehicleState state) {
    return Column(children: [
      const Space.vertical(24.0),
      _buildVehicleTypeTextField(),
      const Space.vertical(16.0),
      _buildVehicleBrandTextField(state.vehicleBrands),
      const Space.vertical(8.0),
      _buildVehicleModelTextField(state.vehicleModels),
      const Space.vertical(8.0),
      _buildVehicleHorsePowerTextField(),
      const Space.vertical(30.0),
      _buildSaveButton(),
      const Space.vertical(8.0),
      _buildBackButton(),
    ]);
  }

  // TODO find API with vehicle brands then ..add(const FetchBrandsEvent())
  Widget _buildVehicleBrandTextField(List<String> brandsList) {
    return AppAutoCompleteTextField(
      controller: _brandTextField,
      hint: S.of(context).setBrand,
      field: FieldsEnum.VehicleBrand,
      isDarkTheme: _isDarkTheme,
      suggestions: brandsList,
      itemSubmitted: (String item) {
        _modelTextField.clear();
        // TODO find API with vehicle models then _vehicleBloc.add(LoadModelsEvent(brand: item));
      },
    );
  }

  Widget _buildVehicleModelTextField(List<String> modelsList) {
    return AppAutoCompleteTextField(
      controller: _modelTextField,
      hint: S.of(context).setModel,
      field: FieldsEnum.VehicleModel,
      isDarkTheme: _isDarkTheme,
      suggestions: modelsList,
      itemSubmitted: (String item) {},
    );
  }

  Widget _buildVehicleHorsePowerTextField() {
    return AppTextField(
      controller: _horsePowerTextField,
      textInputType: TextInputType.number,
      hint: S.of(context).setHorsePower,
      field: FieldsEnum.VehicleHp,
      isDarkTheme: _isDarkTheme,
    );
  }

  Widget _buildVehicleTypeTextField() {
    return AppDropdownButton(
      hint: S.of(context).setVehicleType,
      isDarkTheme: _isDarkTheme,
      value: _vehicleType.value.value,
      items: VehicleType.values.map((e) => e.value).toList(),
      onChanged: (String? value) {
        _vehicleType.value = VehicleType.values.firstWhere((e) => e.value == value);
        _brandTextField.clear();
        _modelTextField.clear();
      },
    );
  }

  Widget _buildColorPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.0),
            color: _color.value,
          ),
        ),
        const Space.horizontal(8.0),
        Expanded(
          child: ColorPickerButton(
            initialColor: Colors.white,
            onColorChanged: (Color color) {
              setState(() {
                _color.value = color;
              });
            },
            isDarkTheme: _isDarkTheme,
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return AppButton(
      onPressed: () => _saveVehicleData(),
      buttonText: S.of(context).save,
      buttonColor: AppColors.blue,
    );
  }

  Widget _buildBackButton() {
    return AppButton(
      onPressed: () => Navigator.pop(context),
      buttonText: S.of(context).back,
      buttonColor: AppColors.lightBlue,
      buttonTextColor: AppColors.blue,
    );
  }

  bool _validateFields() {
    bool isValid = true;

    setState(() {
      _brandTextField.errorText = null;
      _modelTextField.errorText = null;
      _horsePowerTextField.errorText = null;

      if (_brandTextField.text.trim().isNullOrBlank) {
        _brandTextField.errorText = S.of(context).fieldCannotBeEmpty;
        isValid = false;
      }
      if (_modelTextField.text.trim().isNullOrBlank) {
        _modelTextField.errorText = S.of(context).fieldCannotBeEmpty;
        isValid = false;
      }
      if (_horsePowerTextField.text.trim().isNullOrBlank) {
        _horsePowerTextField.errorText = S.of(context).fieldCannotBeEmpty;
        isValid = false;
      }
    });

    return isValid;
  }

  void _saveVehicleData() {
    if (_validateFields()) {
      widget.onVehicleSave(
        AddVehicleRequest(
          userId: widget.userId,
          vehicleBrand: _brandTextField.text.firstLetterToUpperCase,
          vehicleHp: _horsePowerTextField.text.toInt(),
          vehicleModel: _modelTextField.text.firstLetterToUpperCase,
          vehicleType: _vehicleType.value.index,
        ),
      );
    }
  }
}
