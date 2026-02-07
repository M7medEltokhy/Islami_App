import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/features/tabs/quranTab/data/sura_name.dart';

class SuraDetails extends StatelessWidget {
  final int index;

  const SuraDetails({super.key, required this.index});

  Future<List<String>> readSuraAyats() async {
    final suraData = await rootBundle.loadString(
      'assets/files/Suras/$index.txt',
    );

    return suraData.trim().split('\n');
  }

  String toArabicNumber(int number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number
        .toString()
        .split('')
        .map((e) => arabicDigits[int.parse(e)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    final suraName = SuraName.suras[index - 1];

    return Scaffold(
      appBar: AppBar(title: Text(suraName.nameEn), centerTitle: true),
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/quran_sura_details.png'),
            fit: BoxFit.fill,
          ),
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),

          child: FutureBuilder<List<String>>(
            future: readSuraAyats(),
            builder: (context, snapshot) {
              final verses = snapshot.data!;

              return Column(
                children: [
                  Text(
                    suraName.nameAr,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20.h),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),

                      child: Column(
                        children: [
                          index != 1
                              ? Text(
                                  'بسم الله الرحمن الرحيم',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 26.sp,
                                    height: 2,
                                  ),
                                )
                              : SizedBox.shrink(),
                          RichText(
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 26.sp,
                                height: 2,
                              ),
                              children: List.generate(
                                verses.length,
                                (index) => TextSpan(
                                  children: [
                                    TextSpan(text: "${verses[index]} "),
                                    TextSpan(
                                      text: "﴿${toArabicNumber(index + 1)}﴾ ",
                                      style: TextStyle(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
