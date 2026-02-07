import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_colors.dart';

class HadithDetails extends StatefulWidget {
  final int index;

  const HadithDetails({super.key, required this.index});

  @override
  State<HadithDetails> createState() => _HadithDetailsState();
}

class _HadithDetailsState extends State<HadithDetails> {
  late String hadithData;

  Future<String> hadithText() async {
    hadithData = await rootBundle.loadString(
      "assets/files/Hadeeth/h${widget.index - 1}.txt",
    );
    setState(() {});
    return hadithData;
  }

  @override
  void initState() {
    hadithText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Hadith ${widget.index - 1}"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(child: Image.asset("assets/images/quran_sura_details.png")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      hadithData,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20.sp,
                        wordSpacing: 2.w,
                        height: 2.h,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
