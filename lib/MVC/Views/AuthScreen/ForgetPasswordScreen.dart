import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimTextFeild.dart';
import 'package:reclaim/MVC/Controllers/AuthControllers/ForgetPasswordController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';

class Forgetpasswordscreen extends StatelessWidget {
  Forgetpasswordscreen({super.key});
  final controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: Reclaimcolors.BasicBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.isOtpSent.value
                      ? "Enter OTP & New Password"
                      : "Enter your email",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Reclaimcolors.BasicBlue),
                ),
                SizedBox(height: 20.h),

                // Email
                // TextField(
                //   controller: controller.emailController,
                //   decoration: InputDecoration(
                //     labelText: "Email",
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10)),
                //   ),
                // ),
                ReclaimTextField(
                    hintColor: Reclaimcolors.DisableText,
                    hintText: "Enter Email ",
                    filledColor: Reclaimcolors.BasicWhite,
                    activeBorderColor: Reclaimcolors.BasicBlue,
                    controller: controller.emailController),

                if (controller.isOtpSent.value) ...[
                  SizedBox(height: 20.h),

                  // OTP
                  OtpTextField(
                    borderWidth: 1,
                    autoFocus: true,
                    filled: true,
                    fillColor: Reclaimcolors.BlueSecondary,
                    cursorColor: Reclaimcolors.BasicBlue,
                    fieldHeight: 72.h,
                    fieldWidth: 72.w,
                    obscureText: false,
                    borderRadius: BorderRadius.circular(50),
                    numberOfFields: 4,
                    borderColor: Reclaimcolors.BasicBlue,
                    focusedBorderColor: Reclaimcolors.BasicBlue,
                    showFieldAsBox: true,
                    textStyle: TextStyle(
                      color: Reclaimcolors.BasicBlue,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    onSubmit: (String value) {
                      controller.otp.value = value;
                    },
                  ),

                  SizedBox(height: 20.h),

                  ReclaimTextField(
                      isPassword: T,
                      hintColor: Reclaimcolors.DisableText,
                      hintText: "New Password",
                      filledColor: Reclaimcolors.BasicWhite,
                      activeBorderColor: Reclaimcolors.BasicBlue,
                      controller: controller.passwordController)
                ],

                SizedBox(height: 30.h),

                // Button
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.isOtpSent.value
                                ? controller.resetPassword()
                                : controller.sendOtp();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Reclaimcolors.BasicBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ))
                        : Text(
                            controller.isOtpSent.value
                                ? "Reset Password"
                                : "Send OTP",
                            style: const TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
