import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimTextFeild.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/EditProfileController/EditProfileController.dart';
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
                    child: _buildInputField("Full Name", "Jon Cena", controller.FullNameController),
                  ),
                  Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 20),

                    child: _buildInputField("Email", "hammasahmed107@gmail.com", controller.EmailController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                   
                    child: _buildGenderPicker(context, controller),
                  ),
                  Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 20),

                    child: _buildInputField("Password", "********", controller.passwordController, isPassword: true),
                  ),
                  SizedBox(height: 5.h),
                 Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Expanded(
        child: ReclaimButton(
          width: double.infinity, // Takes full available space
          height: 47.h,
          backgroundColor: Reclaimcolors.Red.withOpacity(0.15),
          title: "Delete Acc",
          fontWeight: FontWeight.bold,
          onPressed: () {},
          titleColor: Reclaimcolors.Red,
        ),
      ),
      SizedBox(width: 10.w), // Optional spacing
      Expanded(
        child: ReclaimButton(
          width: double.infinity,
          height: 47.h,
          backgroundColor: Reclaimcolors.BasicBlue.withOpacity(0.15),
          title: "LogOut",
          fontWeight: FontWeight.bold,
          onPressed: () {},
          titleColor: Reclaimcolors.BasicBlue,
        ),
      ),
    ],
  ),
),

const SizedBox(height: 20,),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 15,),
  child: ReclaimButton(width: double.infinity, height: 47.h, backgroundColor: Reclaimcolors.BasicBlue, title: "Save", fontWeight: FontWeight.bold, onPressed: (){
    
  }, 
  titleColor: Reclaimcolors.BasicWhite,
  
  
  ),
),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ **Custom AppBar**
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
              child: SvgPicture.asset(ReclaimIcon.Back, 
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

  /// ✅ **Profile Picture Section**
  Widget _buildProfileSection(Editprofilecontroller controller) {
    return  
 GestureDetector(
                  onTap: (){
                    // controller.pickImage(source: ImageSource.camera);
            
                  },
                  child: Obx(
                    () => Row(
                      children: [
                        Container(
              width: 89.w, // Same as radius * 2 from CircleAvatar
              height: 85.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // shape: BoxShape.circle,
                color: Reclaimcolors.BlueSecondary,
                image:
                controller.selectedImage.value != null
                    ? DecorationImage(
                        image: FileImage(controller.selectedImage.value!),
                        fit: BoxFit.cover,
                      )
                    : null,
                  
             
              ),
              child: 
            controller.selectedImage.value == null
                  ? Center(
                      child: SvgPicture.asset(
                        ReclaimIcon.userIcon,
                        color: Reclaimcolors.BasicBlue,
                      ),
                    )
                  : null,
            ),
                        // CircleAvatar(
                        //   radius: 40,
                        //   backgroundColor: BankathColors.LightGreen,
                        //   backgroundImage: controller.selectedImage.value != null ? FileImage(controller.selectedImage.value!) : null,
                        //   child: controller.selectedImage.value == null
                        //       ? Icon(Icons.camera_alt, color: Colors.white, size: 40)
                        //       : null,
                        // ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Upload Your Picture', style: TextStyle(color: Reclaimcolors.BasicBlack, fontSize: 18.sp, 
                    fontWeight: FontWeight.w400
                                
                    )),
                    SizedBox(height: 10.h,),
                      Text(' (Optional)', style: TextStyle(color:Reclaimcolors.BasicBlack, fontSize: 13.sp, 
                    fontWeight: FontWeight.w400
                                
                    )),
                  ],
                ),
            
                      ],
                    ), 
                  ),
                );
    
    // SpringWidget(
    //   onTap: () {
    //     // Implement Image Picker Logic
    //   },
    //   child: Obx(
    //     () => Column(
    //       children: [
    //         Container(
    //           width: 90.w,
    //           height: 90.h,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(10),
    //             color: Reclaimcolors.BlueSecondary,
    //             image: controller.selectedImage.value != null
    //                 ? DecorationImage(
    //                     image: FileImage(controller.selectedImage.value!),
    //                     fit: BoxFit.cover,
    //                   )
    //                 : null,
    //           ),
    //           child: controller.selectedImage.value == null
    //               ? Center(
    //                   child: SvgPicture.asset(
    //                     ReclaimIcon.userIcon,
    //                     color: Reclaimcolors.BasicBlue,
    //                   ),
    //                 )
    //               : null,
    //         ),
    //         SizedBox(height: 10.h),
    //         Text(
    //           'Upload Your Picture',
    //           style: TextStyle(
    //             fontSize: 18.sp,
    //             fontWeight: FontWeight.w400,
    //             color: Reclaimcolors.BasicBlack,
    //           ),
    //         ),
    //         Text(
    //           '(Optional)',
    //           style: TextStyle(
    //             fontSize: 13.sp,
    //             fontWeight: FontWeight.w400,
    //             color: Reclaimcolors.BasicBlack,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  /// ✅ **Reusable Input Field**
  Widget _buildInputField(String label, String hint, TextEditingController controller, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Reclaimcolors.BasicBlack,
          ),
        ),
        SizedBox(height: 5.h),
        ReclaimTextField(
          activeBorderColor: Reclaimcolors.BasicBlue,
          filledColor: Reclaimcolors.BasicWhite,
          hintText: hint,
          isPassword: isPassword,
          hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
          controller: controller,
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  /// ✅ **Gender Picker**
  Widget _buildGenderPicker(BuildContext context, Editprofilecontroller controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Reclaimcolors.BasicBlack,
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

  /// ✅ **Show Gender Picker**
  void _showGenderPicker(BuildContext context, Editprofilecontroller controller) {
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
                  final genders = ["Male", "Female", "Other"];
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
