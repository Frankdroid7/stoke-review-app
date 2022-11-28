import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stoke_reviews_app/custom_widgets/app_scaffold.dart';
import 'package:stoke_reviews_app/route/app_router.gr.dart';

import '../../../custom_widgets/action_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Stoke Reviews App',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionButton(
                onPressed: () {
                  context.router.push(const RegistrationRoute());
                },
                title: 'Register',
              ),
              const SizedBox(width: 50),
              ActionButton(
                onPressed: () {
                  context.router.push(const LoginRoute());
                },
                title: 'Login',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
