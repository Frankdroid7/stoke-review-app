import 'package:dio/dio.dart';

import 'app_custom_error.dart';

AppCustomError apiError(DioError e) {
  AppCustomError message = AppCustomError('');

  switch (e.response?.statusCode) {
    case 401:
      message = AppCustomError('Something went wrong, please try again');
      break;
    default:
      message = AppCustomError('Something went wrong, please try again');
  }

  return message;
}
