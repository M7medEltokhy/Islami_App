import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/helpers/pref_helper.dart';
import 'package:islami/features/tabs/quranTab/data/sura_name.dart';
import 'package:islami/features/tabs/quranTab/widgets/sura_details.dart';
import 'package:islami/main.dart';

class MostRecently extends StatefulWidget {
  const MostRecently({super.key});

  @override
  State<MostRecently> createState() => _MostRecentlyState();
}

class _MostRecentlyState extends State<MostRecently> with RouteAware {
  ({int page, int surahIndex})? _lastPosition;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPosition();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _loadPosition();
  }

  Future<void> _loadPosition() async {
    final position = await PrefHelper.loadLastPosition();
    if (!mounted) return;
    setState(() {
      _lastPosition = position;
      _loading = false;
    });
  }

  void _openLastSura() {
    if (_lastPosition == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SuraDetails(
          index: _lastPosition!.surahIndex,
          initialPage: _lastPosition!.page,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _lastPosition == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last Read',
          style: TextStyle(
            color: const Color(0xffFEFFE8),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(height: 150.h, child: _buildCard()),
      ],
    );
  }

  Widget _buildCard() {
    final sura = SuraName.suras[_lastPosition!.surahIndex - 1];

    return GestureDetector(
      onTap: _openLastSura,
      child: Container(
        padding: EdgeInsets.only(left: 17.w, right: 7.w, top: 7.h, bottom: 7.h),
        height: 150.h,
        width: double.infinity,
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
                  sura.nameEn,
                  style: TextStyle(
                    color: AppColors.background,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  sura.nameAr,
                  style: TextStyle(
                    color: AppColors.background,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Page ${_lastPosition!.page}',
                  style: TextStyle(
                    color: AppColors.background.withValues(alpha: 0.75),
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
  }
}
