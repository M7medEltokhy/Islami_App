import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioCard extends StatefulWidget {
  final String title;

  const RadioCard({super.key, required this.title});

  @override
  State<RadioCard> createState() => _RadioCardState();
}

class _RadioCardState extends State<RadioCard> {
  bool isPlaying = false;
  bool isMuted = false;
  final AudioPlayer player = AudioPlayer();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 141.h,
      width: 390.w,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          image: isPlaying
              ? AssetImage('assets/images/Playing Wave.png')
              : AssetImage('assets/images/Mask group.png'),
          fit: BoxFit.fitWidth,
        ),
        color: const Color(0xFFE8C27D),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 50.w),
              IconButton(
                onPressed: () async {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                  isPlaying
                      ? await player.play(
                          UrlSource(
                            "https://backup.qurango.net/radio/ibrahim_alakdar",
                          ),
                        )
                      : await player.pause();
                },
                icon: Icon(
                  isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isMuted = !isMuted;
                  });
                },
                icon: Icon(
                  isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
