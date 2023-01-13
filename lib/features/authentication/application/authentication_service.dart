import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:stoke_reviews_app/features/authentication/data/auth_repository_impl.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_login_model.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_model.dart';

import '../../../utils/app_custom_error.dart';
import '../../../utils/enums.dart';

final authServiceStateNotifierProvider =
    StateNotifierProvider<AuthServiceStateNotifier, ApiCallEnum>((ref) {
  return AuthServiceStateNotifier(ref.read(authRepoImpl));
});

class AuthServiceStateNotifier extends StateNotifier<ApiCallEnum> {
  final AuthRepositoryImpl _authRepositoryImpl;
  AuthServiceStateNotifier(this._authRepositoryImpl) : super(ApiCallEnum.idle);

  String errorMessage = '';

  registerUser({required WidgetRef ref, required UserModel userModel}) async {
    state = ApiCallEnum.loading;

    Either<AppCustomError, String> register =
        await _authRepositoryImpl.register(userModel: userModel);
    register.fold((appCustomError) {
      errorMessage = appCustomError.errorMsg;
      state = ApiCallEnum.error;
    }, (data) {
      state = ApiCallEnum.success;
      Map<String, dynamic> payload = Jwt.parseJwt(data);

      ref.read(userStateProvider.notifier).state = UserModel(
          userId: int.parse(payload['nameid']),
          fullName: payload['name'],
          userRoleName: payload['role']);
    });
  }

  loginUser(
      {required WidgetRef ref,
      required String email,
      required String password}) async {
    state = ApiCallEnum.loading;

    Either<AppCustomError, String> login =
        await _authRepositoryImpl.login(email: email, password: password);
    login.fold((appCustomError) {
      errorMessage = appCustomError.errorMsg;
      state = ApiCallEnum.error;
    }, (data) {
      state = ApiCallEnum.success;
      Map<String, dynamic> payload = Jwt.parseJwt(data);
      ref.read(userStateProvider.notifier).state = UserModel(
        userId: int.parse(payload['nameid']),
        fullName: payload['name'],
        userRoleName: payload['role'],
      );
      return data;
    });
  }
}
