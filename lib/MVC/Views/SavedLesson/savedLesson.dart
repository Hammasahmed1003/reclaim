// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:reclaim/Components/SpringWidget.dart';
// import 'package:reclaim/appConstants/ReclaimColors.dart';
// import 'package:reclaim/appConstants/ReclaimIcons.dart';

// class Savedlesson extends StatelessWidget {
//   final List<Map<String, dynamic>> lessons = List.generate(
//     6,
//     (index) => {
//       'image': 'https://plus.unsplash.com/premium_photo-1664034645114-7daec1527a05?q=80&w=1925&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Replace with actual image URL or asset
//       'title': 'Lorem Ipsum',
//       'subtitle': 'Lorem ipsum dolor sit amet elit.',
//     },
//   );
//    Savedlesson({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  AnnotatedRegion<SystemUiOverlayStyle>(
//        value: const   SystemUiOverlayStyle(
//         statusBarColor: Reclaimcolors.BasicBlue,
//         systemNavigationBarColor: Reclaimcolors.BasicWhite,

//       ),
//       child: SafeArea(
//         child: Scaffold(
//           body: Container(
//                decoration:const BoxDecoration(
//           gradient:  LinearGradient(
//             colors: [Reclaimcolors.BlueSecondary, const Color(0xffffffff)],
//             stops: const [0, 1],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                         decoration: const BoxDecoration(
//                           color:  Reclaimcolors.BasicBlue,
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(20),
//                             bottomRight: Radius.circular(20),

//                           ),
//                         ),
//                         child: Center(
//                           child:Row(
//                   children: [
//                     SpringWidget(
//                       onTap: (){
//                 Get.back();
//                       },
//                       child: SvgPicture.asset(ReclaimIcon.Back)),
//                   const  Spacer(),
//                     Text(
//                       "Saved Lessons",
//                       style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Reclaimcolors.BasicWhite,
//                 fontSize: 22.sp,
//                       ),
//                     ),
//                   const  Spacer(),
//                   ],
//                 ),

//                         ) ,
//                         ),
//                         SizedBox(height: 20.h,),
//               Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Text("Saved Lessons",
//       style: TextStyle(fontWeight: FontWeight.bold,
//       color: Reclaimcolors.BasicBlack,
//       fontSize: 22.sp
//       ),
//       ),
//     ),
//   ],
// ),
//                         SizedBox(height: 20.h,),

//                      Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: GridView.builder(
//           itemCount: lessons.length,
//           shrinkWrap: true,
//           primary: false,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//             childAspectRatio: 0.8, // Adjust aspect ratio to fit content properly
//           ),
//           itemBuilder: (context, index) {
//             return Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                     child: Image.network(
//                       lessons[index]['image'],
//                       height: 100,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Expanded( // 🔥 Fix: Prevents overflow
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             lessons[index]['title'],
//                             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             lessons[index]['subtitle'],
//                             style: TextStyle(fontSize: 12, color: Colors.grey),
//                           ),
//                           Spacer(), // Pushes the icon to the bottom
//                           Align(
//                             alignment: Alignment.bottomRight,
//                             child: Padding(
//                               padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
//                               child: CircleAvatar(
//                                 radius: 15,
//                                 backgroundColor: Reclaimcolors.BlueSecondary,
//                                 child: SvgPicture.asset(ReclaimIcon.BookMarked,
//                                 color: Reclaimcolors.BasicBlue,
//                                 width: 20,
//                                 height: 20,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/resourceController/saveLessonController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class Savedlesson extends StatelessWidget {
  Savedlesson({super.key});

  final SavedLessonController controller = Get.put(SavedLessonController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicWhite,
      ),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Reclaimcolors.BlueSecondary, Color(0xffffffff)],
                stops: [0, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Reclaimcolors.BasicBlue,
                  ),
                );
              } else if (controller.savedLessons.isEmpty) {
                return Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 50),
                    Center(
                      child: Text(
                        "No saved lessons yet.",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeader(),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView.builder(
                          itemCount: controller.savedLessons.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) {
                            final lesson = controller.savedLessons[index];
                            final String imageUrl =
                                "https://reclaim.hboxdigital.website${lesson.avatar}";

                            return SpringWidget(
                              onTap: () => Get.toNamed(
                                GetRouteNames.Detaillessonscreen,
                                arguments: lesson,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        imageUrl,
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                          height: 100,
                                          color: Colors.grey[200],
                                          alignment: Alignment.center,
                                          child: const Icon(
                                              Icons.image_not_supported),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              lesson.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              lesson.description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const Spacer(),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0, right: 8.0),
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor: Reclaimcolors
                                                      .BlueSecondary,
                                                  child: SvgPicture.asset(
                                                    ReclaimIcon.saved,
                                                    color:
                                                        Reclaimcolors.BasicBlue,
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
              "Saved Lessons",
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
    );
  }
}
