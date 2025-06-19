import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/Components/resourceComponent/resourceComponent.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class ResourceScreen extends StatelessWidget {
  const ResourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> resources = [
      {
        'imageUrl': 'https://images.unsplash.com/photo-1740479049014-274a2c756317?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'How to Avoid Scams for Youth',
        'description': 'Porn is destroying Youth these days ',
      },
      {
        'imageUrl': 'https://images.unsplash.com/photo-1738246559297-919863627d34?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'title': 'No Nude For Months',
        'description': 'Take Lessons and change your life',
      },
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicBlue,
      ),
      child: SafeArea(
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
           
              const  Spacer(),
            Text(
              "Lessons",
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
                        SizedBox(height: 20.h,),

//                         Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Text("Lesson For the Day",  
//       style: TextStyle(fontWeight: FontWeight.bold, 
//       color: Reclaimcolors.BasicBlack, 
//       fontSize: 22.sp
//       ),
//       ),
//     ),
//   ],
// ),
                        SizedBox(height: 20.h,),
              SizedBox(
                height: 300.w,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: resources.length,
                  itemBuilder: (context, index) {
                    return SpringWidget(
                      onTap: (){
                        Get.toNamed(GetRouteNames.Detaillessonscreen);
                      },
                      child: ResourcesComponent(
                        imageUrl:
                        resources[index]['imageUrl']!,
                        title: resources[index]['title']!,
                        description: resources[index]['description']!,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
