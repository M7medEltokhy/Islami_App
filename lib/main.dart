import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_strings.dart';
import 'package:islami/features/tabs/main_screen.dart';
import 'package:islami/features/onboarding/screen/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IslamiApp());
}

class IslamiApp extends StatelessWidget {
  const IslamiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      splitScreenMode: true,

      builder: (context, child) {
        return MaterialApp(
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(
            scaffoldBackgroundColor: AppColors.background,
            fontFamily: 'Janna LT Bold',
            appBarTheme: AppBarTheme(
              centerTitle: true,
              iconTheme: IconThemeData(color: AppColors.primary),
              backgroundColor: AppColors.background,
              elevation: 0,
              titleTextStyle: TextStyle(
                color: AppColors.primary,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: onboardingRoute,
          routes: {
            onboardingRoute: (_) => const OnboardingScreen(),
            homeRoute: (_) => const MainScreen(),
          },
        );
      },
    );
  }
}
