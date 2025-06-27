import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:reclaim/appServices/SharedPrefService.dart';

// void panicDialog(BuildContext context, Map<String, dynamic> task) {
//   final TextEditingController answerController = TextEditingController();

//   showCupertinoDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Stack(
//         children: [
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//             child: Container(
//               color: Reclaimcolors.BlueSecondary.withOpacity(0.9),
//             ),
//           ),
//           Center(
//             child: CupertinoAlertDialog(
//               content: Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   Lottie.asset(
//                     'assets/animations/alertLottie.json',
//                     width: 70,
//                     height: 90,
//                     fit: BoxFit.cover,
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     "Type: ${task['type']}\nIntensity: ${task['intensity']}",
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Reclaimcolors.BasicBlack,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     task['description'] ?? '',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Reclaimcolors.BasicBlack,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   CupertinoTextField(
//                     controller: answerController,
//                     placeholder: "Your answer here...",
//                     maxLines: 3,
//                     padding: const EdgeInsets.all(12),
//                   ),
//                   const SizedBox(height: 15),
//                   CupertinoButton(
//                     color: Reclaimcolors.Red,
//                     onPressed: () {
//                       print("User answer: \${answerController.text}");
//                       Get.back();
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(ReclaimIcon.Done),
//                         SizedBox(width: 10.w),
//                         Text(
//                           "Submit",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20.sp,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

void panicDialog(BuildContext context, Map<String, dynamic> task) {
  final TextEditingController answerController = TextEditingController();
  final RxBool isSubmitting = false.obs;

  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return Obx(() => Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Reclaimcolors.BlueSecondary.withOpacity(0.9),
                ),
              ),
              Center(
                child: CupertinoAlertDialog(
                  content: Column(
                    children: [
                      const SizedBox(height: 10),
                      Lottie.asset(
                        'assets/animations/alertLottie.json',
                        width: 70,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Type: ${task['type']}\nIntensity: ${task['intensity']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Reclaimcolors.BasicBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        task['description'] ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Reclaimcolors.BasicBlack,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CupertinoTextField(
                        controller: answerController,
                        placeholder: "Your answer here...",
                        maxLines: 3,
                        padding: const EdgeInsets.all(12),
                      ),
                      const SizedBox(height: 15),
                      CupertinoButton(
                        color: Reclaimcolors.Red,
                        onPressed: () async {
                          if (answerController.text.trim().isEmpty) {
                            Get.snackbar("Error", "Please enter your answer");
                            return;
                          }

                          isSubmitting.value = true;

                          try {
                            String? token =
                                await SharedPrefService.getUserToken();

                            final body = {
                              "answer": answerController.text.trim(),
                              "task_id": task["id"].toString(),
                            };
                            final response = await ApiService()
                                .postRequestWithToken("tasks-complete", body
                                    // headers: {"Authorization": "Bearer $token"},
                                    // body: {
                                    //   "answer": answerController.text.trim(),
                                    //   "task_id": task["id"].toString(),
                                    // },
                                    );

                            isSubmitting.value = false;

                            if (response != null &&
                                response.data["error"] == false) {
                              Get.back();
                              Get.snackbar("Success",
                                  response.data["message"] ?? "Task submitted",
                                  backgroundColor: Reclaimcolors.DisableText,
                                  colorText: Colors.white);
                            } else {
                              Get.snackbar(
                                  "Error",
                                  response!.data["message"] ??
                                      "Failed to submit",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                            }
                          } catch (e) {
                            isSubmitting.value = false;
                            Get.snackbar("Error", "Unexpected error occurred",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
                        child: isSubmitting.value
                            ? const CupertinoActivityIndicator()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(ReclaimIcon.Done),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Submit",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ));
    },
  );
}
