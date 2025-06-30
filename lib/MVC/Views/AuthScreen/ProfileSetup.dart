import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimTextFeild.dart';
import 'package:reclaim/MVC/Controllers/AuthControllers/ProfileSetupController/profileSetupController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class Profilesetup extends StatelessWidget {
  const Profilesetup({super.key});

  @override
  Widget build(BuildContext context) {
    final Profilesetupcontroller profilesetupcontroller =
        Get.put(Profilesetupcontroller());
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
                      "Profile Setup",
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
                      "Setup Your Profile From Here!",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w300,
                          color: Reclaimcolors.BasicBlack),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => profilesetupcontroller.pickImage(),
                  child: Obx(
                    () => Row(
                      children: [
                        Container(
                          width: 89.w,
                          height: 85.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Reclaimcolors.BlueSecondary,
                            image: profilesetupcontroller.selectedImage.value !=
                                    null
                                ? DecorationImage(
                                    image: FileImage(profilesetupcontroller
                                        .selectedImage.value!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child:
                              profilesetupcontroller.selectedImage.value == null
                                  ? 
                                  Center(
                                      child: SvgPicture.asset(
                                        ReclaimIcon.userIcon,
                                        color: Reclaimcolors.BasicBlue,
                                      ),
                                    )
                                  : null,
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Upload Your Picture',
                                style: TextStyle(
                                    color: Reclaimcolors.BasicBlack,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 10.h),
                            Text('(Optional)',
                                style: TextStyle(
                                    color: Reclaimcolors.BasicBlack,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name",
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
                  hintText: "Enter Your Full Name",
                  isPassword: false,
                  hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
                  controller: profilesetupcontroller.fullNameController,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date of Birth",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Reclaimcolors.BasicBlack,
                      ),
                    ),
                    SizedBox(height: 5.sp),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: 250,
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Expanded(
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      initialDateTime: DateTime(2000, 1, 1),
                                      maximumDate: DateTime.now(),
                                      onDateTimeChanged: (DateTime newDate) {
                                        profilesetupcontroller
                                            .updateDateOfBirth(newDate);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: AbsorbPointer(
                        child: ReclaimTextField(
                          activeBorderColor: Reclaimcolors.BasicBlue,
                          filledColor: Reclaimcolors.BasicWhite,
                          hintText: "Select Your Date of Birth",
                          isPassword: false,
                          hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
                          controller:
                              profilesetupcontroller.dateOfBirthController,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Youre ${profilesetupcontroller.age.value} years old",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Reclaimcolors.BasicBlue),
                            ),
                          ],
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gender",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => _showGenderPicker(context),
                      child: AbsorbPointer(
                          child: ReclaimTextField(
                              hintText: "Gender",
                              filledColor: Reclaimcolors.BasicWhite,
                              activeBorderColor: Reclaimcolors.BasicWhite,
                              controller:
                                  profilesetupcontroller.genderController)),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    ReclaimButton(
                      titleColor: Reclaimcolors.BasicWhite,
                      width: 370.w,
                      height: 48.h,
                      backgroundColor: Reclaimcolors.BasicBlue,
                      title: "Continue",
                      fontWeight: FontWeight.w600,
                      onPressed: () {
                        if (profilesetupcontroller.validateProfile()) {
                          Get.offAllNamed(GetRouteNames.SurveyQuestions);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showGenderPicker(BuildContext context) {
  final Profilesetupcontroller profilesetupcontroller =
      Get.put(Profilesetupcontroller());
  showCupertinoModalPopup(
    context: context,
    builder: (_) => Container(
      height: 250,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 32,
                onSelectedItemChanged: (index) {
                  final genders = ["male", "female", "other"];
                  profilesetupcontroller.updateGender(genders[index]);
                },
                children: const [
                  Text("Male"),
                  Text("Female"),
                  Text("Other"),
                ],
              ),
            ),
            CupertinoButton(
              child: Text("Done", style: TextStyle(color: Colors.blue)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    ),
  );
}
