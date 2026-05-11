import 'package:flutter/material.dart';
import 'package:movie/core/config/routes/page_route_name.dart';
import 'package:movie/features/onboarding/presentation/screens/home_view_screen.dart';
import 'package:movie/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:movie/features/onboarding/presentation/screens/splash_screen.dart';


abstract class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case PageRouteName.initial:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
          settings: setting,
        );
      case PageRouteName.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
          settings: setting,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
          settings: setting,
        );
    }
  }
}