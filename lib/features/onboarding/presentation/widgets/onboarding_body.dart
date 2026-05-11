


import 'package:flutter/material.dart';

import '../../data/onboarding_data.dart';

class OnBoardingBody extends StatelessWidget {
  final OnBoardingModel model;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final bool isLastPage;

  const OnBoardingBody({
    super.key,
    required this.model,
    required this.onNext,
    this.onBack,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          model.image2,
          fit: BoxFit.cover,
        ),
        Image.asset(
          model.image,
          fit: BoxFit.cover,
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child:model.index == '0' ? SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    model.title,
                    textAlign: TextAlign.center,
                    style: model.index == '0' ? TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ) : TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                   Text(
                    model.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        backgroundColor: Color(0xffF6BD00),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: onNext,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          isLastPage ? 'Finish' : 'Next',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (model.showBackButton)
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xffF6BD00)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: onBack,
                        child: const Text('Back',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF6BD00),
                        ),),
                      ),
                    ),
                ],
              ),
            ),
          ) :
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),

            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
              
                  Text(
                    model.title,
                    textAlign: TextAlign.center,
                    style: model.index == '0' ? TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ) : TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              
                  const SizedBox(height: 16),
              
                  Text(
                    model.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                  ),
              
                  const SizedBox(height: 30),
              
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
              
                        backgroundColor: Color(0xffF6BD00),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: onNext,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          isLastPage ? 'Finish' : 'Next',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        ),
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 12),
              
                  if (model.showBackButton)
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xffF6BD00)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: onBack,
                        child: const Text('Back',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF6BD00),
                        ),),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}