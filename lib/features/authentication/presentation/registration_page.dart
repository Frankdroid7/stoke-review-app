import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:stoke_reviews_app/custom_widgets/action_button.dart';
import 'package:stoke_reviews_app/custom_widgets/app_scaffold.dart';
import 'package:stoke_reviews_app/features/authentication/application/authentication_service.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_model.dart';
import 'package:stoke_reviews_app/route/app_router.gr.dart';
import '../../../custom_widgets/custom_textfield.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                ),
                SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Surname',
                ),
                SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Email address',
                ),
                SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Phone number',
                  isNumberOnlyInput: true,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  isPassword: true,
                  labelText: 'Password',
                ),
                SizedBox(height: 20),
                CustomTextField(
                  isPassword: true,
                  labelText: 'Confirm Password',
                ),
                SizedBox(height: 40),
                ref.watch(loadingStateProvider)
                    ? Text('Loading...')
                    : ActionButton(
                        onPressed: () async {
                          final userModel = UserModel();
                          ref.read(loadingStateProvider.notifier).state = true;

                          context.router.push(LoginRoute());
                          // await ref
                          //     .read(authServiceProvider)
                          //     .registerUser(userModel: userModel);

                          ref.read(loadingStateProvider.notifier).state = false;
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
