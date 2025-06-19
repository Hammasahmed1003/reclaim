import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

void panicDailog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        children: [
          // Blurred Background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur effect
            child: Container(
              color: Reclaimcolors.BlueSecondary.withOpacity(0.9), // Semi-transparent overlay
            ),
          ),
          
          // Cupertino Alert Dialog
          Center(
            child: CupertinoAlertDialog(

              
              content: Column(
                children: [
                  const SizedBox(height: 10),
                  // Icon(
                  //   CupertinoIcons.sportscourt, // Running Icon
                  //   size: 40,
                  //   color: Colors.white,
                  // ),
              
                    Lottie.asset(
              'assets/animations/alertLottie.json',
              width: 70,
              height: 90,
               // Replace with your actual Lottie file path
                        
              
              fit: BoxFit.cover,
                          ),
                  const SizedBox(height: 10),
                  const Text(
                    "Running 2 Minutes",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Reclaimcolors.BasicBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Reclaimcolors.BasicBlack,
                      
                    ),
                  ),
                  const SizedBox(height: 15),
                  CupertinoButton(
                    color: Reclaimcolors.Red,
                    onPressed: () {
                    Get.back();
                      // Navigator.pop(context); // Close dialog
                    },
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        SvgPicture.asset(ReclaimIcon.Done),
                        SizedBox(width: 10.w,),
                        Text("Done", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,

                        ),)
                        ,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
