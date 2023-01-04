import 'package:auto_route/annotations.dart';
import 'package:stoke_reviews_app/features/authentication/presentation/login_page.dart';
import 'package:stoke_reviews_app/features/ranked_places/presentation/home_page.dart';
import 'package:stoke_reviews_app/features/review_and_comment/presentation/review_page.dart';

import '../features/authentication/presentation/onboarding_page.dart';
import '../features/authentication/presentation/registration_page.dart';
import '../features/review_and_comment/presentation/pdf_view.dart';
import '../features/search/presentation/search_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage),
    AutoRoute(page: LoginPage),
    AutoRoute(page: PdfView, initial: true),
    AutoRoute(page: SearchPage),
    AutoRoute(page: OnboardingPage),
    AutoRoute(page: RegistrationPage),
    AutoRoute(page: ReviewPage),
  ],
)
class $AppRouter {}
