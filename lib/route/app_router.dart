import 'package:auto_route/annotations.dart';
import 'package:stoke_reviews_app/features/authentication/presentation/login_page.dart';
import 'package:stoke_reviews_app/features/ranked_places/presentation/home_page.dart';

import '../features/authentication/presentation/onboarding_page.dart';
import '../features/authentication/presentation/registration_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: RegistrationPage),
    AutoRoute(page: OnboardingPage, initial: true),
  ],
)
class $AppRouter {}
