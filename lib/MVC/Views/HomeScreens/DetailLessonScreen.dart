import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/Components/resourceComponent/lessionVideoPlayer.dart';
import 'package:reclaim/MVC/Models/lessionModel.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class Detaillessonscreen extends StatelessWidget {
  const Detaillessonscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LessonModel lesson = Get.arguments;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicWhite,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Reclaimcolors.BlueSecondary, Color(0xffffffff)],
                stops: [0, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Reclaimcolors.BasicBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SpringWidget(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(ReclaimIcon.Back),
                        ),
                        const Spacer(),
                        Text(
                          "Detail Lessons",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Reclaimcolors.BasicWhite,
                            fontSize: 22.sp,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),

                // Lesson Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            lesson.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),

                          // Show video if present, otherwise show image
                          if (lesson.video.isNotEmpty)
                            LessonVideoPlayer(videoUrl: lesson.video)
                          else
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "https://reclaim.hboxdigital.website${lesson.avatar}",
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Icon(Icons.broken_image,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),

                          const SizedBox(height: 20),
                          Text(
                            lesson.description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
