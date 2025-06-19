// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// class Addcommunitycontroller extends GetxController{

//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   var selectedImage = Rx<File?>(null);

//   final ImagePicker _picker = ImagePicker();

//   Future<void> pickImage() async {
//     final status = await Permission.photos.request();

//     if (status.isGranted) {
//       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         selectedImage.value = File(image.path);
//       }
//     } else if (status.isDenied) {
//       Get.snackbar("Permission Denied", "You need to allow access to photos in settings.");
//     } else if (status.isPermanentlyDenied) {
//       openAppSettings();
//     }
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddCommunityController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  var selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } else if (status.isDenied) {
      Get.snackbar("Permission Denied", "You need to allow access to photos in settings.");
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
