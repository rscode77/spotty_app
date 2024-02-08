import 'package:flutter/material.dart';
import 'package:spotty_app/generated/l10n.dart';
import 'package:spotty_app/presentation/common/widgets/app_text_field.dart';
import 'package:spotty_app/utils/constants/constants.dart';
import 'package:spotty_app/utils/enums/field_enum.dart';
import 'package:spotty_app/utils/extensions/text_edit_controller_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

class AddNewVehiclePage extends StatefulWidget {
  const AddNewVehiclePage({super.key});

  @override
  State<AddNewVehiclePage> createState() => _AddNewVehiclePageState();
}

class _AddNewVehiclePageState extends State<AddNewVehiclePage> {
  bool get _isDarkTheme => Theme.of(context).brightness == Brightness.dark;

  final ExtendedTextEditingController _brandTextField = ExtendedTextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(children: [
      _buildVehicleBrandTextfield(),
      _buildVehicleModelTextField(),
      _buildVehicleHorsePowerTextField(),
      _buildVehicleTypeTextField(),
    ]);
  }

  Widget _buildVehicleBrandTextfield() {
    return AppTextField(
      controller: _brandTextField,
      hint: 'Wprowadź markę',
      field: FieldsEnum.VehicleBrand,
      isDarkTheme: _isDarkTheme,
    );
  }

  Widget _buildVehicleModelTextField() {
    return AppTextField(
      controller: _brandTextField,
      hint: 'Wprowadź markę',
      field: FieldsEnum.VehicleModel,
      isDarkTheme: _isDarkTheme,
    );
  }

  Widget _buildVehicleHorsePowerTextField() {
    return AppTextField(
      controller: _brandTextField,
      hint: 'Wprowadź ilość koni mechanicznych',
      field: FieldsEnum.VehicleModel,
      isDarkTheme: _isDarkTheme,
    );
  }

  Widget _buildVehicleTypeTextField() {
    return AppTextField(
      controller: _brandTextField,
      hint: 'Wprowadź typ pojazdu',
      field: FieldsEnum.VehicleType,
      isDarkTheme: _isDarkTheme,
    );
  }


  //https://www.carqueryapi.com/api/0.3/?callback=?&cmd=getModels&make=ford


  // String vehicleColor;
  // int vehicleHp;



  // int vehicleType;

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: Constants.centerAppBar,
      title: Text(
        S.of(context).addNewVehicle,
        style: AppTextStyles.appBarTitle().copyWith(
          color: _isDarkTheme ? DarkAppColors.darkText : LightAppColors.darkText,
        ),
      ),
      elevation: 0.0,
    );
  }
}
