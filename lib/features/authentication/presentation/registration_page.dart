import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:stoke_reviews_app/features/authentication/application/authentication_service.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_model.dart';
import 'package:stoke_reviews_app/route/app_router.gr.dart';
import 'package:stoke_reviews_app/utils/api_call_enum.dart';

import 'package:stoke_reviews_app/exports/exports.dart';

class RegistrationPage extends HookConsumerWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var firstNameCtrl = useTextEditingController();
    var surnameCtrl = useTextEditingController();
    var emailCtrl = useTextEditingController();
    var phoneNumCtrl = useTextEditingController();
    var passwordCtrl = useTextEditingController();

    var loadingState = ref.watch(loadingStateProvider.notifier).state;
    var authService = ref.read(authServiceStateNotifierProvider.notifier);

    ref.listen(authServiceStateNotifierProvider, (previous, current) {
      if (current == ApiCallEnum.error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(authService.errorMessage)));
      } else if (current == ApiCallEnum.success) {
        context.router.push(const HomeRoute());
      }
    });

    return AppScaffold(
      child: ListView(
        children: [
          SizedBox(height: 10),
          Text(
            'Stoke on Trent Reviews',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Registration',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  labelText: 'First name',
                  controller: firstNameCtrl,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Surname',
                  controller: surnameCtrl,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Email address',
                  controller: emailCtrl,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Phone number',
                  isNumberOnlyInput: true,
                  controller: phoneNumCtrl,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  isPassword: true,
                  labelText: 'Password',
                  controller: passwordCtrl,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  isPassword: true,
                  labelText: 'Confirm Password',
                ),
                SizedBox(height: 40),
                loadingState
                    ? Text('Loading...')
                    : ActionButton(
                        onPressed: () async {
                          // context.router.push(const HomeRoute());
                          final userModel = UserModel(
                            forenames: firstNameCtrl.text,
                            email: emailCtrl.text,
                            password: passwordCtrl.text,
                            phone: phoneNumCtrl.text,
                            surname: surnameCtrl.text,
                          );
                          loadingState = true;

                          authService.registerUser(userModel: userModel);

                          loadingState = false;
                        },
                        title: 'Submit',
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
