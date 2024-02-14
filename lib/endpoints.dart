class Endpoints {
  static const String baseUrl = 'https://api.rscode.site:7777/api';
}

class UserEndpoints {
  static const String _prefix = '/User';
  static const String addUser = '${Endpoints.baseUrl}$_prefix/AddUser';
  static const String getUserData = '${Endpoints.baseUrl}$_prefix/GetUser';
  static const String loginUser = '${Endpoints.baseUrl}$_prefix/LoginUser';
  static const String updateDefaultVehicle = '${Endpoints.baseUrl}$_prefix/UpdateDefaultVehicle';
}

class AuthEndpoints {
  static const String _prefix = '/Auth';
  static const String refreshTokens = '${Endpoints.baseUrl}$_prefix/RefreshToken';
}

class EventEndpoints {
  static const String _prefix = '/Event';
  static const String getEvents = '${Endpoints.baseUrl}$_prefix/GetEvents';
  static const String addEvent = '${Endpoints.baseUrl}$_prefix/AddEvent';
  static const String joinEvent = '${Endpoints.baseUrl}$_prefix/JoinEvent';
  static const String leaveEvent = '${Endpoints.baseUrl}$_prefix/LeaveEvent';
}

class VehicleEndpoints {
  static const String vehicleBrands = 'https://www.carqueryapi.com/api/0.3/?cmd=getMakes';
  static const String vehicleModels = 'https://www.carqueryapi.com/api/0.3/?cmd=getModels&make=';

  static const String _prefix = '/Vehicle';
  static const String addVehicle = '${Endpoints.baseUrl}$_prefix/AddVehicle';
  static const String removeVehicle = '${Endpoints.baseUrl}$_prefix/RemoveVehicle';
}
