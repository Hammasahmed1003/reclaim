import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimTextFeild.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/ComunityControllers/AddCommunityController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class Createcommunityscreen extends StatelessWidget {
  const Createcommunityscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddCommunityController controller = Get.put(AddCommunityController());
    return  AnnotatedRegion<SystemUiOverlayStyle>(
         value:   const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicWhite,

      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
               decoration:const BoxDecoration(
        gradient:  LinearGradient(
          colors: [Reclaimcolors.BlueSecondary, const Color(0xffffffff)],
          stops: const [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
            child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF2071F7), // BasicBlue
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset('assets/icons/back.svg'),
                ),
                const Spacer(),
                const Text(
                  "Create Community",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),

          // Description Box
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: controller.descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Write something here....",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Add Pictures",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Add Picture Box
          GestureDetector(
            onTap: controller.pickImage,
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: controller.selectedImage.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            controller.selectedImage.value!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Add Pictures",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          const Spacer(),

          // Post Button
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //   child: SizedBox(
          //     width: double.infinity,
          //     height: 55,
          //     child: ElevatedButton(
          //       onPressed: () {
          //         // Post action here
          //       },
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: const Color(0xFF2071F7),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(30),
          //         ),
          //       ),
          //       child: const Text(
          //         "Posted",
          //         style: TextStyle(fontSize: 18, color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
             child: ReclaimButton(
             
                titleColor: Reclaimcolors.BasicWhite,
                width: 370.w, height: 48.h, backgroundColor: Reclaimcolors.BasicBlue, title: "Posted", fontWeight: FontWeight.w600, onPressed: (){
              
              // Get.toNamed(GetRouteNames.BottomnavbarView);
              
               }),
           ) ,  
          // ReclaimButton(width: width, height: height, backgroundColor: backgroundColor, title: title, fontWeight: fontWeight, onPressed: onPressed)
        ],
      ),
          ),
        )
        ,
      ),
    );
  }
}