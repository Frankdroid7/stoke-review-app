import 'package:dio/dio.dart';

import 'app_custom_error.dart';

AppCustomError apiError(DioError e) {
  AppCustomError message = AppCustomError('');
  if (e.response?.data['message'] != null) {
    return AppCustomError(e.response?.data['message']);
  }
  switch (e.response?.statusCode) {
    case 401:
      message = AppCustomError('Something went wrong, please try again');
      break;
    default:
      message = AppCustomError('Something went wrong, please try again');
  }

  return message;
}
