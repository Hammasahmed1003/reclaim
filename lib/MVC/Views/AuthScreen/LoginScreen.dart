import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimSocialBtn.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimTextFeild.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/AuthControllers/LoginController/loginController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController logincontroller = Get.put(LoginController());
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          const SystemUiOverlayStyle(statusBarColor: Reclaimcolors.BasicWhite),
      child: SafeArea(
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
                        "Welcome Back",
                        style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w800,
                            color: Reclaimcolors.BasicBlack),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: Reclaimcolors.BasicBlack),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18.h,
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
                    hintText: "Ex@gmail.com",
                    isPassword: false,
                    hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
                    controller: logincontroller.emailController,
                  ),
                  SizedBox(
                    height: 18.h,
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
                    hintText: "********",
                    isPassword: true,
                    hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
                    controller: logincontroller.passwordController,
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SpringWidget(
                        onTap: () {
                          Get.toNamed(GetRouteNames.Forgetpasswordscreen);
                        },
                        child: Text(
                          "Forget Password",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Reclaimcolors.BasicBlue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Obx(
                    () => ReclaimButton(
                        isLoading: logincontroller.isLoading.value,
                        titleColor: Reclaimcolors.BasicWhite,
                        width: 370.w,
                        height: 48.h,
                        backgroundColor: Reclaimcolors.BasicBlue,
                        title: "Log In",
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          // Get.toNamed(GetRouteNames.BottomnavbarView);

                          logincontroller.login();
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SpringWidget(
                    onTap: () {
                      Get.toNamed(GetRouteNames.Signupscreen);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't Have An Account? ",
                        style: const TextStyle(
                            color: Reclaimcolors.BasicBlack,
                            fontSize: 17,
                            fontWeight: FontWeight.w300),
                        children: [
                          TextSpan(
                            text: "SignUp",
                            style: const TextStyle(
                                color: Reclaimcolors.BasicBlue,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to SignUp screen
                                // Get.toNamed(GetRouteNames.LoginRoute);
                                Get.toNamed(GetRouteNames.Signupscreen);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Or Sign In With",
                    style: TextStyle(
                        color: Reclaimcolors.DisableText.withOpacity(.3),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SocialLoginButtons(
                    onGoogleTap: () {
                      logincontroller.googleSignIn;
                      print("Google login tapped");
                      // Implement Google login here
                    },
                    onAppleTap: () {
                      print("Apple login tapped");
                      // Implement Apple login here
                    },

                    // onFacebookTap: () {
                    //   print("Facebook login tapped");
                    //   // Implement Facebook login here
                    // },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      logincontroller.googleSignIn();
                    },
                    child: Text("Sign in with Google"),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      children: [
                        TextSpan(
                            text:
                                "By Signing Up/Logging In. You Agree To Our "),
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
      ),
    );
  }
}
