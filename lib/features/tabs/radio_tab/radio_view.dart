import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/features/tabs/radio_tab/widget/radio_list.dart';
import 'package:islami/features/tabs/radio_tab/widget/reciters_list.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(height: 200.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFF202020),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: TabBar(
                indicatorWeight: 5,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Color(0xFFE8C27D),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(text: 'Radio'),
                  Tab(text: 'Reciters'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: TabBarView(children: [RadioList(), RecitersList()]),
            ),
          ],
        ),
      ),
    );
  }
}
