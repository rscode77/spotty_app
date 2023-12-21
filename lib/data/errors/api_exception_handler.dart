import 'package:dio/dio.dart';
import 'package:spotty_app/utils/extensions/response_extension.dart';

class ApiExceptionHandler {
  Future<void> handleDioException({
    required DioException dioException,
    required Function()? onToManyRequests,
    required Function()? onBadRequest,
    required Function()? onUnauthorized,
  }) async {
    if (dioException.response != null && dioException.response!.data != null) {
      if (dioException.response!.isToManyRequests()) {
        await Future.delayed(const Duration(seconds: 1));
        onToManyRequests?.call();
      }
      if (dioException.response!.isBadRequest()) {}
      if (dioException.response!.isUnauthorized()) {}
    } else {
      throw UnimplementedError();
    }
  }
}
