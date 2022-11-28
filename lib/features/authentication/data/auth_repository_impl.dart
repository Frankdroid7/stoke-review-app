import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/constants/api_constants.dart';
import 'package:stoke_reviews_app/features/authentication/data/auth_repository.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_model.dart';

import '../../../utils/app_custom_error.dart';

final authRepoImpl =
    Provider<AuthRepositoryImpl>((ref) => AuthRepositoryImpl());

class AuthRepositoryImpl extends AuthRepository {
  var dio = Dio();

  @override
  Future<Either<AppCustomError, String>> login(
      {required String email, required String password}) async {
    Map<String, String> userCredentialsMap = {
      'email': email,
      'password': password,
    };

    try {
      Response response = await dio.get(ApiConstants.loginUser,
          queryParameters: userCredentialsMap);
      return right(response.data as String);
    } on DioError catch (e) {
      return left(onApiError(e));
    }
  }

  @override
  Future<String> register({required UserModel userModel}) async {
    await Future.delayed(Duration(seconds: 2));
    return 'REGISTERED';
  }
}

AppCustomError onApiError(DioError e) {
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
