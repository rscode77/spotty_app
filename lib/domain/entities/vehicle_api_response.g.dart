// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleApiResponseImpl _$$VehicleApiResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$VehicleApiResponseImpl(
      vehicleId: json['vehicleId'] as int,
      userId: json['userId'] as int,
      vehicleBrand: json['vehicleBrand'] as String,
      vehicleColor: json['vehicleColor'] as String,
      vehicleHp: json['vehicleHp'] as int,
      vehicleImage: json['vehicleImage'] as String,
      vehicleModel: json['vehicleModel'] as String,
      vehicleDescription: json['vehicleDescription'] as String,
      vehicleType: json['vehicleType'] as int,
    );

Map<String, dynamic> _$$VehicleApiResponseImplToJson(
        _$VehicleApiResponseImpl instance) =>
    <String, dynamic>{
      'vehicleId': instance.vehicleId,
      'userId': instance.userId,
      'vehicleBrand': instance.vehicleBrand,
      'vehicleColor': instance.vehicleColor,
      'vehicleHp': instance.vehicleHp,
      'vehicleImage': instance.vehicleImage,
      'vehicleModel': instance.vehicleModel,
      'vehicleDescription': instance.vehicleDescription,
      'vehicleType': instance.vehicleType,
    };