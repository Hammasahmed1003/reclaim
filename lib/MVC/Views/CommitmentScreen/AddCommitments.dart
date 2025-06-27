import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimTextFeild.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/Commitments/createCommitmentcontroller.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class Addcommitments extends StatelessWidget {
  const Addcommitments({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateCommitmentsController controller =
        Get.put(CreateCommitmentsController());
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BlueSecondary,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Reclaimcolors.BlueSecondary,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Reclaimcolors.BasicBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SpringWidget(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(ReclaimIcon.Back)),
                        const Spacer(),
                        Text(
                          "Create Commitments",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Reclaimcolors.BasicWhite,
                            fontSize: 22.sp,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500)),
                      SizedBox(height: 8.h),
                      // TextField(
                      //   controller: controller.titleController,
                      //   decoration: InputDecoration(
                      //     hintText: "Jason217",
                      //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //   ),
                      // ),

                      ReclaimTextField(
                        activeBorderColor: Reclaimcolors.BasicBlue,
                        filledColor: Reclaimcolors.BasicWhite,
                        hintText: "Title",
                        isPassword: false,
                        hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
                        controller: controller.titleController,
                      ),
                      SizedBox(height: 20.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Deadline",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500)),
                          Text("(Optional)",
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      //  ReclaimTextField(
                      //   activeBorderColor: Reclaimcolors.BasicBlue,
                      //   filledColor: Reclaimcolors.BasicWhite,
                      //   hintText: "deadline",
                      //   isPassword: false,
                      //   hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
                      //   controller: controller.deadlineController,
                      //  ),
                      SpringWidget(
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate:
                                DateTime.now().add(const Duration(days: 1)),
                            firstDate: DateTime.now().add(const Duration(
                                days: 1)), // disables today & past
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            controller.deadlineController.text =
                                pickedDate.toIso8601String().split("T").first;
                          }
                        },
                        child: ReclaimTextField(
                          activeBorderColor: Reclaimcolors.BasicBlue,
                          filledColor: Reclaimcolors.BasicWhite,
                          hintText: "Pick Deadline",
                          isPassword: false,
                          hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
                          controller: controller.deadlineController,
                          // readOnly: true,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      Text("Description",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500)),
                      SizedBox(height: 8.h),
                      // TextField(
                      //   controller: controller.descriptionController,
                      //   maxLines: 4,
                      //   decoration: InputDecoration(
                      //     hintText: "Message",
                      //     border: OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: Reclaimcolors.BasicBlue),
                      //         borderRadius: BorderRadius.circular(10.r)),
                      //     filled: true,
                      //     fillColor: Colors.white,
                      //   ),
                      // ),

                      Container(
                        // margin: EdgeInsets.symmetric(
                        //     horizontal: 20.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: controller.descriptionController,
                          maxLines: 4,
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 14.h),
                            hintText: "Write your message here...",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Reclaimcolors.BasicBlue, width: 1.5),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: ReclaimButton(
                //       titleColor: Reclaimcolors.BasicWhite,
                //       width: 370.w,
                //       height: 48.h,
                //       backgroundColor: Reclaimcolors.BasicBlue,
                //       title: "Create Commitment",
                //       fontWeight: FontWeight.w600,
                //       onPressed: () {
                //         Get.back();
                //       }),
                // ),

                Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ReclaimButton(
                        titleColor: Reclaimcolors.BasicWhite,
                        width: 370.w,
                        height: 48.h,
                        backgroundColor: Reclaimcolors.BasicBlue,
                        title: controller.isLoading.value
                            ? "Please wait..."
                            : "Create Commitment",
                        fontWeight: FontWeight.w600,
                        isLoading: controller.isLoading.value,
                        onPressed: controller.createCommitment,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
