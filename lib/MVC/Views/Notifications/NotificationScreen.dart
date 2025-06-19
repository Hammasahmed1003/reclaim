import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/NotificationComponent/NotificationComponents.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class Notificationscreen extends StatelessWidget {
  const Notificationscreen({super.key});

  @override
  Widget build(BuildContext context) {

      final List<Map<String, String>> notifications = [
    {"username": "James William", "timeAgo": "5 minutes ago", "notificationTime": "12:00"},
    {"username": "Alice Brown", "timeAgo": "10 minutes ago", "notificationTime": "11:50"},
    {"username": "Michael Scott", "timeAgo": "15 minutes ago", "notificationTime": "11:45"},
  ];
    return  AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicWhite,

      ),
      child: Scaffold(
        body:  SafeArea(
          child: Container(
               decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33),
          gradient: LinearGradient(
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
                      color:  Reclaimcolors.BasicBlue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        
                      ),
                    ),
                    child: Center(
                      child:Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SpringWidget(
                    onTap: (){
                              Get.back();
                    },
                    child: SvgPicture.asset(ReclaimIcon.Back)),
                ),
              const  Spacer(),
                Text(
                  "Notifications",
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
            SizedBox(height: 10.h,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        
                        shrinkWrap: true,
                        primary: false,
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                                  final item = notifications[index];
                                  return SpringWidget(
                                    onTap: (){

                                    },
                                    child: NotificationComponent(
                                      username: item["username"]!,
                                      timeAgo: item["timeAgo"]!,
                                      notificationTime: item["notificationTime"]!,
                                    ),
                                  );
                      },
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