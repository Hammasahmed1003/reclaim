import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class Signupcontroller extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ConfirmPasswordController =
      TextEditingController();

  final RxBool isLoading = false.obs;
  String? deviceToken;

  @override
  void onInit() {
    super.onInit();
    _getDeviceToken();
  }

  Future<void> _getDeviceToken() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    deviceToken = androidInfo.id; // Device ID as a token
    print("📱 Device Token: $deviceToken");
  }

  // Future<void> signup() async {
  //   final email = emailController.text.trim();
  //   final password = passwordController.text.trim();

  //   // Validation
  //   if (email.isEmpty || password.isEmpty) {
  //     Get.snackbar("Error", "Please enter all fields",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //     return;
  //   }

  //   if (!GetUtils.isEmail(email)) {
  //     Get.snackbar("Invalid Email", "Please enter a valid email address",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //     return;
  //   }

  //   if (password.length < 6) {
  //     Get.snackbar("Weak Password", "Password must be at least 6 characters",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //     return;
  //   }

  //   if (password != passwordController.text.trim()) {
  //     Get.snackbar("Password Mismatch", "Passwords do not match",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //     return;
  //   }

  //   isLoading.value = true;
  //   try {
  //     final response = await ApiService().postRequest("register", data: {
  //       "email": email,
  //       "password": password,
  //       "device_token": deviceToken,
  //     });

  //     if (response != null) {
  //       final data = response.data;
  //       if (data["success"] == true && data.containsKey("otp")) {
  //         Get.toNamed(GetRouteNames.Otpscreen, arguments: {"email": email});
  //         return;
  //       } else if (data["success"] == false && data.containsKey("errors")) {
  //         final errors = data["errors"];
  //         String errorMessage = errors["email"]?[0] ?? "Signup failed";
  //         Get.snackbar("Signup Failed", errorMessage,
  //             backgroundColor: Colors.red, colorText: Colors.white);
  //         return;
  //       }
  //     }

  //     Get.snackbar("Error", "Unexpected response from server",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> signup() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = ConfirmPasswordController.text.trim();

// Validation
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "Please enter all fields",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (password.length < 6) {
      Get.snackbar("Weak Password", "Password must be at least 6 characters",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Password Mismatch", "Passwords do not match",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      final response = await ApiService().postRequest("register", data: {
        "email": email,
        "password": confirmPassword,
        "device_token": deviceToken,
      });

      if (response != null) {
        final data = response.data;

        if (data["error"] == false && data["data"]?["otp"] != null) {
          final otp = data["data"]["otp"];
          print("✅ OTP: $otp");

          Get.toNamed(GetRouteNames.Otpscreen, arguments: {"email": email});
          return;
        } else {
          final message = data["message"] ?? "Signup failed";
          Get.snackbar("Signup Failed", message,
              backgroundColor: Colors.red, colorText: Colors.white);
          return;
        }
      }

      Get.snackbar("Error", "Unexpected response from server",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
