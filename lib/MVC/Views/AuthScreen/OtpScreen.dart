// // import 'package:flutter/material.dart';
// // import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
// // import 'package:reclaim/appConstants/ReclaimColors.dart';

// // import '../../../appServices/getRouteNames.dart';

// // class Otpscreen extends StatelessWidget {
// //   const Otpscreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final String email = Get.arguments['email'];
// //     return  SafeArea(
// //       child: Scaffold(
// //               backgroundColor: Reclaimcolors.BasicWhite,
        
// //         body: Padding(
// //                 padding: EdgeInsets.symmetric(horizontal: 20.w),
     
// //           child: Column(
// //             children: [
// //                       SizedBox(height: 20.h,),

// //                 Row(
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         "Sign Up With Email",
// //                         style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Reclaimcolors.BasicBlack,),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: 10.h),
// //                   Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 20),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                          email,
// //                           style: TextStyle(fontSize: 14.sp, color:  Reclaimcolors.BasicBlack,),
// //                         ),
// //                         SizedBox(width: 2.w,),
                    
// //                       ],
// //                     ),
// //                   ),
                 
// //                   SizedBox(height: 20.h),
          
// //                   // OTP Input Field
// //                   OtpTextField(

// //                     borderWidth: 1,
// //                     autoFocus: true,
// //                     filled: true,
// //                     fillColor:Reclaimcolors.BlueSecondary,
// //                     cursorColor: Reclaimcolors.BasicBlue,
// //                     fieldHeight: 72.h,
// //                     fieldWidth: 72.w,
// //           obscureText: true,
// //           borderRadius: BorderRadius.circular(50),
// //                     // borderRadius: BorderRadius.circular(10),
// //                     numberOfFields: 4,
// //                     borderColor: Reclaimcolors.BasicBlue,
// //                     focusedBorderColor:  Reclaimcolors.BasicBlue,
// //                     showFieldAsBox: true,
// //                     textStyle: TextStyle(color:  Reclaimcolors.BasicBlue, fontSize: 25.sp, 
// //                     fontWeight: FontWeight.bold
                    
// //                     ),
// //                     onSubmit: (String otp) {
// //                       // controller.otp.value = otp;
// //                     },
// //                   ),
// //                   SizedBox(height: 20.h),
// //                   GestureDetector(
// //                     onTap: (){
          
// //                     },
// //                     // controller.resendCode,
// //                     child: Align(
// //                       alignment: Alignment.centerRight,
// //                       child: Text(
// //                         "Resend Code",
// //                         style: TextStyle(fontSize: 16.sp, color: Reclaimcolors.DisableText.withOpacity(0.6)),
// //                       ),
// //                     ),
// //                   ),
          
                  
          
// //                SizedBox(height: 30,),
// //                    ReclaimButton(
// //             fontWeight: FontWeight.w900,
// //             title: "Verify OTP",
// //             backgroundColor: Reclaimcolors.BasicBlue,
// //             titleColor:  Reclaimcolors.BasicWhite,
          
// //           width: 370.w, height: 48.h,
// //             // isLoading: controller.isLoading.value,
// //             onPressed: (){
// //               // print("Entered OTP: ${controller.otp.value}");
// // Get.toNamed(GetRouteNames.Profilesetup);
            
// //             },
// //           ),
          
// //                   SizedBox(height: 20.h),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
// import 'package:reclaim/MVC/Controllers/AuthControllers/OtpController.dart';
// import 'package:reclaim/appConstants/ReclaimColors.dart';
// import 'package:reclaim/appServices/getRouteNames.dart';

