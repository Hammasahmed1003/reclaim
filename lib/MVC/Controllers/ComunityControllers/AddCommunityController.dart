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
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:reclaim/appServices/SharedPrefService.dart';

// class AddCommunityController extends GetxController {
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

class AddCommunityController extends GetxController {
  final TextEditingController descriptionController = TextEditingController();
  var selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  var isLoading = false.obs;

  Future<void> pickImage() async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } else if (status.isDenied) {
      Get.snackbar("Permission Denied",
          "You need to allow access to photos in settings.");
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> createCommunity() async {
    final content = descriptionController.text.trim();
    final imageFile = selectedImage.value;

    if (content.isEmpty && imageFile == null) {
      Get.snackbar("Required", "Please add text or image before posting",
          backgroundColor: Reclaimcolors.Red.withOpacity(0.2),
          colorText: Colors.black);
      return;
    }

    isLoading.value = true;

    try {
      String? token = await SharedPrefService.getUserToken();

      if (token == null) {
        Get.snackbar("Error", "Authorization token not found",
            backgroundColor: Reclaimcolors.Red.withOpacity(0.2),
            colorText: Colors.black);
        isLoading.value = false;
        return;
      }

      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final formData = _dio.FormData.fromMap({
        if (content.isNotEmpty) 'content': content,
        if (imageFile != null)
          'image': await _dio.MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
      });

      final dio = _dio.Dio();

      final response = await dio.request(
        'https://reclaim.hboxdigital.website/api/create',
        options: _dio.Options(
          method: 'POST',
          headers: headers,
        ),
        data: formData,
      );

      if (response.statusCode == 200 && response.data['error'] == false) {
        Get.back(); // Close screen or dialog
        Get.snackbar("Success", "Community post created successfully",
            backgroundColor: Reclaimcolors.DisableText,
            colorText: Colors.white);
      } else {
        Get.snackbar("Error", response.data["message"] ?? "Post failed",
            backgroundColor: Reclaimcolors.Red.withOpacity(0.2),
            colorText: Colors.black);
      }
    } catch (e) {
      print("Exception: $e");
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Reclaimcolors.Red.withOpacity(0.2),
          colorText: Colors.black);
    } finally {
      isLoading.value = false;
    }
  }
}
