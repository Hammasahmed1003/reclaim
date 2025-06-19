import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/Components/settingComponents/settingComponents.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class Settingscreen extends StatelessWidget {
  const Settingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicWhite,

      ),
      child: Scaffold(
      //  backgroundColor:  Reclaimcolors.BlueSecondary,
        body: SafeArea(
          child: Container(
            decoration:
              BoxDecoration(
              borderRadius: BorderRadius.circular(33),
          gradient: const LinearGradient(
            colors: [Reclaimcolors.BlueSecondary, const Color(0xffffffff)],
            stops:  [0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ), 
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
                  "Settings",
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
            
                  Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
            // Profile Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Replace with actual profile image URL
                width: 70.w,
                height: 70.h,
                fit: BoxFit.cover,
              ),
            ),
            
            SizedBox(width: 12.w),
            
            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jack William",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Lorem ipsum",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            
            // Edit Profile Button
           SpringWidget(
  onTap: () {
                  Get.toNamed(GetRouteNames.Editprofile);
    
    // Handle edit profile action
  },
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: Reclaimcolors.BasicBlue.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      "Edit Profile",
      style: TextStyle(
        fontSize: 12.sp,
        color: Reclaimcolors.BasicBlue,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
), 

const SizedBox(height: 40,)
,


                    ],
                  ),
                ),
Expanded(
  child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          children: [
            SettingComponents(
              title: "Notification",
              iconPath:ReclaimIcon.messages,
              onTap: () {
                  Get.toNamed(GetRouteNames.Notificationscreen);

              },
            ),
            SettingComponents(
              title: "Privacy Policy",
              iconPath: ReclaimIcon.saveIcon,
              onTap: () {

              },
            ),
            SettingComponents(
              title: "Cookies",
             iconPath: ReclaimIcon.handshake,
              onTap: () {},
            ),
            SettingComponents(
              title: "Help",
             iconPath: ReclaimIcon.Settings,
              onTap: () {},
            ),
          ],
        ),
),

              ],
            ),
          ),
        ),
      ),
    );
  }
}