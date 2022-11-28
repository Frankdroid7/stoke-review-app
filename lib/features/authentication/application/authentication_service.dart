import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/features/authentication/data/auth_repository_impl.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_login_model.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_model.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_states.dart';

import '../../../utils/app_custom_error.dart';

final authServiceStateNotifierProvider =
    StateNotifierProvider<AuthServiceStateNotifier, UserStates>((ref) {
  return AuthServiceStateNotifier(ref.read(authRepoImpl));
});

final loadingStateProvider = StateProvider<bool>((ref) => false);

class AuthServiceStateNotifier extends StateNotifier<UserStates> {
  final AuthRepositoryImpl _authRepositoryImpl;
  AuthServiceStateNotifier(this._authRepositoryImpl) : super(UserStates.idle);

  String errorMessage = '';

  Future<String> registerUser({required UserModel userModel}) {
    return _authRepositoryImpl.register(userModel: userModel);
  }

  loginUsr({required String email, required String password}) async {
    state = UserStates.loading;

    Either<AppCustomError, String> login =
        await _authRepositoryImpl.login(email: email, password: password);
    login.fold((appCustomError) {
      errorMessage = appCustomError.error;
      state = UserStates.error;
      print('ERR MSG -> $errorMessage');
    }, (data) {
      state = UserStates.data;
      return data;
    });
  }
}
