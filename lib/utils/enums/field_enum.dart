import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum FieldsEnum {
  Username("Username"),
  Password("Password"),
  Email("Email"),
  VehicleBrand("VehicleBrand"),
  VehicleHp("VehicleHp"),
  VehicleModel("VehicleModel"),
  VehicleDescription("VehicleDescription"),
  VehicleType("VehicleType"),
  Title("Title"),
  Description("Description"),
  Date("Date");

  const FieldsEnum(this.value);
  final String value;
}

extension FieldsEnumExtension on FieldsEnum {
  IconData get icon {
    switch (this) {
      case FieldsEnum.Username:
        return Icons.person_outline_rounded;
      case FieldsEnum.Password:
        return Icons.lock_open_rounded;
      case FieldsEnum.Email:
        return Icons.email;
      case FieldsEnum.VehicleBrand:
        return LucideIcons.text;
      case FieldsEnum.VehicleHp:
        return LucideIcons.gauge;
      case FieldsEnum.VehicleModel:
        return LucideIcons.text;
      case FieldsEnum.VehicleDescription:
        return Icons.description;
      case FieldsEnum.Title:
        return Icons.title;
      case FieldsEnum.Description:
        return Icons.description;
      case FieldsEnum.Date:
        return Icons.date_range;
      case FieldsEnum.VehicleType:
        return Icons.directions_car;
      default:
        throw Exception("Unknown FieldsEnum value");
    }
  }
}
