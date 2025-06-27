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

void panicDialog(BuildContext context, Map<String, dynamic> task) {
  final TextEditingController answerController = TextEditingController();

  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Reclaimcolors.BlueSecondary.withOpacity(0.9),
            ),
          ),
          Center(
            child: CupertinoAlertDialog(
              content: Column(
                children: [
                  const SizedBox(height: 10),
                  Lottie.asset(
                    'assets/animations/alertLottie.json',
                    width: 70,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Type: ${task['type']}\nIntensity: ${task['intensity']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Reclaimcolors.BasicBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    task['description'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Reclaimcolors.BasicBlack,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CupertinoTextField(
                    controller: answerController,
                    placeholder: "Your answer here...",
                    maxLines: 3,
                    padding: const EdgeInsets.all(12),
                  ),
                  const SizedBox(height: 15),
                  CupertinoButton(
                    color: Reclaimcolors.Red,
                    onPressed: () {
                      print("User answer: \${answerController.text}");
                      Get.back();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ReclaimIcon.Done),
                        SizedBox(width: 10.w),
                        Text(
                          "Submit",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
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
