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
    final CreateCommitmentsController controller = Get.put(CreateCommitmentsController());
    return  AnnotatedRegion<SystemUiOverlayStyle>(
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
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    decoration: const BoxDecoration(
                      color:  Reclaimcolors.BasicBlue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        
                      ),
                    ),
                    child: Center(
                      child:Row(
              children: [
                SpringWidget(
                  onTap: (){
            Get.back();
                  },
                  child: SvgPicture.asset(ReclaimIcon.Back)),
              const  Spacer(),
                Text(
                  "Create Commitments",
                  style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Reclaimcolors.BasicWhite,
            fontSize: 22.sp,
                  ),
                ),
              const  Spacer(), 
              ],
            ),
            
                    ) ,
                    ),
            
                    Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
            Text("Title", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
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
                Text("Deadline", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                Text("(Optional)", style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
              ],
            ),
            SizedBox(height: 8.h),
             ReclaimTextField(
              activeBorderColor: Reclaimcolors.BasicBlue,
              filledColor: Reclaimcolors.BasicWhite,
              hintText: "deadline",
              isPassword: false,
              hintColor: Reclaimcolors.BasicBlack.withOpacity(0.35),
              controller: controller.deadlineController,
             ),
            SizedBox(height: 20.h),
            
            Text("Description", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
            SizedBox(height: 8.h),
            TextField(
              controller: controller.descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Message",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Reclaimcolors.BasicBlue),
                  borderRadius: BorderRadius.circular(10.r)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
                      ],
                    ),
                  ),
SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ReclaimButton(
                                    titleColor: Reclaimcolors.BasicWhite,
                                    width: 370.w, height: 48.h, backgroundColor: Reclaimcolors.BasicBlue, title: "Create Commitment", fontWeight: FontWeight.w600, onPressed: (){
                                  
                      Get.back();            
                                   }),
                    ) , 
                  ],
            ),
          ),
        ),
      ),
    );
  }
}