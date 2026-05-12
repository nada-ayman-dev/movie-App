import 'package:flutter/material.dart';
import 'package:movie/core/config/routes/page_route_name.dart';
import 'package:movie/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:movie/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:movie/features/login/presentation/pages/login_page.dart';
import 'package:movie/features/forgot_password/presentation/pages/forgot_password_page.dart';
import 'package:movie/features/signup/presentation/pages/signup_page.dart';
import 'package:movie/shared/widgets/app_shell.dart';

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
      case PageRouteName.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: setting,
        );
      case PageRouteName.signup:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
          settings: setting,
        );
      case PageRouteName.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordPage(),
          settings: setting,
        );
      case PageRouteName.home:
        return MaterialPageRoute(
          builder: (_) => const AppShell(),
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
