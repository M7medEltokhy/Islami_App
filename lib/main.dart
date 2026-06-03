import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_strings.dart';
import 'package:islami/core/helpers/pref_helper.dart';
import 'package:islami/features/tabs/main_screen.dart';
import 'package:islami/features/onboarding/screen/onboarding_screen.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isFirst = await PrefHelper.checkAndSetFirstOpen();
  runApp(IslamiApp(isFirstOpen: isFirst));
}

class IslamiApp extends StatelessWidget {
  final bool isFirstOpen;
  const IslamiApp({super.key, required this.isFirstOpen});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorObservers: [routeObserver], // ← نفس الـ instance
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
          initialRoute: isFirstOpen ? onboardingRoute : homeRoute,
          routes: {
            onboardingRoute: (_) => const OnboardingScreen(),
            homeRoute: (_) => const MainScreen(),
          },
        );
      },
    );
  }
}