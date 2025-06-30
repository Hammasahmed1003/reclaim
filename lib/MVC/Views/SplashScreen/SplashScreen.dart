import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reclaim/MVC/Controllers/SplashController/SplashController.dart';
import 'package:reclaim/appConstants/ReclaimImages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
              statusBarColor: Color(0xff3A6FA0),
              systemNavigationBarColor: Color(0xFF3882C7)),
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF3A6FA0),
                    Color(0xFF3882C7)
                  ], // Blue gradient
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // Logo scale effect
                  // ScaleTransition(
                  //   scale: controller.scaleAnimation,
                  //   child: Image.asset(
                  //    Reclaimimages.SplashIcon, // Change path if needed
                  //     width: 100,
                  //     height: 100,
                  //   ),
                  // ),

                  const SizedBox(height: 20),

                  // Logo slides up, then text appears
                  SlideTransition(
                    position: controller.slideAnimation,
                    child: Column(
                      children: [
                        Image.asset(
                          Reclaimimages
                              .SplashWithCircle, // Change path if needed

                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Reclaim",
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
