import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reclaim/MVC/Controllers/UserController/userController.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:reclaim/appServices/SharedPrefService.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class Editprofilecontroller extends GetxController {
  final TextEditingController FullNameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  var selectedImage = Rx<File?>(null);
  RxString selectedGender = 'Male'.obs;

  RxBool isLoading = false.obs;

  String? imagePathFromServer;

  @override
  void onInit() {
    loadProfileData();
    super.onInit();
  }

  Future<void> loadProfileData() async {
    FullNameController.text = await SharedPrefService.getUserName() ?? '';
    EmailController.text = await SharedPrefService.getUserEmail() ?? '';
    genderController.text = await SharedPrefService.getUserGender() ?? '';
    selectedGender.value = genderController.text;
    imagePathFromServer = await SharedPrefService.getUserImage();
  }

  void updateGender(String gender) {
    selectedGender.value = gender;
    genderController.text = gender;
  }

  void logoutUser() async {
    await SharedPrefService.clearAll();
    Get.offAllNamed(GetRouteNames.SplashScreen);
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  // Future<void> saveProfile() async {
  //   isLoading.value = true;

  //   final name = FullNameController.text.trim();
  //   final gender = selectedGender.value;
  //   final image = selectedImage.value;

  //   print("Saving Profile:");
  //   print("Name: $name");
  //   print("Gender: $gender");
  //   print("Image: ${image?.path}");

  //   try {
  //     String? token = await SharedPrefService.getUserToken();

  //     if (token == null) {
  //       Get.snackbar("Error", "Authorization token not found");
  //       isLoading.value = false;
  //       return;
  //     }

  //     var headers = {
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     };

  //     var formData = _dio.FormData.fromMap({
  //       'name': name,
  //       'age': '25', // You can replace with a real field later
  //       'gender': gender,
  //       if (image != null)
  //         'avatar': await _dio.MultipartFile.fromFile(image.path,
  //             filename: image.path.split('/').last),
  //     });

  //     final dio = _dio.Dio();

  //     var response = await dio.request(
  //       'https://reclaim.hboxdigital.website/api/update-profile',
  //       options: _dio.Options(
  //         method: 'POST',
  //         headers: headers,
  //       ),
  //       data: formData,
  //     );

  //     if (response.statusCode == 200 && response.data['error'] == false) {
  //       Get.snackbar("Success", "Profile updated!");
  //       print("Response: ${response.data}");
  //     } else {
  //       Get.snackbar("Error", response.data["message"] ?? "Update failed");
  //       print("Error Response: ${response.data}");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Something went wrong");
  //     print("Exception: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> saveProfile() async {
    isLoading.value = true;

    final name = FullNameController.text.trim();
    final gender = selectedGender.value;
    final image = selectedImage.value;

    try {
      String? token = await SharedPrefService.getUserToken();

      if (token == null) {
        Get.snackbar("Error", "Authorization token not found");
        isLoading.value = false;
        return;
      }

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var formData = _dio.FormData.fromMap({
        'name': name,
        'age': '25',
        'gender': gender,
        if (image != null)
          'avatar': await _dio.MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last),
      });

      final dio = _dio.Dio();

      var response = await dio.request(
        'https://reclaim.hboxdigital.website/api/update-profile',
        options: _dio.Options(
          method: 'POST',
          headers: headers,
        ),
        data: formData,
      );

      if (response.statusCode == 200 && response.data['error'] == false) {
        final profile = response.data['data']['profile'];

        // 🧠 Update Shared Preferences
        await SharedPrefService.updateUserName(profile['name']);
        await SharedPrefService.updateUserGender(profile['gender']);
        await SharedPrefService.updateUserImage(profile['avatar']);

        // 🧠 Update Controller reactive state so UI updates instantly
        FullNameController.text = profile['name'];
        genderController.text = profile['gender'];
        selectedGender.value = profile['gender'];
        imagePathFromServer = profile['avatar'];

        // Get.snackbar("Success", "Profile updated!");
        Get.back();
        Get.back();

        final userController = Get.find<UserController>();

        userController.updateUserProfile(
          name: profile['name'],
          gender: profile['gender'],
          image: profile['avatar'],
        );
      } else {
        Get.snackbar("Error", response.data["message"] ?? "Update failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

//

  var isDeleteLoading = false.obs;

  Future<void> deleteAccount(BuildContext context) async {
    isDeleteLoading.value = true;

    try {
      final token = await SharedPrefService.getUserToken();

      if (token == null) {
        Get.snackbar("Error", "No token found, please log in again.");
        return;
      }

      final response =
          await ApiService().postRequestWithToken("delete-account", {}

              // headers: {},
              // data: {},
              // You can send any required data here, if necessary
              // headers: {
              //   "Authorization": "Bearer $token",
              // },
              );

      if (response != null &&
          response.statusCode == 200 &&
          response.data["error"] == false) {
        // Successfully deleted the account
        await SharedPrefService.clearAll(); // Clear shared preferences

        Get.snackbar("Success", "Your account has been deleted.");
        Get.offAllNamed('/login'); // Redirect to login screen
      } else {
        Get.snackbar(
            "Error", response?.data['message'] ?? "Failed to delete account.");
      }
    } catch (e) {
      print("Error deleting account: $e");
      Get.snackbar("Error", "Something went wrong.");
    } finally {
      isDeleteLoading.value = false;
    }
  }
}
