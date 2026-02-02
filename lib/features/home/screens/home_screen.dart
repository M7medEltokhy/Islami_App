import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text('Home Screen', style: TextStyle(color: AppColors.primary)),
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyle(color: AppColors.primary),
        ),
      ),
    );
  }
}
