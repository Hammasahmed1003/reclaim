import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/CommonComponents/LevelProgressCompo.dart';
import 'package:reclaim/MVC/Controllers/progressController/progressController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appConstants/ReclaimImages.dart';

// class ProgressScreen extends StatelessWidget {
//   const ProgressScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ProgressController controller = Get.put(ProgressController());

//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//         statusBarColor: Reclaimcolors.BasicBlue,
//         systemNavigationBarColor: Reclaimcolors.BasicBlue,
//       ),
//       child: Scaffold(
//         backgroundColor: Reclaimcolors.BlueSecondary,
//         body: SafeArea(
//           child: Column(
//             children: [
//               // Header
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                 decoration: const BoxDecoration(
//                   color: Reclaimcolors.BasicBlue,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Center(
//                   child: Row(
//                     children: [
//                       const Spacer(),
//                       Text(
//                         "Progress",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           color: Reclaimcolors.BasicWhite,
//                           fontSize: 22.sp,
//                         ),
//                       ),
//                       const Spacer(),
//                     ],
//                   ),
//                 ),
//               ),

//               // Body
//               Expanded(
//                 child: Obx(() {
//                   if (controller.isLoading.value) {
//                     return const Center(
//                         child: SpinKitDoubleBounce(
//                       color: Reclaimcolors.BasicBlue,
//                       size: 50.0,
//                     ));
//                   }

//                   return AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 500),
//                     transitionBuilder: (child, animation) =>
//                         FadeTransition(opacity: animation, child: child),
//                     child: LevelProgressTracker(
//                       key: ValueKey(controller.currentLevel.value),
//                       totalLevels: controller.totalLevels.value,
//                       currentLevel: controller.currentLevel.value,
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProgressController controller = Get.put(ProgressController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicBlue,
      ),
      child: Scaffold(
        backgroundColor: Reclaimcolors.BlueSecondary,
        body: SafeArea(
          child: Column(
            children: [
              // Header
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
                        "Progress",
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

              // Streak Days Section
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Reclaimcolors.BasicBlue.withOpacity(
                        0.1), // Slight background color for distinction
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      // Fire Icon
                      Image.asset(
                        Reclaimimages.fire,
                        width: 60,
                        height: 50,
                      ),
                      const SizedBox(
                          width: 12), // Added more space between icon and text

                      // Streak Text Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Streak",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Reclaimcolors.BasicBlue,
                              fontSize: 22.sp,
                            ),
                          ),
                          const SizedBox(
                              height:
                                  6), // Added space between Streak label and days
                          Text(
                            "${controller.streak.value} Streak Days",
                            style: TextStyle(
                              color: Reclaimcolors.DisableText,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                              height:
                                  6), // Space before the 'longest streak' message

                          // Text(
                          //   "",
                          //   style: TextStyle(
                          //     color: Reclaimcolors.BasicWhite,
                          //     fontSize: 14.sp,
                          //     fontStyle: FontStyle
                          //         .italic, // To differentiate the message
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Body (Existing Level Progress)
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                        child: SpinKitDoubleBounce(
                      color: Reclaimcolors.BasicBlue,
                      size: 50.0,
                    ));
                  }

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: LevelProgressTracker(
                      key: ValueKey(controller.currentLevel.value),
                      totalLevels: controller.totalLevels.value,
                      currentLevel: controller.currentLevel.value,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
