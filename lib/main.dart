import 'package:flutter/material.dart';
import 'package:movie/core/config/routes/app_routes.dart';
import 'package:movie/core/config/routes/page_route_name.dart';
import 'package:movie/core/config/theme/app_theme_manager.dart';

import 'features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "movie app",
      home: OnBoardingScreen(),
      theme: AppThemeManager.getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: PageRouteName.initial,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
