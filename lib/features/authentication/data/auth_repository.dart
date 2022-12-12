import 'package:dartz/dartz.dart';

import '../../../utils/app_custom_error.dart';
import '../domain/user_model.dart';

abstract class AuthRepository {
  Future<Either<AppCustomError, String>> register(
      {required UserModel userModel});
  Future<Either<AppCustomError, String>> login(
      {required String email, required String password});
}
