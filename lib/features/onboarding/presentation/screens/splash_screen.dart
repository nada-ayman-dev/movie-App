import 'package:flutter/material.dart';
import 'package:movie/core/config/routes/page_route_name.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        PageRouteName.onboarding,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                "assets/images/splash_view_movie_app.png",
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Image.asset(
                "assets/images/splash_view_logo.png",
                fit: BoxFit.cover,
                height: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
