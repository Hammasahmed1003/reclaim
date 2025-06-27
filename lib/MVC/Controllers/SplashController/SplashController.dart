import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reclaim/appServices/SharedPrefService.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;

  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  late AnimationController slideController;
  late Animation<Offset> slideAnimation;

  @override
  void onInit() {
    super.onInit();

    // Initialize fade-in animation
    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(fadeController);

    // Initialize scale animation
    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    scaleAnimation =
        Tween<double>(begin: 0.5, end: 1.0).animate(scaleController);

    // Initialize slide animation
    slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    slideAnimation = Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0, 0))
        .animate(slideController);

    startAnimation();
  }

  // void startAnimation() async {
  //   await Future.delayed(const Duration(seconds: 0));
  //   fadeController.forward();

  //   await Future.delayed(const Duration(seconds: 2));
  //   scaleController.forward();

  //   await Future.delayed(const Duration(seconds: 1));
  //   slideController.forward();

  //   // Navigate to Home after animation completes
  //   await Future.delayed(const Duration(seconds: 3));
  //   Get.offNamed(GetRouteNames
  //       .onBoardingScreen); // Change this to your actual home route
  // }

  void startAnimation() async {
    await Future.delayed(const Duration(seconds: 0));
    fadeController.forward();

    await Future.delayed(const Duration(seconds: 2));
    scaleController.forward();

    await Future.delayed(const Duration(seconds: 1));
    slideController.forward();

    // Check for token
    await Future.delayed(const Duration(seconds: 2));

    final token = await SharedPrefService.getUserToken();

    if (token != null && token.isNotEmpty) {
      Get.offNamed(GetRouteNames.BottomnavbarView);
    } else {
      Get.offNamed(GetRouteNames.onBoardingScreen);
    }
  }

  @override
  void onClose() {
    fadeController.dispose();
    scaleController.dispose();
    slideController.dispose();
    super.onClose();
  }
}
