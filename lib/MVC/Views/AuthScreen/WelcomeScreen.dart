import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/CommonComponents/PanicDailog.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appServices/getRouteNames.dart';
// import 'welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicWhite,
        systemNavigationBarColor: Reclaimcolors.BasicWhite
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: 196.w,
                height: 196.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color:Colors.transparent
                ),
                padding: const EdgeInsets.all(20),
                child:
                 SvgPicture.asset(
                  ReclaimIcon.NewLOGO, // Replace with your actual SVG path
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
          const  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child:  Text(
                "Welcome to Your Journey. Your commitment to change is evident. You've already shown determination by taking the first steps toward recovery. Focus on building consistent habits and strengthening your resilience. We’re here to guide and support you through every challenge.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ),
            const Spacer(),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            //   child: SizedBox(
            //     width: double.infinity,
            //     height: 50,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         // Navigation logic here
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: const Color(0xFF3B74DA),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(30),
            //         ),
            //       ),
            //       child: const Text(
            //         "Continue",
            //         style: TextStyle(fontSize: 16),
            //       ),
            //     ),
            //   ),
            // )
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
               child: Container(
                  width: 380.w,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: (){
                      Get.toNamed(GetRouteNames.WelcomeScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor : Reclaimcolors.BasicBlue,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Reclaimcolors.BasicWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
             ),
          ],
        ),
      ),
    );
  }
}
