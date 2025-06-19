import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Editprofilecontroller extends GetxController {
  final TextEditingController FullNameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var selectedImage = Rx<File?>(null);



RxString selectedGender = 'Male'.obs;
  TextEditingController genderController = TextEditingController();



void updateGender(String gender) {
    selectedGender.value = gender;
    genderController.text = gender;
  }

}