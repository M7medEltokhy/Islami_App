import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_colors.dart';

class MostRecently extends StatelessWidget {
  const MostRecently({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Most Recently',
          style: TextStyle(
            color: Color(0xffFEFFE8),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 17.w,
                    right: 7.w,
                    top: 7.h,
                    bottom: 7.h,
                  ),
                  height: 150.h,
                  width: 283.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Al-Anbiya',
                            style: TextStyle(
                              color: AppColors.background,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'الأنبياء',
                            style: TextStyle(
                              color: AppColors.background,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '112 Verses',
                            style: TextStyle(
                              color: AppColors.background,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/img_most_recent.png',
                        height: 136.h,
                        width: 147.w,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
