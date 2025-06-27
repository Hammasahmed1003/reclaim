import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reclaim/MVC/Controllers/Commitments/ComitmentsController.dart';
import 'package:reclaim/MVC/Controllers/Commitments/InprogressController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appServices/ApiServices.dart';

class CreateCommitmentsController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var isLoading = false.obs;

  @override
  void onClose() {
    titleController.dispose();
    deadlineController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> createCommitment() async {
    final title = titleController.text.trim();
    final deadline = deadlineController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || deadline.isEmpty || description.isEmpty) {
      Get.snackbar("Validation Error", "All fields are required");
      return;
    }

    isLoading.value = true;

    final response =
        await ApiService().postRequestWithToken("store-commitments", {
      "title": title,
      "deadline": deadline,
      "description": description,
    });

    isLoading.value = false;

    if (response != null &&
        response.statusCode == 200 &&
        response.data["error"] == false) {
      // Get.snackbar("Success", response.data["message"],
      //     backgroundColor: Reclaimcolors.BasicBlue);
      Get.find<InProgressController>().fetchInProgressCommitments();

      Get.back();

      // Navigate back on success
    } else {
      Get.snackbar("Error", "Failed to create commitment");
    }
  }
}
