import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/features/tabs/hadithTab/widgets/hadith_card.dart';

class HadithTab extends StatelessWidget {
  const HadithTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 200.h),
        CarouselSlider.builder(
          itemCount: 50,
          itemBuilder: (context, index, realIndex) {
            return SizedBox(
              width: 320.w,
              child: HadithCard(index: index + 1),
            );
          },
          options: CarouselOptions(
            height: 625.h,
            viewportFraction: 0.75,
            enlargeCenterPage: true,
            enlargeFactor: .2,
            enableInfiniteScroll: true,
            autoPlay: false,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        ),
      ],
    );
  }
}
