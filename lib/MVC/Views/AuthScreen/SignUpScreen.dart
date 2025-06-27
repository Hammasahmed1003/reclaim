import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimTextFeild.dart';
import 'package:reclaim/MVC/Controllers/AuthControllers/SignUpController/SignUpController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Signupcontroller signupcontroller = Get.put(Signupcontroller());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Reclaimcolors.BasicWhite,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Registration",
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w800,
                          color: Reclaimcolors.BasicBlack),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: Reclaimcolors.BasicBlack),
                    ),
                  ],
                ),

                SizedBox(
                  height: 15.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Reclaimcolors.BasicBlack),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.sp,
                ),
                ReclaimTextField(
                  activeBorderColor: Reclaimcolors.BasicBlue,
                  filledColor: Reclaimcolors.BasicWhite,
                  hintText: "example@gmail.com",
                  isPassword: false,
                  hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
                  controller: signupcontroller.emailController,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Reclaimcolors.BasicBlack),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.sp,
                ),
                ReclaimTextField(
                  activeBorderColor: Reclaimcolors.BasicBlue,
                  filledColor: Reclaimcolors.BasicWhite,
                  hintText: "*******",
                  isPassword: true,
                  hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
                  controller: signupcontroller.passwordController,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Confirm Password",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Reclaimcolors.BasicBlack),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.sp,
                ),
                ReclaimTextField(
                  activeBorderColor: Reclaimcolors.BasicBlue,
                  filledColor: Reclaimcolors.BasicWhite,
                  hintText: "*******",
                  isPassword: true,
                  hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
                  controller: signupcontroller.passwordController,
                ),
                SizedBox(
                  height: 30.sp,
                ),

                // ReclaimButton(
                //   titleColor: Reclaimcolors.BasicWhite,
                //   width: 370.w,
                //   height: 48.h,
                //   backgroundColor: Reclaimcolors.BasicBlue,
                //   title: "Continue",
                //   fontWeight: FontWeight.w600,
                //   onPressed: () {
                //     // final signupController = Get.put(SignupController());
                //     signupcontroller.signup();
                //   },
                // ),
                Obx(
                  () => ReclaimButton(
                    titleColor: Reclaimcolors.BasicWhite,
                    width: 370.w,
                    height: 48.h,
                    backgroundColor: Reclaimcolors.BasicBlue,
                    title: "Continue",
                    fontWeight: FontWeight.w600,
                    onPressed: () async {
                      await signupcontroller.signup();
                    },
                    isLoading: signupcontroller.isLoading.value,
                  ),
                ),

                SizedBox(
                  height: 20.h,
                ),

                RichText(
                  text: TextSpan(
                    text: " Have An Account? ",
                    style: const TextStyle(
                        color: Reclaimcolors.BasicBlack,
                        fontSize: 17,
                        fontWeight: FontWeight.w300),
                    children: [
                      TextSpan(
                        text: "LogIn",
                        style: const TextStyle(
                            color: Reclaimcolors.BasicBlue,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to SignUp screen
                            Get.toNamed(GetRouteNames.LoginRoute);
                          },
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    children: [
                      TextSpan(
                          text: "By Signing Up/Logging In. You Agree To Our "),
                      TextSpan(
                        text: "Terms Of Service",
                        style: TextStyle(
                            color: Reclaimcolors.BasicBlue,
                            fontWeight: FontWeight.w400),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("Terms Of Service tapped");
                            // Navigate to Terms of Service screen
                          },
                      ),
                      TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: const TextStyle(
                            color: Reclaimcolors.BasicBlue,
                            fontWeight: FontWeight.w400),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("Privacy Policy tapped");
                            // Navigate to Privacy Policy screen
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
