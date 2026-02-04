import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      width: double.infinity,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.white,
        showUnselectedLabels: false,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            backgroundColor: AppColors.primary,
            icon: Image.asset(
              'assets/images/ic_quran.png',
              color: Colors.black,
            ),
            activeIcon: activeNavItem(iconPath: 'assets/images/ic_quran.png'),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            activeIcon: activeNavItem(iconPath: 'assets/images/ic_hadeth.png'),
            icon: Image.asset('assets/images/ic_hadeth.png'),
            label: 'Hadith',
          ),
          BottomNavigationBarItem(
            activeIcon: activeNavItem(iconPath: 'assets/images/ic_sebha.png'),
            icon: Image.asset('assets/images/ic_sebha.png'),
            label: 'Sebha',
          ),
          BottomNavigationBarItem(
            activeIcon: activeNavItem(iconPath: 'assets/images/ic_radio.png'),
            icon: Image.asset('assets/images/ic_radio.png'),
            label: 'Radio',
          ),
          BottomNavigationBarItem(
            activeIcon: activeNavItem(iconPath: 'assets/images/ic_time.png'),
            icon: Image.asset('assets/images/ic_time.png'),
            label: 'Time',
          ),
        ],
      ),
    );
  }

  Container activeNavItem({required String iconPath}) {
    return Container(
      height: 34.h,
      width: 59.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(66),
        color: AppColors.background.withOpacity(0.6),
      ),
      child: Center(child: Image.asset(iconPath, color: AppColors.white)),
    );
  }
}
