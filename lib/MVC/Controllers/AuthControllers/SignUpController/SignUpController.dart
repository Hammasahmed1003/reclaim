import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class Signupcontroller extends GetxController {

final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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

 Future<void> signup() async {
  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
    Get.snackbar("Error", "Please enter all fields",
        backgroundColor: Colors.red, colorText: Colors.white);
    return;
  }

  isLoading.value = true;
  try {
    final response = await ApiService().postRequest("register", data: {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "device_token": deviceToken,
    });

    if (response != null) {
      print("🔄 Response received: ${response.data}");

      final data = response.data;
      if (data != null && data["success"] == true && data.containsKey("otp")) {
        final otp = data["otp"];
        print("✅ Signup Successful: OTP - $otp");

        Get.toNamed(GetRouteNames.Otpscreen, arguments: {
          "email": emailController.text.trim(),
         
        });
        return;
      } else if (data != null && data["success"] == false && data.containsKey("errors")) {
        // Handling validation errors from API
        final errors = data["errors"];
        String errorMessage = "Signup failed";

        if (errors.containsKey("email") && errors["email"].isNotEmpty) {
          errorMessage = errors["email"][0]; // Showing specific error
        }

        // Get.snackbar("Signup Failed", errorMessage,
        //     backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }
    }

    // Default error when response is unexpected
    Get.snackbar("Error", "Unexpected response from server",
        backgroundColor: Colors.red, colorText: Colors.white);

  } 
   finally {
    isLoading.value = false;
  }
}



}