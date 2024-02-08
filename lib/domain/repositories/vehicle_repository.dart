import 'package:dio/dio.dart';
import 'package:spotty_app/data/models/requests/add_vehicle_request.dart';
import 'package:spotty_app/data/models/requests/remove_vehicle_request.dart';
import 'package:spotty_app/data/models/requests/update_default_vehicle_request.dart';
import 'package:spotty_app/data/repositories/vehicle_interface.dart';
import 'package:spotty_app/endpoints.dart';

class VehicleRepository implements VehicleInterface {
  final Dio dio;

  VehicleRepository({required this.dio});

  @override
  Future<Response> addVehicle(AddVehicleRequest addVehicleRequest) async {
    final Response response = await dio.post(
      VehicleEndpoints.addVehicle,
      data: addVehicleRequest.toJson(),
    );
    return response;
  }

  @override
  Future<Response> deleteVehicle(RemoveVehicleRequest removeVehicleRequest) async {
    final Response response = await dio.delete(
      VehicleEndpoints.removeVehicle,
      data: removeVehicleRequest.toJson(),
    );
    return response;
  }

  @override
  Future<Response> updateDefaultVehicle(UpdateDefaultVehicleRequest updateDefaultVehicleRequest) async {
    final Response response = await dio.put(
      UserEndpoints.updateDefaultVehicle,
      data: updateDefaultVehicleRequest.toJson(),
    );
    return response;
  }
}
