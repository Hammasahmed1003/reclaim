import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class Helpscreen extends StatelessWidget {
  const Helpscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion(
        value:  SystemUiOverlayStyle(
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
                  "Help Support",
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
                    SizedBox(height: 20,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'How can we help you?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            // textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SpringWidget(
                            onTap: (){},
                            child: _helpOption(ReclaimIcon.CallIcon, 'Call')),
                          const SizedBox(height: 12),
                          SpringWidget(
                            onTap: (){},
                            child: _helpOption(ReclaimIcon.messages, 'Email')),
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


 Widget _helpOption(String iconPath, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            // height: 24,
            // width: 24,
            colorFilter: const ColorFilter.mode(Reclaimcolors.BasicBlue, BlendMode.srcIn),
          ),
          const SizedBox(width: 12),
          Text(
            textAlign: TextAlign.start,
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
            SvgPicture.asset(ReclaimIcon.forwardIcon, color:  Reclaimcolors.BasicBlue,),
          // Icon(Icons.arrow_forward_ios, color: Colors.black38, size: 20),
        ],
      ),
    );
  }
