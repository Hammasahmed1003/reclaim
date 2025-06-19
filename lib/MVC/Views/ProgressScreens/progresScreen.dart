import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reclaim/Components/CommonComponents/LevelProgressCompo.dart';
import 'package:reclaim/Components/CommonComponents/RankComponent.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
     List<Map<String, String>> users = [
      {"name": "James William", "badge": ReclaimIcon.Badge1 ,  "rank" : ReclaimIcon.Rank1 },
      {"name": "Emily Johnson", "badge": ReclaimIcon.Badge2, "rank" : ReclaimIcon.Rank2 },
      {"name": "Michael Brown", "badge": ReclaimIcon.Badge3, "rank" : ReclaimIcon.Rank3
      },
    ];
  
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicBlue,

      ),
      child: Scaffold(
        backgroundColor: Reclaimcolors.BlueSecondary,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// 👇 Wrap in SizedBox to ensure a visible height
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
                    child:
                    Row(
        children: [
      // SpringWidget(
      //   onTap: (){
      //     Get.back();
      //   },
      //   child: SvgPicture.asset(ReclaimIcon.Back)),
        const  Spacer(),
      Text(
        "Progress",
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
                  
           const     SizedBox(
                  height: 430,
                  // height: MediaQuery.of(context).size.height, // Forces full height
                  child: const LevelProgressTracker(
                    totalLevels: 5,
                    currentLevel: 2,
                  ),
                ),
                Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text("Collect Badges",  
      style: TextStyle(fontWeight: FontWeight.bold, 
      color: Reclaimcolors.BasicBlack, 
      fontSize: 22.sp
      ),
      ),
    ),
  ],
),
SizedBox(height: 10,),
ListView.builder(
  shrinkWrap: T,
  primary: false,
        itemCount: users.length,
        padding: const EdgeInsets.only(top: 20),
        itemBuilder: (context, index) {
          return RankComponent(
            // rank:  users[index]["rank"],
            rank: users[index]["rank"]!,
            // index + 1,
            userName: 
            // "Williams",
             users[index]["name"]!,

            badgeAsset: 
            // ReclaimIcon.Badge1
            users[index]["badge"]!,
          );
        },
      ),
    
              ],
              
            ),
          ),
        ),
      ),
    );
  }
}
