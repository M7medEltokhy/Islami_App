import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/helpers/pref_helper.dart';
import 'package:islami/features/tabs/quranTab/data/sura_name.dart';
import 'package:qcf_quran_plus/qcf_quran_plus.dart';

class SuraDetails extends StatefulWidget {
  final int index;
  final int? initialPage;

  const SuraDetails({super.key, required this.index, this.initialPage});

  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetails> {
  late final PageController _pageController;
  late Future<void> _fontsFuture;
  late int _currentPage;
  bool _showPageInfo = false;
  bool _isDarkMode = false;
  bool _initialLoad = true;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? getPageNumber(widget.index, 1);

    _pageController = PageController(initialPage: _currentPage - 1);
    _fontsFuture = _loadNearbyFonts(_currentPage);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    PrefHelper.saveLastPosition(page: _currentPage, surahIndex: widget.index);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadNearbyFonts(int page) async {
    await QcfFontLoader.preloadPages(page, radius: 2);
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _fontsFuture = _loadNearbyFonts(page);
    });
    PrefHelper.saveLastPosition(page: page, surahIndex: widget.index);
  }

  void _togglePageInfo() {
    setState(() => _showPageInfo = !_showPageInfo);
  }

  _PageMetadata get _pageMetadata {
    final pageSurahs = getPageData(_currentPage);
    if (pageSurahs.isEmpty) {
      return _PageMetadata(
        surahName: SuraName.suras[widget.index - 1].nameAr,
        juzNumber: 1,
        hizbNumber: 1,
        hizbPart: '',
        isRightPage: _currentPage.isOdd,
      );
    }

    final firstPageEntry = pageSurahs.first;
    final surahNumber = firstPageEntry['surah'] as int;
    final startAyah = firstPageEntry['start'] as int;
    final quarterNumber = getQuarterNumber(surahNumber, startAyah);
    final hizbNumber = ((quarterNumber - 1) ~/ 4) + 1;

    return _PageMetadata(
      surahName: SuraName.suras[surahNumber - 1].nameAr,
      juzNumber: getJuzNumber(surahNumber, startAyah),
      hizbNumber: hizbNumber,
      hizbPart: _hizbPartName(quarterNumber),
      isRightPage: _currentPage.isOdd,
    );
  }

  String _hizbPartName(int quarterNumber) {
    switch ((quarterNumber - 1) % 4) {
      case 1:
        return 'ربع الحزب';
      case 2:
        return 'نصف الحزب';
      case 3:
        return 'ثلاثة أرباع الحزب';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final metadata = _pageMetadata;
    return Scaffold(
      backgroundColor: _isDarkMode
          ? const Color(0xff1A1A2E)
          : const Color(0xffFFF8E5),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _togglePageInfo,
        child: SafeArea(
          child: Stack(
            children: [
              QuranPageView(
                pageController: _pageController,
                highlights: const [],
                isDarkMode: _isDarkMode,
                isTajweed: false,
                pageBackgroundColor: _isDarkMode
                    ? const Color(0xff1A1A2E)
                    : const Color(0xffFFF8E5),
                ayahStyle: TextStyle(
                  color: _isDarkMode ? const Color(0xffE8D5A3) : Colors.black,
                ),
                onPageChanged: _onPageChanged,
              ),
              FutureBuilder<void>(
                future: _fontsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _initialLoad = false;
                    return const SizedBox.shrink();
                  }

                  if (!_initialLoad) return const SizedBox.shrink();

                  return ColoredBox(
                    color:
                        (_isDarkMode
                                ? const Color(0xff1A1A2E)
                                : const Color(0xffFFF8E5))
                            .withValues(alpha: 0.82),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  );
                },
              ),
              AnimatedOpacity(
                opacity: _showPageInfo ? 1 : 0,
                duration: const Duration(milliseconds: 180),
                child: IgnorePointer(
                  ignoring: !_showPageInfo,
                  child: _PageInfoOverlay(
                    pageNumber: _currentPage,
                    metadata: metadata,
                    isDarkModeToggle: () =>
                        setState(() => _isDarkMode = !_isDarkMode),
                    isDarkMode: _isDarkMode,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageMetadata {
  final String surahName;
  final int juzNumber;
  final int hizbNumber;
  final String hizbPart;
  final bool isRightPage;

  const _PageMetadata({
    required this.surahName,
    required this.juzNumber,
    required this.hizbNumber,
    required this.hizbPart,
    required this.isRightPage,
  });
}

class _PageInfoOverlay extends StatelessWidget {
  final int pageNumber;
  final _PageMetadata metadata;
  final void Function()? isDarkModeToggle;
  final bool isDarkMode;

  const _PageInfoOverlay({
    required this.pageNumber,
    required this.metadata,
    this.isDarkModeToggle,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black.withValues(alpha: 0.18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _TopInfoPanel(
              pageNumber: pageNumber,
              metadata: metadata,
              isDarkModeToggle: isDarkModeToggle,
              isDarkMode: isDarkMode,
            ),
            _BottomInfoPanel(pageNumber: pageNumber, metadata: metadata),
          ],
        ),
      ),
    );
  }
}

class _TopInfoPanel extends StatelessWidget {
  final int pageNumber;
  final _PageMetadata metadata;
  final void Function()? isDarkModeToggle;
  final bool isDarkMode;

  const _TopInfoPanel({
    required this.pageNumber,
    required this.metadata,
    required this.isDarkModeToggle,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.45)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Row(
            children: [
              _IconBtn(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => Navigator.pop(context),
              ),
              _VDivider(),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        metadata.surahName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 21.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'الجزء ${_arabicNumber(metadata.juzNumber)}',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.65),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              _PageSideIndicator(isRightPage: metadata.isRightPage),
              _VDivider(),
              _IconBtn(
                icon: isDarkMode
                    ? Icons.wb_sunny_rounded
                    : Icons.nightlight_round,
                onTap: isDarkModeToggle ?? () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.7,
      height: 28.h,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      color: AppColors.primary.withValues(alpha: 0.45),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.40),
            width: 0.5,
          ),
        ),
        child: Icon(icon, color: AppColors.primary, size: 18.sp),
      ),
    );
  }
}

class _BottomInfoPanel extends StatelessWidget {
  final int pageNumber;
  final _PageMetadata metadata;

  const _BottomInfoPanel({required this.pageNumber, required this.metadata});

  @override
  Widget build(BuildContext context) {
    final hizbText = metadata.hizbPart.isEmpty
        ? 'الحزب ${_arabicNumber(metadata.hizbNumber)}'
        : '${metadata.hizbPart} ${_arabicNumber(metadata.hizbNumber)}';

    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.45)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoText(label: 'الصفحة', value: _arabicNumber(pageNumber)),
                _InfoText(label: 'الحزب', value: hizbText),
                _InfoText(
                  label: 'السورة',
                  value: metadata
                      .surahName, // 3. تصحيح بسيط: عرض اسم السورة هنا بدلاً من طول الاسم
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PageSideIndicator extends StatelessWidget {
  final bool isRightPage;

  const _PageSideIndicator({required this.isRightPage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72.w,
      child: Column(
        children: [
          SizedBox(
            height: 42.h,
            child: Row(
              children: [
                _MiniPage(isActive: !isRightPage),
                SizedBox(width: 4.w),
                _MiniPage(isActive: isRightPage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniPage extends StatelessWidget {
  final bool isActive;

  const _MiniPage({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary
              : const Color(0xffFFF8E5).withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: AppColors.primary),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < 3; i++)
                Container(
                  height: 1.5,
                  width: double.infinity,
                  color: isActive
                      ? AppColors.background.withValues(alpha: 0.8)
                      : AppColors.primary.withValues(alpha: 0.55),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  final String label;
  final String value;

  const _InfoText({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

String _arabicNumber(int number) {
  const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  return number
      .toString()
      .split('')
      .map((digit) => arabicDigits[int.parse(digit)])
      .join();
}
