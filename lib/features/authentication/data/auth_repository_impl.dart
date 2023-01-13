import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:stoke_reviews_app/utils/api_error.dart';
import '../../../utils/app_custom_error.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/constants/api_constants.dart';
import 'package:stoke_reviews_app/features/authentication/data/auth_repository.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_model.dart';

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
      debugPrint('Login result --> ${response.data}');

      return right(response.data as String);
    } on DioError catch (e) {
      debugPrint('Login error --> ${e.toString()}');

      return left(apiError(e));
    }
  }

  @override
  Future<Either<AppCustomError, String>> register(
      {required UserModel userModel}) async {
    print('register body -> ${userModel.toJson()}');
    try {
      Response response = await dio.post(
        ApiConstants.registerUser,
        data: userModel.toJson(),
      );

      String responseData = response.data;
      debugPrint('Registration result --> ${response.data}');
      Map<String, dynamic> payload = Jwt.parseJwt(responseData);
      print('REGISTER PAYLOAD -> $payload');

      return right(responseData);
    } on DioError catch (e) {
      debugPrint('Registration error --> ${e.response?.statusCode}');
      debugPrint('Registration error --> ${e.response?.data}');

      if (e.response?.data['message'] != null) {
        return left(apiError(e));
      }
      return left(apiError(e));
    }
  }
}
