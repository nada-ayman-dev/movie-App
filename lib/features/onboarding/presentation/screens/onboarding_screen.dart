
import 'package:flutter/material.dart';

import '../../model/onboarding_model.dart';
import '../widgets/onboarding_body.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() =>
      _OnBoardingScreenState();
}

class _OnBoardingScreenState
    extends State<OnBoardingScreen> {

  final PageController _pageController =
  PageController();

  int currentIndex = 0;

  void nextPage() {

    if (currentIndex ==
        OnBoardingData.items.length - 1) {

      /// Navigate To sign in screen

    } else {

      _pageController.nextPage(

        duration: const Duration(milliseconds: 300),

        curve: Curves.decelerate,
      );
    }
  }

  void previousPage() {

    _pageController.previousPage(

      duration: const Duration(milliseconds: 300),

      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: PageView.builder(

        controller: _pageController,

        onPageChanged: (index) {

          setState(() {

            currentIndex = index;
          });
        },

        itemCount:
        OnBoardingData.items.length,

        itemBuilder: (context, index) {

          return OnBoardingBody(

            model:
            OnBoardingData.items[index],

            onNext: nextPage,

            onBack: previousPage,

            isFirstPage: currentIndex == 0,

            isLastPage:
            currentIndex ==
                OnBoardingData.items.length - 1,
          );
        },
      ),
    );
  }
}