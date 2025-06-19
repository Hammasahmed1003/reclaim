import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCommitmentsController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void onClose() {
    titleController.dispose();
    deadlineController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
