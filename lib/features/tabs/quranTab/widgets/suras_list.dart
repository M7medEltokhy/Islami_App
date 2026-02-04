import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SurasList extends StatelessWidget {
  const SurasList({super.key});

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
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),
                leading: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset('assets/images/img_sur_number_frame.png'),
                    Text(
                      "1",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                title: Text(
                  "Al-Fatiha",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "7 Verses",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                trailing: Text(
                  "الفاتحه",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(indent: 55.w, endIndent: 55.w);
            },
            itemCount: 15,
          ),
        ),
      ],
    );
  }
}
