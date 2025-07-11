import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimTextFeild.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/EditProfileController/EditProfileController.dart';
import 'package:reclaim/MVC/Controllers/UserController/userController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final Editprofilecontroller controller = Get.put(Editprofilecontroller());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicWhite,
      ),
      child: Scaffold(
        backgroundColor: Reclaimcolors.BasicWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Reclaimcolors.BlueSecondary, Color(0xffffffff)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAppBar(context),
                    SizedBox(height: 5.h),
                    _buildProfileSection(controller),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildInputField("Full Name", "Jon Cena",
                          controller.FullNameController),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildInputField("Email", "email@example.com",
                          controller.EmailController,
                          isEnabled: false),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildGenderPicker(context, controller),
                    ),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Row(
                        children: [
                          // Delete Account Button
                          Expanded(
                            child: Obx(() {
                              if (controller.isDeleteLoading.value) {
                                return const Center(
                                  child:
                                      CircularProgressIndicator(), // Show loader when deleting
                                );
                              }

                              return GestureDetector(
                                onTap: () async {
                                  // Show confirmation dialog before deleting the account
                                  bool? deleteConfirmed =
                                      await _showDeleteConfirmationDialog(
                                          context);

                                  if (deleteConfirmed == true) {
                                    // Proceed to delete the account
                                    controller.deleteAccount(context);
                                  }
                                },
                                child: Container(
                                  height: 47,
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.delete,
                                          color: Colors.red, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),

                          SizedBox(width: 16.w),

                          // Logout Button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.logoutUser(); // Your logout logic
                              },
                              child: Container(
                                height: 47.h,
                                decoration: BoxDecoration(
                                  color:
                                      Reclaimcolors.BasicBlue.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.logout,
                                        color: Reclaimcolors.BasicBlue,
                                        size: 20),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "Logout",
                                      style: TextStyle(
                                        color: Reclaimcolors.BasicBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                    //   child: Obx(() => controller.isLoading.value
                    //       ? const Center(
                    //           child: SpinKitDoubleBounce(
                    //             color: Reclaimcolors.BasicWhite,
                    //             size: 20.0,
                    //           ),
                    //         )
                    //       : ReclaimButton(
                    //           width: double.infinity,
                    //           height: 47.h,
                    //           backgroundColor: Reclaimcolors.BasicBlue,
                    //           title: "Save",
                    //           fontWeight: FontWeight.bold,
                    //           onPressed: () => controller.saveProfile(),
                    //           titleColor: Reclaimcolors.BasicWhite,
                    //         )),
                    // ),
                    Obx(
                      () => Center(
                        child: ReclaimButton(
                          isLoading: controller.isLoading.value,
                          width: 320.w,
                          height: 47.h,
                          backgroundColor: Reclaimcolors.BasicBlue,
                          title: "Save",
                          fontWeight: FontWeight.bold,
                          onPressed: () => controller.saveProfile(),
                          titleColor: Reclaimcolors.BasicWhite,
                        ),
                      ),
                    )
                  ]),
              // ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: const BoxDecoration(
        color: Reclaimcolors.BasicBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          SpringWidget(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SvgPicture.asset(
                ReclaimIcon.Back,
                color: Reclaimcolors.BasicWhite,
              ),
            ),
          ),
          const Spacer(),
          Text(
            "Account Details",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: Reclaimcolors.BasicWhite,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  // Widget _buildProfileSection(Editprofilecontroller controller) {
  //   return GestureDetector(
  //     onTap: () {
  //       controller.pickImage();
  //     },
  //     child: Obx(
  //       () => Row(
  //         children: [
  //           Container(
  //             width: 89.w,
  //             height: 85.h,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10),
  //               color: Reclaimcolors.BlueSecondary,
  //               image: controller.selectedImage.value != null
  //                   ? DecorationImage(
  //                       image: FileImage(controller.selectedImage.value!),
  //                       fit: BoxFit.cover,
  //                     )
  //                   : (controller.imagePathFromServer != null
  //                       ? DecorationImage(
  //                           image: NetworkImage(
  //                               "https://your-base-url.com/${controller.imagePathFromServer!}"),
  //                           fit: BoxFit.cover,
  //                         )
  //                       : null),
  //             ),
  //             child: controller.selectedImage.value == null &&
  //                     controller.imagePathFromServer == null
  //                 ? Center(
  //                     child: SvgPicture.asset(
  //                       ReclaimIcon.userIcon,
  //                       color: Reclaimcolors.BasicBlue,
  //                     ),
  //                   )
  //                 : null,
  //           ),
  //           SizedBox(width: 10.w),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('Upload Your Picture',
  //                   style: TextStyle(
  //                       color: Reclaimcolors.BasicBlack,
  //                       fontSize: 18.sp,
  //                       fontWeight: FontWeight.w400)),
  //               SizedBox(height: 10.h),
  //               Text(' (Optional)',
  //                   style: TextStyle(
  //                       color: Reclaimcolors.BasicBlack,
  //                       fontSize: 13.sp,
  //                       fontWeight: FontWeight.w400)),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildProfileSection(Editprofilecontroller controller) {
    final userController = Get.find<UserController>();

    return GestureDetector(
      onTap: () {
        controller.pickImage();
      },
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              Container(
                width: 89.w,
                height: 85.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Reclaimcolors.BlueSecondary,
                  image: controller.selectedImage.value != null
                      ? DecorationImage(
                          image: FileImage(controller.selectedImage.value!),
                          fit: BoxFit.cover,
                        )
                      : (userController.userImage.value.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(
                                "https://reclaim.hboxdigital.website/${userController.userImage.value}",
                              ),
                              fit: BoxFit.cover,
                            )
                          : null),
                ),
                child: controller.selectedImage.value == null &&
                        userController.userImage.value.isEmpty
                    ? Center(
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
                  Text(' (Optional)',
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
    );
  }

  Widget _buildInputField(
      String label, String hint, TextEditingController controller,
      {bool isPassword = false, bool isEnabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5.h),
        ReclaimTextField(
          activeBorderColor: Reclaimcolors.BasicBlue,
          filledColor: Reclaimcolors.BasicWhite,
          hintText: hint,
          isPassword: isPassword,
          // enabled: isEnabled,

          hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
          controller: controller,
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildGenderPicker(
      BuildContext context, Editprofilecontroller controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          // style: TextStyle(
          //   fontSize: 16.sp,
          //   fontWeight: FontWeight.w400,
          //   color: Reclaimcolors.BasicBlack,
          // ),
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: () => _showGenderPicker(context, controller),
          child: AbsorbPointer(
            child: ReclaimTextField(
              hintText: "Select Gender",
              filledColor: Reclaimcolors.BasicWhite,
              activeBorderColor: Reclaimcolors.BasicBlue,
              controller: controller.genderController,
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  void _showGenderPicker(
      BuildContext context, Editprofilecontroller controller) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250.h,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 200.h,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 32.h,
                onSelectedItemChanged: (index) {
                  final genders = ["male", "female", "other"];
                  controller.updateGender(genders[index]);
                },
                children: const [
                  Text("Male"),
                  Text("Female"),
                  Text("Other"),
                ],
              ),
            ),
            CupertinoButton(
              child: const Text("Done", style: TextStyle(color: Colors.blue)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
//   return showDialog<bool>(
//     context: context,
//     barrierDismissible: false, // User has to confirm
//     builder: (context) {
//       return AlertDialog(
//         title: const Text('Confirm Account Deletion'),
//         content: const Text(
//           'Are you sure you want to delete your account? This action cannot be undone.',
//           style: TextStyle(fontSize: 14),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Cancel'),
//             onPressed: () {
//               Navigator.of(context).pop(false); // Do nothing
//             },
//           ),
//           TextButton(
//             child: const Text('Delete'),
//             onPressed: () {
//               Navigator.of(context).pop(true); // Proceed to delete
//             },
//           ),
//         ],
//       );
//     },
//   );
// }



Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // User has to confirm
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        title: Column(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
              size: 30,
            ),
            const SizedBox(height: 10),
            const Text(
              'Confirm Account Deletion',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Do nothing
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Proceed to delete
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Red color for the delete button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
