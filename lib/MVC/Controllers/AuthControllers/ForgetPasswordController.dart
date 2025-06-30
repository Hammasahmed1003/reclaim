import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appServices/ApiServices.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final otp = ''.obs;
  final isLoading = false.obs;
  final isOtpSent = false.obs;

  Future<void> sendOtp() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar("Error", "Email is required",
          backgroundColor: Reclaimcolors.Red, colorText: Colors.white);
      return;
    }
    isLoading.value = true;
    try {
      final response = await ApiService().postRequest("resend-otp", data: {
        "email": email,
      });
      isLoading.value = false;
      if (response != null && response.data["error"] == false) {
        isOtpSent.value = true;
        Get.snackbar("Success", response.data["message"],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Reclaimcolors.DisableText,
            colorText: Colors.white);
      } else {
        Get.snackbar("Failed", response!.data["message"],
            backgroundColor: Reclaimcolors.Red, colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "An error occurred",
          backgroundColor: Reclaimcolors.Red, colorText: Colors.white);
    }
  }

  Future<void> resetPassword() async {
    final email = emailController.text.trim();
    final newPassword = passwordController.text.trim();

    if (otp.value.isEmpty || newPassword.isEmpty || newPassword.length < 8) {
      Get.snackbar("Error", "Enter valid OTP and password (min 8 chars)",
          backgroundColor: Reclaimcolors.Red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      final response = await ApiService().postRequest("forgot-password", data: {
        "email": email,
        "otp": otp.value,
        "password": newPassword,
      });
      isLoading.value = false;
      if (response != null && response.data["error"] == false) {
        Get.back();
        Get.snackbar("Success", response.data["message"],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Reclaimcolors.DisableText,
            colorText: Colors.white);
      } else {
        String errorMessage = response?.data["code"] == 409
            ? "Invalid Credential"
            : response?.data["message"] ?? "Invalid Credentials";

        Get.snackbar(
            snackPosition: SnackPosition.BOTTOM,
            "Failed",
            errorMessage,
            backgroundColor: Reclaimcolors.DisableText,
            colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "An error occurred",
          backgroundColor: Reclaimcolors.Red, colorText: Colors.white);
    }
  }
}
