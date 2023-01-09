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
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../features/admin/presentation/admin_page.dart' as _i8;
import '../features/authentication/presentation/login_page.dart' as _i2;
import '../features/authentication/presentation/onboarding_page.dart' as _i5;
import '../features/authentication/presentation/registration_page.dart' as _i7;
import '../features/ranked_places/domain/places_model.dart' as _i11;
import '../features/ranked_places/presentation/home_page.dart' as _i1;
import '../features/review_and_comment/presentation/pdf_view.dart' as _i3;
import '../features/review_and_comment/presentation/review_page.dart' as _i6;
import '../features/search/presentation/search_page.dart' as _i4;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.HomePage(key: args.key),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    PdfView.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.PdfView(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.SearchPage(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.OnboardingPage(),
      );
    },
    ReviewRoute.name: (routeData) {
      final args = routeData.argsAs<ReviewRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.ReviewPage(
          key: args.key,
          placesModel: args.placesModel,
        ),
      );
    },
    RegistrationRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.RegistrationPage(),
      );
    },
    AdminRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.AdminPage(),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          HomeRoute.name,
          path: '/home-page',
        ),
        _i9.RouteConfig(
          LoginRoute.name,
          path: '/login-page',
        ),
        _i9.RouteConfig(
          PdfView.name,
          path: '/pdf-view',
        ),
        _i9.RouteConfig(
          SearchRoute.name,
          path: '/search-page',
        ),
        _i9.RouteConfig(
          OnboardingRoute.name,
          path: '/onboarding-page',
        ),
        _i9.RouteConfig(
          ReviewRoute.name,
          path: '/review-page',
        ),
        _i9.RouteConfig(
          RegistrationRoute.name,
          path: '/',
        ),
        _i9.RouteConfig(
          AdminRoute.name,
          path: '/admin-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i9.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i10.Key? key})
      : super(
          HomeRoute.name,
          path: '/home-page',
          args: HomeRouteArgs(key: key),
        );

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.PdfView]
class PdfView extends _i9.PageRouteInfo<void> {
  const PdfView()
      : super(
          PdfView.name,
          path: '/pdf-view',
        );

  static const String name = 'PdfView';
}

/// generated route for
/// [_i4.SearchPage]
class SearchRoute extends _i9.PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: '/search-page',
        );

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i5.OnboardingPage]
class OnboardingRoute extends _i9.PageRouteInfo<void> {
  const OnboardingRoute()
      : super(
          OnboardingRoute.name,
          path: '/onboarding-page',
        );

  static const String name = 'OnboardingRoute';
}

/// generated route for
/// [_i6.ReviewPage]
class ReviewRoute extends _i9.PageRouteInfo<ReviewRouteArgs> {
  ReviewRoute({
    _i10.Key? key,
    required _i11.PlacesModel placesModel,
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

  final _i10.Key? key;

  final _i11.PlacesModel placesModel;

  @override
  String toString() {
    return 'ReviewRouteArgs{key: $key, placesModel: $placesModel}';
  }
}

/// generated route for
/// [_i7.RegistrationPage]
class RegistrationRoute extends _i9.PageRouteInfo<void> {
  const RegistrationRoute()
      : super(
          RegistrationRoute.name,
          path: '/',
        );

  static const String name = 'RegistrationRoute';
}

/// generated route for
/// [_i8.AdminPage]
class AdminRoute extends _i9.PageRouteInfo<void> {
  const AdminRoute()
      : super(
          AdminRoute.name,
          path: '/admin-page',
        );

  static const String name = 'AdminRoute';
}
