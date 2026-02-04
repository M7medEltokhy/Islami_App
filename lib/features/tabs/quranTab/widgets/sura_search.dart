import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_colors.dart';

class SuraSearch extends StatelessWidget {
  const SuraSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        constraints: BoxConstraints(maxHeight: 55.h),
        hintText: 'Sura Name',
        hintStyle: TextStyle(color: Color(0xffFEFFE8), fontSize: 18.sp),
        prefixIcon: Image.asset(
          'assets/images/ic_quran.png',
          color: AppColors.primary,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
