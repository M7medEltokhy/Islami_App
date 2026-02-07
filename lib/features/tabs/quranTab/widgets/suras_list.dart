import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/features/tabs/quranTab/data/sura_model.dart';
import 'package:islami/features/tabs/quranTab/widgets/sura_details.dart';

class SurasList extends StatelessWidget {
  final List<SuraModel> suras;
  const SurasList({super.key, required this.suras});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suras List',
          style: TextStyle(
            color: Color(0xffFEFFE8),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: ListView.separated(
            itemCount: suras.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final sura = suras[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SuraDetails(index: index + 1);
                      },
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
                        '${index + 1}',
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${sura.ayatsCount} Verses',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  trailing: Text(
                    sura.nameAr,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(indent: 55.w, endIndent: 55.w);
            },
          ),
        ),
      ],
    );
  }
}
