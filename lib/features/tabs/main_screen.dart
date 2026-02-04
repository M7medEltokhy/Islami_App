import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/features/tabs/bottom_nav_bar.dart';
import 'package:islami/features/tabs/quranTab/quran_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  List<String> bgImages = [
    'assets/images/BackgroundQ.png',
    'assets/images/BackgroundH.png',
    'assets/images/BackgroundS.png',
    'assets/images/BackgroundR.png',
    'assets/images/BackgroundT.png',
  ];

  List<Widget> screens = [
    QuranTab(),
    QuranTab(),
    QuranTab(),
    QuranTab(),
    QuranTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(bgImages[currentIndex]),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20,
              child: SizedBox(
                height: 170.h,
                // width: 350,
                child: Image(image: AssetImage('assets/images/img_header.png')),
              ),
            ),
            screens[currentIndex],
          ],
        ),

        bottomNavigationBar: BottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
