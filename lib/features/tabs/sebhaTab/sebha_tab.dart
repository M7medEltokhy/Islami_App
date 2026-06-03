import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_colors.dart';

class SebhaView extends StatefulWidget {
  const SebhaView({super.key});

  @override
  State<SebhaView> createState() => _SebhaViewState();
}

class _SebhaViewState extends State<SebhaView> {
  int sebhaCounter = 0;
  int currentSebhaIndex = 0;

  final List<String> sebhaItems = [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
    "لا إله إلا الله",
    "لا حول ولا قوة الا بالله",
    "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ ﷺ",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 220.h),

            Text(
              "سَبِّحِ اسْمَ رَبِّكَ الأعلى ",
              style: TextStyle(fontSize: 30.sp, color: Colors.white),
            ),

            SizedBox(height: 100.h),

            GestureDetector(
              onTap: () {
                setState(() {
                  sebhaCounter++;

                  // if (sebhaCounter == 33) {
                  //   sebhaCounter = 0;
                  //   currentSebhaIndex =
                  //       (currentSebhaIndex + 1) % sebhaItems.length;
                  // }
                });
              },
              child: SizedBox(
                width: 400.w,
                height: 400.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedRotation(
                      turns: sebhaCounter * 0.03,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      child: Image.asset(
                        "assets/images/sebha_body.png",
                        width: 400.w,
                      ),
                    ),

                    Align(
                      alignment: const Alignment(0.09, -1.56),
                      child: Image.asset(
                        "assets/images/sebha_head.png",
                        height: 90.h,
                      ),
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton(
                          dropdownColor: AppColors.primary.withValues(
                            alpha: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                          iconDisabledColor: Colors.white,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          underline: SizedBox.shrink(),
                          alignment: AlignmentDirectional.center,
                          // iconSize: 0,
                          value: currentSebhaIndex,
                          items: sebhaItems
                              .map(
                                (item) => DropdownMenuItem(
                                  value: sebhaItems.indexOf(item),
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (index) {
                            setState(() {
                              currentSebhaIndex = index!;
                            });
                          },
                        ),
                        SizedBox(height: 50.h),
                        Text(
                          "$sebhaCounter",
                          style: TextStyle(
                            fontSize: 36.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 50.h),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              sebhaCounter = 0;
                              // currentSebhaIndex =
                              //     (currentSebhaIndex + 1) % sebhaItems.length;
                            });
                          },
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
