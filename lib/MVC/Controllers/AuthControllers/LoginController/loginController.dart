// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Logincontroller extends GetxController {

// final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reclaim/MVC/Controllers/UserController/userController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:reclaim/appServices/SharedPrefService.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class Logincontroller extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final UserController controller = Get.put(UserController());

  // new Controller

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and password are required",
          backgroundColor: Reclaimcolors.Red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      final response = await ApiService().postRequest("login", data: {
        "email": email,
        "password": password,
      });

      isLoading.value = false;

      if (response != null && response.data["error"] == false) {
        final userData = response.data["data"]["user"];
        final token = response.data["data"]["token"];

        final name = userData["profile_name"] ?? "";
        final gender = userData["profile_gender"] ?? "";
        final image = userData["profile_image"] ?? "";

        // ✅ Save to SharedPreferences
        await SharedPrefService.saveUserData(
          id: userData["id"].toString(),
          email: userData["email"],
          deviceToken: userData["device_token"],
          Name: name,
          token: token,
          gender: gender,
          image: image,
        );

        // ✅ Update UI through UserController
        controller.updateUserProfile(
          name: name,
          gender: gender,
          image: image,
        );

        // ✅ Navigate to next screen
        Get.toNamed(GetRouteNames.BottomnavbarView);
      } else {
        Get.snackbar(
            "Login Failed", response!.data["message"] ?? "Invalid credentials",
            backgroundColor: Reclaimcolors.Red, colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Invalid credentials",
          "In case of lost credential use Forget Password",
          backgroundColor: Reclaimcolors.DisableText,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      print("Login Exception: $e");
    }
  }
}
