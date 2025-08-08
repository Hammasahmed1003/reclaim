import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/HomeComponents/DailyProgressCompo.dart';
import 'package:reclaim/Components/HomeComponents/weekLessonCompo.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/EveningRecollectControllers/EveningRecollectController.dart';
import 'package:reclaim/MVC/Controllers/HomeControllers/HomeController.dart';
import 'package:reclaim/MVC/Views/HomeScreens/CustomDrawerScreen.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appConstants/ReclaimImages.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

// class Homescreen extends StatefulWidget {
//   const Homescreen({super.key});

//   @override
//   State<Homescreen> createState() => _HomescreenState();
// }

// class _HomescreenState extends State<Homescreen>
//     with SingleTickerProviderStateMixin {
//   final controller = Get.put(HomeController());

//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     )..repeat(reverse: true);

//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await Future.delayed(const Duration(milliseconds: 400));
//       // controller.showTutorial(context);
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//           statusBarColor: Reclaimcolors.BlueSecondary),
//       child: Scaffold(
//         drawer: const CustomDrawer(),
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Reclaimcolors.BlueSecondary, Color(0xffffffff)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: SafeArea(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: ConstrainedBox(
//                     constraints:
//                         BoxConstraints(minHeight: constraints.maxHeight),
//                     child: IntrinsicHeight(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _topBar(context),
//                           const SizedBox(height: 20),
//                           // SizedBox(
//                           //   height: 180,
//                           //   child: ListView.builder(
//                           //     padding:
//                           //         const EdgeInsets.symmetric(horizontal: 10),
//                           //     itemCount: 3,
//                           //     scrollDirection: Axis.horizontal,
//                           //     itemBuilder: (context, index) {
//                           //       return const DailyProgressComponent(
//                           //         title: "Yesterday",
//                           //         subtitle: "Daily Affirmative",
//                           //         description:
//                           //             "here to place the text for the daily progress of the Task/Goal",
//                           //       );
//                           //     },
//                           //   ),
//                           // ),
//                           Obx(() {
//                             if (controller.isLoading.value) {
//                               return const
//                                   //  Center(
//                                   //     child: CircularProgressIndicator());

//                                   SpinKitDoubleBounce(
//                                 color: Reclaimcolors.BasicWhite,
//                                 size: 20.0,
//                               );
//                             }

//                             final data = controller.affirmation.value;

//                             if (data == null) {
//                               return const SizedBox(); // fallback UI
//                             }

//                             return SizedBox(
//                               height: 200.h,
//                               child: ListView.builder(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 itemCount: 1,
//                                 scrollDirection: Axis.horizontal,
//                                 itemBuilder: (context, index) {
//                                   return DailyProgressComponent(
//                                     title: "Today",
//                                     subtitle: data.title,
//                                     description: data.description,
//                                   );
//                                 },
//                               ),
//                             );
//                           }),
//                           const SizedBox(height: 15),

//                           _sectionTitle("Weekly Lesson"),
//                           const SizedBox(height: 15),
//                           _weeklyLessonSection(),
//                           const SizedBox(height: 20),
//                           // _sectionTitle("Evening Recollect"),
//                           // _eveningRecollectImage(),
//                           // Padding(
//                           //   padding: const EdgeInsets.symmetric(horizontal: 10),
//                           //   child: _bouncingButton(),
//                           // ),
//                           // Obx(() {
//                           //   return controller.showEveningButton.value
//                           //       ? Padding(
//                           //           padding: const EdgeInsets.symmetric(
//                           //               horizontal: 10),
//                           //           child: _bouncingButton(controller),
//                           //         )
//                           //       : const SizedBox.shrink();
//                           // }),
//                           Obx(
//                             () => controller.showEveningButton.value
//                                 ? Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10),
//                                     child: _bouncingButton(controller),
//                                   )
//                                 : const SizedBox.shrink(),
//                           ),

//                           const SizedBox(height: 15),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _topBar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           InkWell(
//             // key: controller.keyFeature1,
//             onTap: () => Scaffold.of(context).openDrawer(),
//             child: SvgPicture.asset(ReclaimIcon.myAccount),
//           ),
//           SvgPicture.asset(ReclaimIcon.ReclaimIcons),
//           SpringWidget(
//             // key: controller.keyFeature2,
//             onTap: () => Get.toNamed(GetRouteNames.Notificationscreen),
//             child: SvgPicture.asset(ReclaimIcon.Notification),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionTitle(String title) => Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Text(
//           title,
//           style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//               color: Reclaimcolors.BasicBlack),
//         ),
//       );

//   // Widget _weeklyLessonSection() {
//   //   return SizedBox(
//   //     height: 300,
//   //     child: ListView.builder(
//   //       padding: const EdgeInsets.symmetric(horizontal: 10),
//   //       scrollDirection: Axis.horizontal,
//   //       itemCount: 1,
//   //       itemBuilder: (context, index) => SizedBox(
//   //         width: 250,
//   //         child: SpringWidget(
//   //           key: controller.keyFeature3,
//   //           onTap: () => Get.toNamed(GetRouteNames.Detaillessonscreen),
//   //           child: WeekLessonComponent(
//   //             imageUrl:
//   //                 "https://images.unsplash.com/photo-1621873493031-d871c4e49d61?...",
//   //             description: "Cause It's Bad For Mental Health too",
//   //             title: "Say No to Porn",
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

//   Widget _weeklyLessonSection() {
//     return Obx(() {
//       final savedLessons = controller.savedLessons;

//       if (controller.isSavedLoading.value) {
//         return const Center(
//           child: SpinKitDoubleBounce(
//             color: Reclaimcolors.BasicWhite,
//             size: 20.0,
//           ),
//         );
//       }

//       if (savedLessons.isEmpty) {
//         return const Center(child: Text("No saved lessons yet"));
//       }

//       return SizedBox(
//         height: 300,
//         child: ListView.builder(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           scrollDirection: Axis.horizontal,
//           itemCount: savedLessons.length,
//           itemBuilder: (context, index) {
//             final lesson = savedLessons[index];
//             return SizedBox(
//               // width: 250,
//               child: SpringWidget(
//                 // key: controller.keyFeature3,
//                 onTap: () => Get.toNamed(
//                   GetRouteNames.Detaillessonscreen,
//                   arguments: lesson,
//                 ),
//                 child: WeekLessonComponent(
//                   imageUrl:
//                       "https://reclaim.hboxdigital.website${lesson.avatar}",
//                   description: lesson.description,
//                   title: lesson.title,
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     });
//   }