// class OtpScreen extends StatelessWidget {
//   const OtpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final String email = Get.arguments['email'];
//     final OtpController controller = Get.put(OtpController());

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Reclaimcolors.BasicWhite,
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: Column(
//             children: [
//               SizedBox(height: 20.h),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Sign Up With Email",
//                     style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Reclaimcolors.BasicBlack),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 10.h),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(email, style: TextStyle(fontSize: 14.sp, color: Reclaimcolors.BasicBlack)),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 20.h),

//               // OTP Input Field
//               OtpTextField(
//                 borderWidth: 1,
//                 autoFocus: true,
//                 filled: true,
//                 fillColor: Reclaimcolors.BlueSecondary,
//                 cursorColor: Reclaimcolors.BasicBlue,
//                 fieldHeight: 72.h,
//                 fieldWidth: 72.w,
//                 obscureText: true,
//                 borderRadius: BorderRadius.circular(50),
//                 numberOfFields: 4,
//                 borderColor: Reclaimcolors.BasicBlue,
//                 focusedBorderColor: Reclaimcolors.BasicBlue,
//                 showFieldAsBox: true,
//                 textStyle: TextStyle(color: Reclaimcolors.BasicBlue, fontSize: 25.sp, fontWeight: FontWeight.bold),
//                 onSubmit: (String otp) {
//                   controller.otp.value = otp;
//                 },
//               ),

//               SizedBox(height: 20.h),

//               Obx(() => controller.isResendEnabled.value
//                   ? GestureDetector(
//                       onTap: () => controller.resendOtp(email),
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           "Resend Code",
//                           style: TextStyle(fontSize: 16.sp, color: Reclaimcolors.BasicBlue),
//                         ),
//                       ),
//                     )
//                   : Align(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         "Resend in ${controller.timerValue}s",
//                         style: TextStyle(fontSize: 16.sp, color: Reclaimcolors.DisableText.withOpacity(0.6)),
//                       ),
//                     )),

//               SizedBox(height: 30),

//               Obx(() => ReclaimButton(
//                     fontWeight: FontWeight.w900,
//                     title: "Verify OTP",
//                     backgroundColor: Reclaimcolors.BasicBlue,
//                     titleColor: Reclaimcolors.BasicWhite,
//                     width: 370.w,
//                     height: 48.h,
//                     isLoading: controller.isLoading.value,
//                     onPressed: () => controller.verifyOtp(email),
//                   )),

//               SizedBox(height: 20.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/MVC/Controllers/AuthControllers/OtpController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';

import '../../../appServices/getRouteNames.dart';

class Otpscreen extends StatelessWidget {
  const Otpscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController());
    final String email = Get.arguments['email'];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Reclaimcolors.BasicWhite,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up With Email",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Reclaimcolors.BasicBlack,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Reclaimcolors.BasicBlack,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // OTP Input Field
              OtpTextField(
                borderWidth: 1,
                autoFocus: true,
                filled: true,
                fillColor: Reclaimcolors.BlueSecondary,
                cursorColor: Reclaimcolors.BasicBlue,
                fieldHeight: 72.h,
                fieldWidth: 72.w,
                obscureText: true,
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
                onSubmit: (String otp) {
                  controller.otp.value = otp;
                },
              ),

              SizedBox(height: 10.h),

              Obx(() => controller.errorMessage.value.isNotEmpty
                  ? Text(
                      controller.errorMessage.value,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    )
                  : SizedBox()),

              SizedBox(height: 20.h),

              // Resend Code Button (Visible after timer ends)
              Obx(() => controller.canResend.value
                  ? GestureDetector(
                      onTap: () => controller.resendOtp(email),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Resend Code",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Reclaimcolors.BasicBlue,
                          ),
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Resend in ${controller.timeLeft.value}s",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Reclaimcolors.DisableText.withOpacity(0.6),
                        ),
                      ),
                    )),

              SizedBox(height: 30.h),

              Obx(() => ReclaimButton(
                    fontWeight: FontWeight.w900,
                    title: "Verify OTP",
                    backgroundColor: Reclaimcolors.BasicBlue,
                    titleColor: Reclaimcolors.BasicWhite,
                    width: 370.w,
                    height: 48.h,
                    isLoading: controller.isLoading.value,
                    onPressed: () => controller.verifyOtp(email),
                  )),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
