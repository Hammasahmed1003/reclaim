// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:reclaim/Components/CommonComponents/LevelProgressCompo.dart';
// import 'package:reclaim/Components/CommonComponents/RankComponent.dart';
// import 'package:reclaim/Components/SpringWidget.dart';
// import 'package:reclaim/appConstants/ReclaimColors.dart';
// import 'package:reclaim/appConstants/ReclaimIcons.dart';

// class ProgressScreen extends StatelessWidget {
//   const ProgressScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//         statusBarColor: Reclaimcolors.BasicBlue,
//         systemNavigationBarColor: Reclaimcolors.BasicBlue,
//       ),
//       child: Scaffold(
//         backgroundColor: Reclaimcolors.BlueSecondary,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 /// 👇 Wrap in SizedBox to ensure a visible height
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                   decoration: const BoxDecoration(
//                     color: Reclaimcolors.BasicBlue,
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(20),
//                       bottomRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: Center(
//                     child: Row(
//                       children: [
//                         // SpringWidget(
//                         //   onTap: (){
//                         //     Get.back();
//                         //   },
//                         //   child: SvgPicture.asset(ReclaimIcon.Back)),
//                         const Spacer(),
//                         Text(
//                           "Progress",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: Reclaimcolors.BasicWhite,
//                             fontSize: 22.sp,
//                           ),
//                         ),
//                         const Spacer(),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 430,
//                   // height: MediaQuery.of(context).size.height, // Forces full height
//                   child: const LevelProgressTracker(
//                     totalLevels: 5,
//                     currentLevel: 2,
//                   ),
//                 ),
// //
//               ],
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
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/CommonComponents/LevelProgressCompo.dart';
import 'package:reclaim/MVC/Controllers/progressController/progressController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';

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

              // Body
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
