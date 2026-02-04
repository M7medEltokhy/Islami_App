  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islami/core/constants/app_colors.dart';

PageViewModel onboardingPage({
    required String image,
    required String title,
    String? subtitle,
  }) {
    return PageViewModel(
      useScrollView: false,
      
      titleWidget: Image.asset(
        "assets/images/img_header.png",
        height: 171.h,
        width: 291.w,
        fit: BoxFit.contain,
      ),

      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(image, height: 350.h, fit: BoxFit.fill),

          SizedBox(height: 50.h),

          Text(
            title,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 30.h),

          if (subtitle != null)
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.primary, fontSize: 20.sp),
            ),
        ],
      ),
    );
  }