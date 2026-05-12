import 'package:flutter/material.dart';

import 'package:movie/core/config/routes/app_routes.dart';
import 'package:movie/core/config/theme/app_theme_manager.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await FirebaseService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "movie app",
      theme: AppThemeManager.getTheme(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
