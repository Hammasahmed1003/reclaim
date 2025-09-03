import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:reclaim/Components/CommonComponents/PanicDailog.dart';
import 'package:reclaim/MVC/Controllers/BottomNavController/BottomNavController.dart';
import 'package:reclaim/MVC/Views/CommunityScrens/CommunityScreen.dart';
import 'package:reclaim/MVC/Views/HomeScreens/HomeScreen.dart';
import 'package:reclaim/MVC/Views/ProgressScreens/progresScreen.dart';
import 'package:reclaim/MVC/Views/ResourceScreen/ResourceScreen.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class BottomnavbarView extends StatelessWidget {
  final Bottomnavcontroller controller = Get.put(Bottomnavcontroller());

  final List<Widget> _pages = [
  const  Homescreen(),
  const  ProgressScreen(),
    //  Homescreen(),
    ResourceScreen(),
    const CommunityScreen()

    // const Savingscreen(),
    // const Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: SafeArea(
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     panicDailog(context);
          //     // Define action here
          //   },
          //   backgroundColor: Reclaimcolors.BasicBlue,
          //   shape: const CircleBorder(),
          //   child: SvgPicture.asset(
          //     ReclaimIcon.NewLOGO, // Your custom SVG icon
          //     // height: 30,
          //     // width: 30,
          //     // color: Colors.white,
          //   ),
          // ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await controller.fetchPanicTask(context);
            },
            backgroundColor: Reclaimcolors.BasicBlue,
            shape: const CircleBorder(),
            child: SvgPicture.asset(
              ReclaimIcon.NewLOGO,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
            
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          body: Obx(() => _pages[controller.currentIndex.value]),
          bottomNavigationBar: Obx(
            () => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GNav(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                gap: 7,
                backgroundColor: Colors.white,
                color: Colors.grey,
                activeColor: Reclaimcolors.BasicBlack,
                tabBackgroundColor: Colors.grey.shade200,
                padding: const EdgeInsets.all(16),
                selectedIndex: controller.currentIndex.value,
                onTabChange: (index) => controller.changeIndex(index),
                tabs: [
                  GButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    backgroundColor: Reclaimcolors.BlueSecondary,
                    icon: Icons.home,
                    iconColor: Colors.grey,
                    text: 'Home'.tr,
                    leading: SvgPicture.asset(
                      controller.currentIndex.value == 0
                          ? ReclaimIcon.homeIcon
                          : ReclaimIcon.homeIcon,
                      // height: 20,
                      // width: 20,
                    ),
                  ),
                  GButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    backgroundColor: Reclaimcolors.BlueSecondary,
                    icon: Icons.savings,
                    text: 'Progress'.tr,
                    leading: SvgPicture.asset(
                      controller.currentIndex.value == 1
                          ? ReclaimIcon.progressIcon
                          : ReclaimIcon.progressIcon,
                      height: 20,
                      width: 20,
                    ),
                  ),
            
                  GButton(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    backgroundColor: Reclaimcolors.BlueSecondary,
                    icon: Icons.person,
                    text: 'Resources'.tr,
                    leading: SvgPicture.asset(
                      controller.currentIndex.value == 2
                          ? ReclaimIcon.resources
                          : ReclaimIcon.resources,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  // GButton(
                  //   padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            
                  //   backgroundColor: Reclaimcolors.BlueSecondary,
                  //   icon: Icons.person,
                  //   text: 'Community'.tr,
                  //   leading: SvgPicture.asset(
                  //     controller.currentIndex.value == 2
                  //      ? ReclaimIcon.community
                  //         : ReclaimIcon.community,
                  //     height: 20,
                  //     width: 20,
                  //   ),
                  // ),
            
                  GButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    backgroundColor: Reclaimcolors.BlueSecondary,
                    icon: Icons.person,
                    text: 'Community'.tr,
                    leading: SvgPicture.asset(
                      controller.currentIndex.value == 3
                          ? ReclaimIcon.community
                          : ReclaimIcon.community,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
