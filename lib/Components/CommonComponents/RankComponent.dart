import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class RankComponent extends StatelessWidget {
  final String badgeAsset;
  final String userName;
  final String rank;

  const RankComponent({
    super.key,
    required this.rank,
    required this.userName,
    required this.badgeAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank Number
          // Text(
          //   "$rank",
          //   style: const TextStyle(
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.blue,
          //   ),
          // ),
SvgPicture.asset(rank),

          // SvgPicture.asset(ReclaimIcon.Rank1),

          const SizedBox(width: 10),

          // User Avatar
          CircleAvatar(
            // radius: 30,
            backgroundColor:Reclaimcolors.BasicWhite,
            child:  SvgPicture.asset(ReclaimIcon.userIcon, 
            width: 25.w,
            height: 25.h,
            color: Reclaimcolors.BlueSecondary
            )
          ),

          const SizedBox(width: 10),

          // User Name
          Expanded(
            child: Text(
              userName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Badge Icon
          SvgPicture.asset(
            badgeAsset,
            height: 30,
            width: 30,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
