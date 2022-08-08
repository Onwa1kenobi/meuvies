import 'package:dio/dio.dart';
import 'package:meuvies/util/values/strings.dart';

class AppError extends Error {
  final String message;

  AppError(this.message);

  String getMessage() => message;
}

class AppNetworkError extends AppError {
  AppNetworkError(String message) : super(message);
}

String getErrorMessage(dynamic error) {
  var errorMessage = AppStrings.networkAvailabilityError;
  switch (error.runtimeType) {
    case DioError:
      final res = (error as DioError).response;
      errorMessage = res?.statusMessage ?? AppStrings.networkAvailabilityError;
      break;
    default:
      errorMessage = error.toString();
  }
  return errorMessage;
}
