import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/features/tabs/hadithTab/widgets/hadith_details.dart';

class HadithCard extends StatefulWidget {
  final int index;
  const HadithCard({super.key, required this.index});

  @override
  State<HadithCard> createState() => _HadithCardState();
}

class _HadithCardState extends State<HadithCard> {
  late final Future<String> _hadithFuture;

  Future<String> hadithText() async {
    return rootBundle.loadString("assets/files/Hadeeth/h${widget.index}.txt");
  }

  @override
  void initState() {
    super.initState();
    _hadithFuture = hadithText();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HadithDetails(index: widget.index),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xffE2BE7F),
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage('assets/images/hadith_bg.png'),
            fit: BoxFit.fitWidth,
          ),
        ),

        child: FutureBuilder<String>(
          future: _hadithFuture,
          builder: (context, hadith) {
            return SingleChildScrollView(
              child: Text(
                hadith.data ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  height: 1.8.h,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
