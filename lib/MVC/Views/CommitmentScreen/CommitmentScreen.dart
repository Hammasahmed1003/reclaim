import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/Commitments/ComitmentsController.dart';
import 'package:reclaim/MVC/Views/CommunityScrens/FullFilledScreen.dart';
import 'package:reclaim/MVC/Views/CommunityScrens/InProgressScreen.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class Commitmentscreen extends StatelessWidget {
  const Commitmentscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Comitmentscontroller controller = Get.put(Comitmentscontroller());

    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: const  SystemUiOverlayStyle(
         statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicWhite,
      ),
      
      child:  Scaffold(
        floatingActionButton:  FloatingActionButton(
          child:   Icon(Icons.add, 
          color: Reclaimcolors.BasicBlue,
          size: 25,
          ),
          backgroundColor: Reclaimcolors.BlueSecondary,

          onPressed: (){
Get.toNamed(GetRouteNames.Addcommitments);
        }),
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
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: const BoxDecoration(
                  color:  Reclaimcolors.BasicBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    
                  ),
                ),
                child: Center(
                  child:Row(
  children: [
    SpringWidget(
      onTap: (){
        Get.back();
      },
      child: SvgPicture.asset(ReclaimIcon.Back)),
  const  Spacer(),
    Text(
      "Commitments",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Reclaimcolors.BasicWhite,
        fontSize: 22.sp,
      ),
    ),
  const  Spacer(), 
  ],
),

                ) ,
                ),

                 Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTab("In Progress", 0, controller),
                    _buildTab("Fulfilled", 1, controller),
                  ],
                ),
              ),

              // Tab Content
              Expanded(
                child: Obx(() {
                  return controller.selectedTabIndex.value == 0
                      ? const InProgressScreen()
                      : const FulfilledScreen();
                }),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}


Widget _buildTab(String title, int index, Comitmentscontroller controller) {
    bool isSelected = controller.selectedTabIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Container(
        width: 140.w,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Reclaimcolors.DisabledBlue : Reclaimcolors.DisabledBlue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Reclaimcolors.BasicBlue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
