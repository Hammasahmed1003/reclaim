import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reclaim/MVC/Models/lessionModel.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:reclaim/appServices/SharedPrefService.dart';

class LessonController extends GetxController {
  RxList<LessonModel> lessons = <LessonModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLessons();
  }

  Future<void> fetchLessons() async {
    isLoading.value = true;

    final response = await ApiService().getRequestwithtoken(
      "lessons",
    );

    if (response != null &&
        response.statusCode == 200 &&
        response.data["success"] == true) {
      final List<dynamic> data = response.data["data"];
      lessons.value = data.map((json) => LessonModel.fromJson(json)).toList();
    }

    isLoading.value = false;
  }

  // Future<void> saveLesson(int lessonId) async {
  //   final response = await ApiService().postRequestWithToken(
  //     "save-lesson",
  //     {"lesson_id": lessonId.toString()},
  //   );

  //   if (response != null && response.statusCode == 200) {
  //     print("📩 Save Lesson Response: ${response.data}");
  //   } else {
  //     print("❌ Save Lesson Failed or Response Null");
  //   }
  // }
  Future<void> saveLesson(int lessonId, LessonModel lesson) async {
    final response = await ApiService().postRequestWithToken(
      "save-lesson",
      {"lesson_id": lessonId.toString()},
    );

    if (response != null && response.statusCode == 200) {
      lesson.isSave.value = lesson.isSave.value == 1 ? 0 : 1;

      Get.snackbar(
        "Success",
        lesson.isSave.value == 1 ? "Lesson bookmarked!" : "Bookmark removed.",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        "Error",
        "Failed to update bookmark.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
