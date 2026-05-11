import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Image.asset("assets/images/splash_view_movie_app.png",fit: BoxFit.cover,height: 300,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Image.asset("assets/images/splash_view_logo.png",fit: BoxFit.cover,height: 80,),
            ),
          )
        ],
      ),
    );
  }
}
