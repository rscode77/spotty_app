import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:spotty_app/data/models/vehicle_model.dart';
import 'package:spotty_app/presentation/common/widgets/app_icon_button.dart';
import 'package:spotty_app/utils/extensions/sized_box_extension.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';
import 'package:spotty_app/utils/styles/app_text_styles.dart';

class VehicleListViewElement extends StatelessWidget {
  final int defaultVehicleId;
  final Vehicle vehicle;
  final bool isDarkTheme;
  final Function(int vehicleId) onRemoveVehicle;
  final Function(int vehicleId) onSetDefaultVehicle;

  const VehicleListViewElement({
    super.key,
    required this.defaultVehicleId,
    required this.vehicle,
    required this.isDarkTheme,
    required this.onRemoveVehicle,
    required this.onSetDefaultVehicle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSetDefaultVehicle(vehicle.vehicleId),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        height: 60,
        decoration: BoxDecoration(
          color: defaultVehicleId == vehicle.vehicleId
              ? AppColors.blue
              : isDarkTheme
                  ? DarkAppColors.lightGray
                  : DarkAppColors.lightGray,
          borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (defaultVehicleId == vehicle.vehicleId) _radioButton(),
            const Space.horizontal(8.0),
            Text(
              '${vehicle.vehicleBrand} ${vehicle.vehicleModel} | ${vehicle.vehicleHp} KM',
              style: AppTextStyles.eventInformation().copyWith(
                fontSize: 13.0,
                color: defaultVehicleId == vehicle.vehicleId
                    ? AppColors.white
                    : isDarkTheme
                        ? DarkAppColors.grayText
                        : LightAppColors.grayText,
              ),
            ),
            const Spacer(),
            _removeButton(),
          ],
        ),
      ),
    );
  }

  Widget _radioButton() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 4.0,
        right: 2.0,
      ),
      child: Icon(
        LucideIcons.check,
        color: AppColors.white,
        size: 16,
      ),
    );
  }

  Widget _removeButton() {
    return SizedBox(
      height: 40,
      width: 40,
      child: Center(
        child: AppIconButton(
          icon: LucideIcons.trash,
          iconSize: 15,
          color: AppColors.white,
          onPressed: () => onRemoveVehicle(vehicle.vehicleId),
        ),
      ),
    );
  }
}
