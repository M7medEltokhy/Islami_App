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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Hadith ${widget.index}"),
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
                  child: FutureBuilder<String>(
                    future: _hadithFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Could not load hadith',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        child: Text(
                          snapshot.data ?? '',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 20.sp,
                            wordSpacing: 2.w,
                            height: 2.h,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
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
