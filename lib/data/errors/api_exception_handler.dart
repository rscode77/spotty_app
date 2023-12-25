import 'package:dio/dio.dart';
import 'package:spotty_app/domain/entities/api_response.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';

class ApiExceptionHandler {
  Future<void> handleDioException({
    required DioException dioException,
    required Function()? onToManyRequests,
    required Function(ApiResponse response)? onBadRequest,
    required Function()? onUnauthorized,
  }) async {
    if (dioException.response != null && dioException.response!.data != null) {
      if (dioException.response!.isToManyRequests()) {
        await Future.delayed(const Duration(seconds: 1));
        onToManyRequests?.call();
      }
      if (dioException.response!.isBadRequest()) {
        ApiResponse apiResponse = ApiResponse.fromJson(dioException.response!.data);
        onBadRequest?.call(apiResponse);
        print(apiResponse.message);
      }
      if (dioException.response!.isUnauthorized()) {}
    } else {
      throw UnimplementedError();
    }
  }
}
