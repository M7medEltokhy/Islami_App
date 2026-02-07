import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/features/tabs/quranTab/data/sura_model.dart';
import 'package:islami/features/tabs/quranTab/data/sura_name.dart';
import 'package:islami/features/tabs/quranTab/widgets/most_recently.dart';
import 'package:islami/features/tabs/quranTab/widgets/sura_search.dart';
import 'package:islami/features/tabs/quranTab/widgets/suras_list.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 205.h),
          SuraSearch(onSearch: searchSura),
          SizedBox(height: 20.h),
          MostRecently(),
          SizedBox(height: 10.h),
          Expanded(child: SurasList(suras: filteredSuras)),
        ],
      ),
    );
  }
}
