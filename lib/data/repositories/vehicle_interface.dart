import 'package:dio/dio.dart';
import 'package:spotty_app/data/models/requests/add_vehicle_request.dart';
import 'package:spotty_app/data/models/requests/remove_vehicle_request.dart';
import 'package:spotty_app/data/models/requests/update_default_vehicle_request.dart';

abstract class VehicleInterface {
  Future<Response> addVehicle(AddVehicleRequest addVehicleRequest);
  Future<Response> deleteVehicle(RemoveVehicleRequest removeVehicleRequest);
  Future<Response> updateDefaultVehicle(UpdateDefaultVehicleRequest updateDefaultVehicleRequest);
}