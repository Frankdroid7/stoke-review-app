// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../features/authentication/presentation/login_page.dart' as _i2;
import '../features/authentication/presentation/onboarding_page.dart' as _i4;
import '../features/authentication/presentation/registration_page.dart' as _i5;
import '../features/ranked_places/domain/places_model.dart' as _i9;
import '../features/ranked_places/presentation/home_page.dart' as _i1;
import '../features/review_and_comment/presentation/review_page.dart' as _i6;
import '../features/search/presentation/search_page.dart' as _i3;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SearchPage(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.OnboardingPage(),
      );
    },
    RegistrationRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.RegistrationPage(),
      );
    },
    ReviewRoute.name: (routeData) {
      final args = routeData.argsAs<ReviewRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.ReviewPage(
          key: args.key,
          placesModel: args.placesModel,
        ),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i7.RouteConfig(
          LoginRoute.name,
          path: '/login-page',
        ),
        _i7.RouteConfig(
          SearchRoute.name,
          path: '/search-page',
        ),
        _i7.RouteConfig(
          OnboardingRoute.name,
          path: '/onboarding-page',
        ),
        _i7.RouteConfig(
          RegistrationRoute.name,
          path: '/registration-page',
        ),
        _i7.RouteConfig(
          ReviewRoute.name,
          path: '/review-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.SearchPage]
class SearchRoute extends _i7.PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: '/search-page',
        );

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i4.OnboardingPage]
class OnboardingRoute extends _i7.PageRouteInfo<void> {
  const OnboardingRoute()
      : super(
          OnboardingRoute.name,
          path: '/onboarding-page',
        );

  static const String name = 'OnboardingRoute';
}

/// generated route for
/// [_i5.RegistrationPage]
class RegistrationRoute extends _i7.PageRouteInfo<void> {
  const RegistrationRoute()
      : super(
          RegistrationRoute.name,
          path: '/registration-page',
        );

  static const String name = 'RegistrationRoute';
}

/// generated route for
/// [_i6.ReviewPage]
class ReviewRoute extends _i7.PageRouteInfo<ReviewRouteArgs> {
  ReviewRoute({
    _i8.Key? key,
    required _i9.PlacesModel placesModel,
  }) : super(
          ReviewRoute.name,
          path: '/review-page',
          args: ReviewRouteArgs(
            key: key,
            placesModel: placesModel,
          ),
        );

  static const String name = 'ReviewRoute';
}

class ReviewRouteArgs {
  const ReviewRouteArgs({
    this.key,
    required this.placesModel,
  });

  final _i8.Key? key;

  final _i9.PlacesModel placesModel;

  @override
  String toString() {
    return 'ReviewRouteArgs{key: $key, placesModel: $placesModel}';
  }
}
