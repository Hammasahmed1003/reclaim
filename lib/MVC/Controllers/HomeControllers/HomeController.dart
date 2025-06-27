import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reclaim/MVC/Models/affirmativeModel.dart';
import 'package:reclaim/MVC/Models/lessionModel.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:reclaim/appServices/SharedPrefService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeController extends GetxController {
  // final GlobalKey keyFeature1 = GlobalKey();
  // final GlobalKey keyFeature2 = GlobalKey();
  // final GlobalKey keyFeature3 = GlobalKey();
  // final GlobalKey keyFeature4 = GlobalKey();
var isLoading = true.obs;
  var affirmation = Rxn<Affirmation>();
  var savedLessons = <LessonModel>[].obs;
  var isSavedLoading = false.obs;
  late List<TargetFocus> targets;
  // RxBool showEveningButton = false.obs;
  RxBool showEveningButton = false.obs;

  // @override
  // void onReady() {
  //   super.onReady();

  //   // Delay after the first frame is drawn
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await Future.delayed(const Duration(milliseconds: 400));
  //     if (Get.context != null) {
  //       showTutorial(Get.context!);
  //     }
  //   });
  // }

  @override
  void onInit() {
    super.onInit();
    fetchSavedLessons();
    fetchAffirmation();
    _checkEveningButtonVisibility();
  }

  // void showTutorial(BuildContext context) {
  //   final targets = [
  //     TargetFocus(
  //       keyTarget: keyFeature1,
  //       contents: [
  //         TargetContent(
  //           align: ContentAlign.bottom,
  //           child:
  //               //  Text("sdads"),
  //               tutorialBox("Tap here to open your drawer"),
  //         )
  //       ],
  //     ),
  //     TargetFocus(
  //       keyTarget: keyFeature2,
  //       contents: [
  //         TargetContent(
  //           align: ContentAlign.bottom,
  //           child: tutorialBox("This shows your notifications"),
  //         )
  //       ],
  //     ),
  //     TargetFocus(
  //       keyTarget: keyFeature4,
  //       contents: [
  //         TargetContent(
  //           align: ContentAlign.bottom,
  //           child: tutorialBox("Check your weekly lesson"),
  //         )
  //       ],
  //     ),
  //   ];

  //   TutorialCoachMark(
  //     targets: targets,
  //     colorShadow: Reclaimcolors.BasicBlack,
  //     textSkip: "SKIP",
  //     paddingFocus: 10,
  //     // onSkip: () => print("Tutorial skipped"),
  //     onFinish: () => print("Tutorial finished"),
  //   ).show(context: context);
  // }

  // Widget tutorialBox(String text) => Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //           color: Colors.white, borderRadius: BorderRadius.circular(12)),
  //       child: Text(text, style: const TextStyle(color: Colors.black)),
  //     );

  void _checkEveningButtonVisibility() async {
    final now = DateTime.now();
    final prefs = await SharedPreferences.getInstance();

    final alreadySubmitted =
        prefs.getBool("eveningSubmitted_${_todayKey()}") ?? false;

    if (now.hour >= 18 && now.hour <= 23 && !alreadySubmitted) {
      showEveningButton.value = true;
    }
  }

  Future<void> markEveningSubmitted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("eveningSubmitted_${_todayKey()}", true);
    showEveningButton.value = false;
  }

  String _todayKey() {
    final now = DateTime.now();
    return "${now.year}-${now.month}-${now.day}";
  }

  Future<void> fetchSavedLessons() async {
    isSavedLoading.value = true;
    final response = await ApiService().getRequestwithtoken("save-lesson-list");

    if (response != null &&
        response.statusCode == 200 &&
        response.data["error"] == false) {
      final List<dynamic> data = response.data["data"];
      savedLessons.value =
          data.map((item) => LessonModel.fromJson(item['lesson'])).toList();
    }

    isSavedLoading.value = false;
  }

  Future<void> fetchAffirmation() async {
    try {
      final dio = Dio();
      final token = await SharedPrefService.getUserToken();

      final response = await dio.get(
        'https://reclaim.hboxdigital.website/api/daily-affirmation',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['error'] == false) {
        final data = response.data['data'];
        affirmation.value = Affirmation.fromJson(data);
      }
    } catch (e) {
      print("Affirmation API error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
