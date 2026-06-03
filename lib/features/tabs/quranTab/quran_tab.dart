import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/features/tabs/quranTab/data/sura_model.dart';
import 'package:islami/features/tabs/quranTab/data/sura_name.dart';
import 'package:islami/features/tabs/quranTab/widgets/most_recently.dart';
import 'package:islami/features/tabs/quranTab/widgets/sura_details.dart';
import 'package:islami/features/tabs/quranTab/widgets/sura_search.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  List<SuraModel> suras = SuraName.suras;
  List<SuraModel> filteredSuras = [];

  @override
  void initState() {
    super.initState();
    filteredSuras = suras;
  }

  void searchSura(String query) {
    setState(() {
      filteredSuras = suras.where((sura) {
        return sura.nameAr.contains(query) ||
            sura.nameEn.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CustomScrollView(
          slivers: [
            // ── Top spacing ──
            SliverToBoxAdapter(child: SizedBox(height: 150.h)),
            // ── Search ──
            SliverToBoxAdapter(child: SuraSearch(onSearch: searchSura)),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            // ── Most Recently ──
            SliverToBoxAdapter(child: MostRecently()),
            SliverToBoxAdapter(child: SizedBox(height: 10.h)),
            // ── Suras List header ──
            SliverToBoxAdapter(
              child: Text(
                'Suras List',
                style: TextStyle(
                  color: const Color(0xffFEFFE8),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10.h)),
            // ── Suras List ──
            SliverList.separated(
              itemCount: filteredSuras.length,
              itemBuilder: (context, index) {
                final sura = filteredSuras[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SuraDetails(index: sura.index),
                      ),
                    );
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    leading: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Image.asset('assets/images/img_sur_number_frame.png'),
                        Text(
                          '${sura.index}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      sura.nameEn,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${sura.ayatsCount} Verses',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Text(
                      sura.nameAr,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(indent: 55.w, endIndent: 55.w);
              },
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).padding.bottom + 20.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
