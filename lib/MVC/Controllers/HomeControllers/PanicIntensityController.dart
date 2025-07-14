import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appServices/ApiServices.dart';

class PanicIntensityController extends GetxController {
  final ApiService _apiService = ApiService();

  var selectedCategory = 'mental'.obs;
  var selectedIntensity = 'moderate'.obs;
  var isLoading = false.obs;

  void setCategory(String value) => selectedCategory.value = value;
  void setIntensity(String value) => selectedIntensity.value = value;

  Future<void> submitTaskCategory() async {
    isLoading.value = true;

    final body = {
      'task_category': selectedCategory.value,
      'task_intensity': selectedIntensity.value,
    };

    final response =
        await _apiService.postRequestWithToken("tast-category", body);

    isLoading.value = false;

    if (response != null && response.statusCode == 200) {
      Get.back();
      Get.snackbar("Success", "Task category submitted successfully.",
          backgroundColor: Reclaimcolors.DisableText,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Failed to submit task category.");
    }
  }
}
