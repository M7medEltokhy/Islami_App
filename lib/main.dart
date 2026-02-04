import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_strings.dart';
import 'package:islami/features/tabs/main_screen.dart';
import 'package:islami/features/onboarding/screen/onboarding_screen.dart';

void main() {
  runApp(const IslamiApp());
}

class IslamiApp extends StatelessWidget {
  const IslamiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: 'Janna LT Bold',
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: onboardingRoute,
        routes: {
          onboardingRoute: (context) => const OnboardingScreen(),
          homeRoute: (context) => const MainScreen(),
        },
      ),
    );
  }
}
