import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islami/core/constants/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: AppColors.background,
        pages: pages(),

        dotsDecorator: DotsDecorator(
          activeColor: AppColors.primary,
          color: Colors.grey,
          size: Size(8, 8),
          activeSize: Size(22, 8),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),

        showBackButton: true,

        back: Text(
          "Back",
          style: TextStyle(color: AppColors.primary, fontSize: 18),
        ),

        next: Text(
          "Next",
          style: TextStyle(color: AppColors.primary, fontSize: 18),
        ),

        done: Text(
          "Start",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),

        onDone: () => Navigator.pushReplacementNamed(context, '/home'),
        onSkip: () => Navigator.pushReplacementNamed(context, '/home'),
      ),
    );
  }

  List<PageViewModel> pages() {
    return [
      onboardingPage(
        image: "assets/images/onboarding1.png",
        title: "Welcome To Islmi App",
      ),
      onboardingPage(
        image: "assets/images/onboarding2.png",
        title: "Welcome To Islami",
        subtitle: "We Are Very Excited To Have You In Our Community",
      ),
      onboardingPage(
        image: "assets/images/onboarding3.png",
        title: "Reading the Quran",
        subtitle: "Read, and your Lord is the Most Generous",
      ),
      onboardingPage(
        image: "assets/images/onboarding4.png",
        title: "Bearish",
        subtitle: "Praise the name of your Lord, the Most High",
      ),
      onboardingPage(
        image: "assets/images/onboarding5.png",
        title: "Holy Quran Radio",
        subtitle:
            "You can listen to the Holy Quran Radio through the application for free and easily",
      ),
    ];
  }

  PageViewModel onboardingPage({
    required String image,
    required String title,
    String? subtitle,
  }) {
    return PageViewModel(
      useScrollView: false,

      titleWidget: Image.asset(
        "assets/images/onboarding_head.png",
        height: 171,
        width: 291,
        fit: BoxFit.contain,
      ),

      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(image, height: 350, fit: BoxFit.fill),

          SizedBox(height: 50),

          Text(
            title,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 30),

          if (subtitle != null)
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.primary, fontSize: 20),
            ),
        ],
      ),
    );
  }
}
