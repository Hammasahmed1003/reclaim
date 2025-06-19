import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import '../../../appServices/getRouteNames.dart';

class OtpController extends GetxController {
  final ApiService _apiService = ApiService();
  var otp = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var canResend = false.obs;
  Timer? _timer;
  var timeLeft = 45.obs; // 45 seconds countdown

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    timeLeft.value = 45;
    canResend.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> verifyOtp(String email) async {
    if (otp.value.isEmpty || otp.value.length < 4) {
      errorMessage.value = "Please enter a valid 4-digit OTP.";
      return;
    }

    isLoading.value = true;
    errorMessage.value = "";

    final response = await _apiService.postRequest(
      "verify-otp",
      data: {
        "email": email,
        "otp": otp.value,
      },
    );

    isLoading.value = false;

    if (response != null && response.statusCode == 200) {
      if (response.data["success"]) {
        Get.offNamed(GetRouteNames.Profilesetup);
      } else {
        errorMessage.value = response.data["message"];
      }
    } else {
      errorMessage.value = "Something went wrong. Please try again.";
    }
  }

  Future<void> resendOtp(String email) async {
    if (!canResend.value) return;

    isLoading.value = true;
    errorMessage.value = "";

    final response = await _apiService.postRequest(
      "resend-otp",
      data: {"email": email},
    );

    isLoading.value = false;

    if (response != null && response.statusCode == 200) {
      if (response.data["success"]) {
        startTimer();
      } else {
        errorMessage.value = response.data["message"];
      }
    } else {
      errorMessage.value = "Failed to resend OTP. Try again.";
    }
  }
}
