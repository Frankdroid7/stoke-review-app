import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stoke_reviews_app/custom_widgets/action_button.dart';
import 'package:stoke_reviews_app/custom_widgets/app_scaffold.dart';
import 'package:stoke_reviews_app/features/authentication/application/authentication_service.dart';
import 'package:stoke_reviews_app/features/authentication/domain/user_login_model.dart';
import 'package:stoke_reviews_app/route/app_router.gr.dart';

import '../../../custom_widgets/custom_textfield.dart';
import '../domain/user_states.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var emailCtrl = useTextEditingController();
    var passwordCtrl = useTextEditingController();

    var authServiceState = ref.watch(authServiceStateNotifierProvider);

    ref.listen<UserStates>(authServiceStateNotifierProvider,
        (previous, current) {
      if (current == UserStates.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ref
                .read(authServiceStateNotifierProvider.notifier)
                .errorMessage),
          ),
        );
      } else if (current == UserStates.data) {
        context.router.replaceAll([const HomeRoute()]);
      }
    });

    return AppScaffold(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Stoke on Trent Reviews',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomTextField(
              controller: emailCtrl,
              labelText: 'Email address',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              isPassword: true,
              labelText: 'Password',
              controller: passwordCtrl,
            ),
            const SizedBox(height: 20),
            authServiceState == UserStates.loading
                ? const CircularProgressIndicator()
                : ActionButton(
                    onPressed: () async {
                      ref
                          .read(authServiceStateNotifierProvider.notifier)
                          .loginUsr(
                              email: emailCtrl.text,
                              password: passwordCtrl.text);
                    },
                    title: 'Login',
                  ),
          ],
        ),
      ),
    );
  }
}
