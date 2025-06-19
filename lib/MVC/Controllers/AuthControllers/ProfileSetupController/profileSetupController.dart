// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class Profilesetupcontroller extends GetxController{
//   final TextEditingController FullNameController = TextEditingController();
//    TextEditingController dateOfBirthController = TextEditingController();
   
//   RxInt age = 0.obs;
//   TextEditingController genderController = TextEditingController();
// RxString selectedGender = 'Male'.obs;



//   var selectedImage = Rx<File?>(null);



//   void updateDateOfBirth(DateTime selectedDate) {
//     dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    
//     // Calculate Age
//     final currentDate = DateTime.now();
//     int calculatedAge = currentDate.year - selectedDate.year;
//     if (currentDate.month < selectedDate.month ||
//         (currentDate.month == selectedDate.month && currentDate.day < selectedDate.day)) {
//       calculatedAge--;
//     }

//     age.value = calculatedAge;
//   }

//   void updateGender(String gender) {
//     selectedGender.value = gender;
//     genderController.text = gender;
//   }

// }


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Profilesetupcontroller extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  
  RxInt age = 0.obs;
  RxString selectedGender = 'Male'.obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  void updateDateOfBirth(DateTime selectedDate) {
    dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    
    // Calculate Age
    final currentDate = DateTime.now();
    int calculatedAge = currentDate.year - selectedDate.year;
    if (currentDate.month < selectedDate.month ||
        (currentDate.month == selectedDate.month && currentDate.day < selectedDate.day)) {
      calculatedAge--;
    }
    age.value = calculatedAge;
  }

  void updateGender(String gender) {
    selectedGender.value = gender;
    genderController.text = gender;
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  bool validateProfile() {
    if (fullNameController.text.trim().isEmpty) {
      Get.snackbar("Error", "Full Name is required", backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (dateOfBirthController.text.trim().isEmpty) {
      Get.snackbar("Error", "Date of Birth is required", backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    if (genderController.text.trim().isEmpty) {
      Get.snackbar("Error", "Gender is required", backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }
    return true;
  }
}