//   Widget _eveningRecollectImage() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(12), topRight: Radius.circular(12)),
//         child: Image.asset(Reclaimimages.alertImage,
//             width: double.infinity, fit: BoxFit.cover),
//       ),
//     );
//   }

//   Widget _bouncingButton(HomeController controller) {
//     return Container(
//       alignment: Alignment.center,
//       margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             // onPressed: () {
//             //   // ✅ Perform your evening action
//             //   controller.markEveningButtonShown();
//             //   // e.g., navigate to recollect screen
//             // },
// //             onPressed: () async {
// //   final success = await yourApiCall(); // Replace with actual POST API call
// //   if (success) {
// //     controller.markEveningSubmitted();
// //     // Show success snackbar if needed
// //   }
// // },
//             onPressed: () {
//               // Get.toNamed(page)
//               Get.toNamed(GetRouteNames.Eveningrecollect);
//             },
//             style: ElevatedButton.styleFrom(
//               foregroundColor: Reclaimcolors.BasicBlue,
//               backgroundColor: Reclaimcolors.BasicBlue,
//               side: const BorderSide(color: Reclaimcolors.BasicBlue),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               elevation: 4,
//             ),
//             child: const Text(
//               ' Evening Recollect',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Reclaimcolors.BasicWhite,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// new code with single Loader(
// )
//
// ,

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(HomeController());
  final Eveningcontroller = Get.put(EveningRecollectController());

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  bool _isDataLoading =
      true; // This is the new loading flag for managing overall state

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 400));
      // Start loading data
      await _loadData();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // This method will load both the data and update the loading flag
  Future<void> _loadData() async {
    setState(() {
      _isDataLoading = true;
    });

    // Start loading saved lessons and affirmation
    await controller.fetchSavedLessons();
    await controller.fetchAffirmation();

    // Once both APIs are done, stop the loading state
    setState(() {
      _isDataLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Reclaimcolors.BlueSecondary),
      child: Scaffold(
        drawer: const CustomDrawer(),
        body: _isDataLoading
            ? _buildLoadingScreen() // Show the loader while both APIs are in progress
            : Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Reclaimcolors.BlueSecondary, Color(0xffffffff)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _topBar(context),
                                const SizedBox(height: 20),
                                Obx(() {
                                  if (controller.isLoading.value) {
                                    return const SpinKitDoubleBounce(
                                      color: Reclaimcolors.BasicWhite,
                                      size: 20.0,
                                    );
                                  }
                                  final data = controller.affirmation.value;
                                  if (data == null) {
                                    return const SizedBox(); // fallback UI
                                  }
                                  return SizedBox(
                                    height: 250.h,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      itemCount: 1,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return DailyProgressComponent(
                                          title: "Today",
                                          subtitle: data.title,
                                          description: data.description,
                                        );
                                      },
                                    ),
                                  );
                                }),
                                const SizedBox(height: 15),
                                _sectionTitle("Weekly Lesson"),
                                const SizedBox(height: 15),
                                _weeklyLessonSection(),
                                const SizedBox(height: 20),
                                Obx(
                                  () =>
                                      Eveningcontroller.showEveningButton.value
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: _bouncingButton(
                                                  Eveningcontroller),
                                            )
                                          : const SizedBox.shrink(),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitDoubleBounce(
              color: Reclaimcolors.BasicBlue,
              size: 30.0,
            ),
            SizedBox(height: 10.h),
            Text(
              "Preparing Home Screen.",
              style: TextStyle(
                fontSize: 18.sp,
                color: Reclaimcolors.BasicBlue,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: SvgPicture.asset(ReclaimIcon.myAccount),
          ),
          // SvgPicture.asset(ReclaimIcon.ReclaimIcons),
          SpringWidget(
            onTap: () => Get.toNamed(GetRouteNames.Notificationscreen),
            child: SvgPicture.asset(ReclaimIcon.Notification),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Reclaimcolors.BasicBlack),
        ),
      );

  Widget _weeklyLessonSection() {
    return Obx(() {
      final savedLessons = controller.savedLessons;

      if (controller.isSavedLoading.value) {
        return const Center(
          child: SpinKitDoubleBounce(
            color: Reclaimcolors.BasicWhite,
            size: 20.0,
          ),
        );
      }

      if (savedLessons.isEmpty) {
        return const Center(child: Text("No saved lessons yet"));
      }

      return SizedBox(
        height: 300,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemCount: savedLessons.length,
          itemBuilder: (context, index) {
            final lesson = savedLessons[index];
            return SizedBox(
              child: SpringWidget(
                onTap: () => Get.toNamed(
                  GetRouteNames.Detaillessonscreen,
                  arguments: lesson,
                ),
                child: WeekLessonComponent(
                  imageUrl:
                      "https://reclaim.hboxdigital.website${lesson.avatar}",
                  description: lesson.description,
                  title: lesson.title,
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _bouncingButton(EveningRecollectController controller) {
    final isAvailable = controller.showEveningButton.value;

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isAvailable
                ? () {
                    Get.toNamed(GetRouteNames.Eveningrecollect);
                  }
                : null, // Disable when not available
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor:
                  isAvailable ? Reclaimcolors.BasicBlue : Colors.grey.shade400,
              disabledBackgroundColor: Colors.grey.shade400,
              side: BorderSide(
                color: isAvailable
                    ? Reclaimcolors.BasicBlue
                    : Colors.grey.shade400,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: isAvailable ? 4 : 0,
            ),
            child: Text(
              'Evening Recollect',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isAvailable
                    ? Reclaimcolors.BasicWhite
                    : Colors.grey.shade200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
