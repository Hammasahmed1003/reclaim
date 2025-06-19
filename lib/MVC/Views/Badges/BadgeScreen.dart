import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class Badgescreen extends StatelessWidget {
  const Badgescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> badges = const [
      {'bg': ReclaimIcon.background, 'badge': ReclaimIcon.Badge1, 'number': ReclaimIcon.Rank1},
      {'bg': ReclaimIcon.background, 'badge': ReclaimIcon.Badge2, 'number': ReclaimIcon.Rank2},
      {'bg': ReclaimIcon.background, 'badge': ReclaimIcon.Badge3, 'number': ReclaimIcon.Rank3},
      {'bg': ReclaimIcon.background, 'badge': ReclaimIcon.badge4, 'number': ReclaimIcon.Rank1},
      {'bg': ReclaimIcon.background, 'badge': ReclaimIcon.Badge1, 'number': ReclaimIcon.Rank1},
      {'bg': ReclaimIcon.background, 'badge': ReclaimIcon.Badge1, 'number': ReclaimIcon.Rank1},
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicWhite,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Reclaimcolors.BlueSecondary, Color(0xffffffff)],
                stops: [0, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                // Top Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Reclaimcolors.BasicBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: SpringWidget(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(ReclaimIcon.Back),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Badge",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Reclaimcolors.BasicWhite,
                            fontSize: 22.sp,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
SizedBox(height: 20,),

                Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text("All Badges",  
      style: TextStyle(fontWeight: FontWeight.bold, 
      color: Reclaimcolors.BasicBlack, 
      fontSize: 22.sp
      ),
      ),
    ),
  ],
),  
SizedBox(height: 20,),
                // Badge List
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ListView.builder(
                      itemCount: badges.length,
                      itemBuilder: (context, index) {
                        return _buildBadgeItem(badges[index]);
                      },
                    ),
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

// Fixed Badge Item with Background in Stack
Widget _buildBadgeItem(Map<String, String> badge) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      border: Border.all(
        color: Reclaimcolors.BasicBlue
      ),
      borderRadius: BorderRadius.circular(2),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.1),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        // Background placed at bottom layer
        Positioned.fill(
          child: SvgPicture.asset(
            badge['bg']!,
            fit: BoxFit.cover,
          ),
        ),
        // Foreground Content
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Number Rank with Background
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(badge['number']!, height: 40),
                ],
              ),
              const SizedBox(width: 12),
              // Badge Text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Lorem Ipsum',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Lorem ipsum dolor sit amet,',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
              const Spacer(),
              // Badge Icon
              SvgPicture.asset(badge['badge']!, height: 30),
            ],
          ),
        ),
      ],
    ),
  );
}
