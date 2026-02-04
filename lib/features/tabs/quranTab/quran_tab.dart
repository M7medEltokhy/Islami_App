import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/features/tabs/quranTab/widgets/most_recently.dart';
import 'package:islami/features/tabs/quranTab/widgets/sura_search.dart';
import 'package:islami/features/tabs/quranTab/widgets/suras_list.dart';

class QuranTab extends StatelessWidget {
  const QuranTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 205.h),
          SuraSearch(),
          SizedBox(height: 20.h),
          MostRecently(),
          SizedBox(height: 10.h),
          Expanded(child: SurasList()),
        ],
      ),
    );
  }
}
