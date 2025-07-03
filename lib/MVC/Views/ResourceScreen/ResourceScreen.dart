import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/Components/resourceComponent/resourceComponent.dart';
import 'package:reclaim/MVC/Controllers/resourceController/lessonController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:reclaim/appServices/getRouteNames.dart';



class ResourceScreen extends StatelessWidget {
  ResourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LessonController lessonController = Get.put(LessonController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicBlue,
      ),
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Reclaimcolors.BlueSecondary, const Color(0xffffffff)],
              stops: [0, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
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
                        const Spacer(),
                        Text(
                          "Lessons",
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
                SizedBox(height: 10.h),

                // Loading Indicator with Text
                Obx(() {
                  if (lessonController.isLoading.value) {
                    return Scaffold(
                      body: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SpinKitDoubleBounce(
                            color: Reclaimcolors.BasicBlue,
                            size: 20.0,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Loading...",
                            style: TextStyle(
                              color: Reclaimcolors.BasicBlue,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // No Data Placeholder
                  if (lessonController.lessons.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          "No lessons available.",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Reclaimcolors.BasicBlue,
                          ),
                        ),
                      ),
                    );
                  }

                  // Lessons List
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lessonController.lessons.length,
                    itemBuilder: (context, index) {
                      final item = lessonController.lessons[index];

                      return Obx(() => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: ResourcesComponent(
                              imageUrl:
                                  "https://reclaim.hboxdigital.website${item.avatar}",
                              title: item.title,
                              description: item.description,
                              isBookmarked: item.isSave.value == 1,
                              onTap: () {
                                Get.toNamed(GetRouteNames.Detaillessonscreen,
                                    arguments: item);
                              },
                              onBookmarkTap: () async {
                                await lessonController.saveLesson(
                                    item.id, item);
                              },
                            ),
                          ));
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
