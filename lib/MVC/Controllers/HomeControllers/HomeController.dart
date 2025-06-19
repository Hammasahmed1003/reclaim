


import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';





class HomeController extends GetxController {
  final GlobalKey keyFeature1 = GlobalKey();
  final GlobalKey keyFeature2 = GlobalKey();
  final GlobalKey keyFeature3 = GlobalKey();

  late List<TargetFocus> targets;

  @override
  void onReady() {
    super.onReady();

    // Delay after the first frame is drawn
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 400));
      if (Get.context != null) {
        showTutorial(Get.context!);
      }
    });
  }

  void showTutorial(BuildContext context) {
  final targets = [
    TargetFocus(
      keyTarget: keyFeature1,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          child:
          //  Text("sdads"),
           tutorialBox("Tap here to open your drawer"),
        )
      ],
    ),
    TargetFocus(
      keyTarget: keyFeature2,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          child: tutorialBox("This shows your notifications"),
        )
      ],
    ),
    TargetFocus(
      keyTarget: keyFeature3,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          child: tutorialBox("Check your weekly lesson"),
        )
      ],
    ),
  ];

  TutorialCoachMark(
    targets: targets,
    colorShadow: Reclaimcolors.BasicBlack,
    textSkip: "SKIP",
    paddingFocus: 10,
    // onSkip: () => print("Tutorial skipped"),
    onFinish: () => print("Tutorial finished"),
  ).show(context: context);
}

Widget tutorialBox(String text) => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: const TextStyle(color: Colors.black)),
    );


  // Widget tutorialBox(String text) => Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Text(text, style: const TextStyle(color: Colors.black)),
  //     );
}

